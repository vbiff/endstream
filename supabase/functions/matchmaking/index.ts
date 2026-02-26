import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { createAdminClient, getUserId } from "../_shared/supabase-client.ts";
import { GAME_CONSTANTS } from "../_shared/constants.ts";
import { validateDeck } from "../_shared/deck-validator.ts";
import { initializeGame, buildClientResponse } from "../_shared/state-machine.ts";
import {
  errorResponse,
  GameRuleError,
  NotFoundError,
  ValidationError,
} from "../_shared/errors.ts";
import type { Card, DeckCardEntry } from "../_shared/types.ts";

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
    const { deck_id } = await req.json();
    if (!deck_id) throw new ValidationError("deck_id is required");

    const admin = createAdminClient();

    // Verify deck ownership
    const { data: deck } = await admin
      .from("decks")
      .select("owner_id")
      .eq("id", deck_id)
      .single();
    if (!deck || deck.owner_id !== userId) {
      throw new ValidationError("Not your deck");
    }

    // Get player rank
    const { data: player } = await admin
      .from("players")
      .select("rank")
      .eq("id", userId)
      .single();
    const playerRank = player?.rank ?? 1000;

    // Look for existing match within rank range
    const { data: matches } = await admin
      .from("matchmaking_queue")
      .select("player_id, deck_id, rank")
      .neq("player_id", userId)
      .gte("rank", playerRank - GAME_CONSTANTS.MATCHMAKING_RANK_RANGE)
      .lte("rank", playerRank + GAME_CONSTANTS.MATCHMAKING_RANK_RANGE)
      .order("queued_at", { ascending: true })
      .limit(1);

    if (matches && matches.length > 0) {
      // Found a match! Create a game
      const opponent = matches[0];

      // Remove both from queue
      await admin
        .from("matchmaking_queue")
        .delete()
        .in("player_id", [userId, opponent.player_id]);

      // Load both decks
      const [myDeckCards, opDeckCards, cards] = await Promise.all([
        admin.from("deck_cards").select("card_id, quantity").eq("deck_id", deck_id),
        admin.from("deck_cards").select("card_id, quantity").eq("deck_id", opponent.deck_id),
        admin.from("cards").select("*"),
      ]);

      const cardCatalog = new Map<string, Card>(
        (cards.data ?? []).map((c: Card) => [c.id, c]),
      );

      // Validate both decks
      const myValidation = validateDeck(
        (myDeckCards.data ?? []) as DeckCardEntry[],
        (cards.data ?? []) as Card[],
      );
      if (!myValidation.valid) {
        throw new GameRuleError(`Your deck is invalid: ${myValidation.errors.join(", ")}`);
      }

      const opValidation = validateDeck(
        (opDeckCards.data ?? []) as DeckCardEntry[],
        (cards.data ?? []) as Card[],
      );
      if (!opValidation.valid) {
        // Opponent's deck became invalid somehow — remove them from queue, re-queue self
        await admin.from("matchmaking_queue").upsert({
          player_id: userId,
          deck_id: deck_id,
          rank: playerRank,
        });
        return new Response(
          JSON.stringify({ status: "queued", message: "Match found but opponent deck invalid, re-queued" }),
          { headers: { ...corsHeaders, "Content-Type": "application/json" } },
        );
      }

      // Expand decks
      const myExpandedDeck = expandDeck((myDeckCards.data ?? []) as DeckCardEntry[]);
      const opExpandedDeck = expandDeck((opDeckCards.data ?? []) as DeckCardEntry[]);

      // Create game
      const { data: gameRow, error: gameErr } = await admin
        .from("games")
        .insert({
          player_1_id: userId,
          player_2_id: opponent.player_id,
          status: "active",
          current_turn: 1,
          active_player_id: userId,
        })
        .select()
        .single();
      if (gameErr) throw new Error(`Failed to create game: ${gameErr.message}`);

      const gameState = initializeGame(
        gameRow.id,
        userId,
        opponent.player_id,
        myExpandedDeck,
        opExpandedDeck,
        cardCatalog,
      );

      // Write all state to DB
      const gameId = gameRow.id;
      const opId = opponent.player_id;

      await Promise.all([
        admin.from("game_streams").insert([
          { game_id: gameId, player_id: userId, stream_data: gameState.streams[userId] },
          { game_id: gameId, player_id: opId, stream_data: gameState.streams[opId] },
        ]),
        admin.from("game_hands").insert([
          { game_id: gameId, player_id: userId, hand_data: gameState.hands[userId] },
          { game_id: gameId, player_id: opId, hand_data: gameState.hands[opId] },
        ]),
        admin.from("game_draw_piles").insert([
          { game_id: gameId, player_id: userId, pile_data: gameState.drawPiles[userId] },
          { game_id: gameId, player_id: opId, pile_data: gameState.drawPiles[opId] },
        ]),
        admin.from("game_controllers").insert([
          { game_id: gameId, player_id: userId, hp: gameState.controllers[userId].hp, max_hp: gameState.controllers[userId].maxHp },
          { game_id: gameId, player_id: opId, hp: gameState.controllers[opId].hp, max_hp: gameState.controllers[opId].maxHp },
        ]),
        admin.from("game_player_state").insert([
          { game_id: gameId, player_id: userId, action_points: gameState.actionPoints[userId].current, max_action_points: gameState.actionPoints[userId].max },
          { game_id: gameId, player_id: opId, action_points: gameState.actionPoints[opId].current, max_action_points: gameState.actionPoints[opId].max },
        ]),
      ]);

      const response = buildClientResponse(gameState, userId, cardCatalog);

      return new Response(
        JSON.stringify({ status: "matched", game: response }),
        { status: 201, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    } else {
      // No match found — add to queue
      const { error: queueErr } = await admin
        .from("matchmaking_queue")
        .upsert({
          player_id: userId,
          deck_id: deck_id,
          rank: playerRank,
        });
      if (queueErr) throw new Error(`Failed to queue: ${queueErr.message}`);

      return new Response(
        JSON.stringify({ status: "queued" }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }
  } catch (err) {
    return errorResponse(err, corsHeaders);
  }
});

function expandDeck(deckCards: DeckCardEntry[]): string[] {
  const expanded: string[] = [];
  for (const dc of deckCards) {
    const qty = Math.max(0, Math.min(dc.quantity, 2));
    for (let i = 0; i < qty; i++) {
      expanded.push(dc.card_id);
    }
  }
  return expanded;
}
