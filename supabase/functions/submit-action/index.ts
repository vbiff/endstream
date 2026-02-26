import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { createAdminClient, getUserId } from "../_shared/supabase-client.ts";
import { loadGameState, processAction, buildClientResponse, checkWinConditions } from "../_shared/state-machine.ts";
import { sendYourTurnNotification } from "../_shared/push-sender.ts";
import {
  errorResponse,
  GameRuleError,
  NotFoundError,
  ValidationError,
} from "../_shared/errors.ts";
import { LOCAL_OPPONENT_ID } from "../_shared/constants.ts";
import type { Ability, Card, GameAction } from "../_shared/types.ts";

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (req.method !== "POST") {
    return new Response(
      JSON.stringify({ error: "MethodNotAllowed", message: "Only POST is allowed" }),
      { status: 405, headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  }

  try {
    const userId = await getUserId(req);
    const body = await req.json();
    const { game_id, action } = body as { game_id: string; action: GameAction };

    if (!game_id) throw new ValidationError("game_id is required");
    if (!action?.type) throw new ValidationError("action with type is required");

    const admin = createAdminClient();

    // Load full game state from 6 tables in parallel
    const [
      { data: game, error: gameErr },
      { data: streams, error: streamsErr },
      { data: hands, error: handsErr },
      { data: drawPiles, error: drawPilesErr },
      { data: controllers, error: controllersErr },
      { data: playerStates, error: playerStatesErr },
      { data: cards, error: cardsErr },
      { data: abilities, error: abilitiesErr },
    ] = await Promise.all([
      admin.from("games").select("*").eq("id", game_id).single(),
      admin.from("game_streams").select("*").eq("game_id", game_id),
      admin.from("game_hands").select("*").eq("game_id", game_id),
      admin.from("game_draw_piles").select("*").eq("game_id", game_id),
      admin.from("game_controllers").select("*").eq("game_id", game_id),
      admin.from("game_player_state").select("*").eq("game_id", game_id),
      admin.from("cards").select("*"),
      admin.from("abilities").select("*"),
    ]);

    if (gameErr || !game) throw new NotFoundError("Game not found");
    const loadErr = streamsErr || handsErr || drawPilesErr || controllersErr || playerStatesErr || cardsErr || abilitiesErr;
    if (loadErr) throw new Error(`Failed to load game data: ${loadErr.message}`);

    // Verify participant
    const isLocalGame = game.game_mode === "local";
    if (!isLocalGame && game.player_1_id !== userId && game.player_2_id !== userId) {
      throw new ValidationError("You are not a participant in this game");
    }
    if (isLocalGame && game.player_1_id !== userId) {
      throw new ValidationError("You are not the host of this local game");
    }

    // For local games, the authenticated user acts as whichever player is active
    const effectivePlayerId = isLocalGame ? game.active_player_id : userId;

    // Build card and ability catalogs
    const cardCatalog = new Map<string, Card>(
      (cards ?? []).map((c: Card) => [c.id, c]),
    );
    const abilityMap = new Map<string, Ability>(
      (abilities ?? []).map((a: Ability) => [a.id, a]),
    );

    // Load server game state
    const state = loadGameState(
      game,
      streams ?? [],
      hands ?? [],
      drawPiles ?? [],
      controllers ?? [],
      playerStates ?? [],
    );

    // Process the action (validates internally)
    const result = processAction(state, action, effectivePlayerId, cardCatalog, abilityMap);

    if (!result.success) {
      throw new GameRuleError(result.description);
    }

    // Build DB update params for atomic write
    const updateParams: Record<string, unknown> = {
      p_game_id: game_id,
      p_game_updates: {
        status: state.game.status,
        winner_id: state.game.winner_id,
        current_turn: state.game.current_turn,
        active_player_id: state.game.active_player_id,
      },
      p_stream_updates: Object.entries(state.streams).map(([pid, data]) => ({
        player_id: pid,
        stream_data: data,
      })),
      p_hand_updates: Object.entries(state.hands).map(([pid, data]) => ({
        player_id: pid,
        hand_data: data,
      })),
      p_draw_pile_updates: Object.entries(state.drawPiles).map(([pid, data]) => ({
        player_id: pid,
        pile_data: data,
      })),
      p_controller_updates: Object.entries(state.controllers).map(([pid, data]) => ({
        player_id: pid,
        hp: data.hp,
        max_hp: data.maxHp,
      })),
      p_player_state_updates: Object.entries(state.actionPoints).map(([pid, data]) => ({
        player_id: pid,
        action_points: data.current,
        max_action_points: data.max,
      })),
      p_action_record: {
        turn: state.game.current_turn,
        player_id: effectivePlayerId,
        type: action.type,
        source: action.sourceId ? { sourceId: action.sourceId } : null,
        target: action.target ?? null,
        result: result.changes ?? null,
      },
    };

    // Atomic write
    const { error: rpcErr } = await admin.rpc("update_game_state", updateParams);
    if (rpcErr) {
      console.error("RPC error:", rpcErr);
      throw new Error(`Failed to update game state: ${rpcErr.message}`);
    }

    // Send push notification if turn ended (skip for local games)
    if (action.type === "end_turn" && state.game.status === "active" && !isLocalGame) {
      const opponentId = state.game.active_player_id; // After turn switch
      // Fire and forget — don't block response on push delivery
      sendYourTurnNotification(opponentId, game_id).catch((err) =>
        console.error("Push notification failed:", err),
      );
    }

    // Build client response — for local games, show the new active player's perspective
    const responsePlayerId = isLocalGame ? state.game.active_player_id : userId;
    const response = buildClientResponse(
      state,
      responsePlayerId,
      cardCatalog,
      { type: action.type, result: result.changes as Record<string, unknown> },
    );

    return new Response(JSON.stringify(response), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err) {
    return errorResponse(err, corsHeaders);
  }
});
