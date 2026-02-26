import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { createAdminClient, getUserId } from "../_shared/supabase-client.ts";
import { validateDeck } from "../_shared/deck-validator.ts";
import { initializeGame, buildClientResponse } from "../_shared/state-machine.ts";
import {
  errorResponse,
  GameRuleError,
  NotFoundError,
  ValidationError,
} from "../_shared/errors.ts";
import { LOCAL_OPPONENT_ID } from "../_shared/constants.ts";
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
    const body = await req.json();
    const { deck_id, opponent_type, friend_id } = body;

    if (!deck_id) throw new ValidationError("deck_id is required");
    if (!opponent_type || !["local", "friend", "random"].includes(opponent_type)) {
      throw new ValidationError("opponent_type must be 'local', 'friend', or 'random'");
    }

    const admin = createAdminClient();

    // For random matchmaking, redirect
    if (opponent_type === "random") {
      // Insert into matchmaking queue instead
      throw new ValidationError(
        "Use the matchmaking endpoint for random opponents",
      );
    }

    // Determine opponent
    let opponentId: string;
    if (opponent_type === "local") {
      opponentId = LOCAL_OPPONENT_ID;
    } else {
      // friend
      if (!friend_id) throw new ValidationError("friend_id required for friend games");
      opponentId = friend_id;

      // Verify friendship exists
      const { data: friendship } = await admin
        .from("friendships")
        .select("status")
        .or(
          `and(player_id.eq.${userId},friend_id.eq.${opponentId}),and(player_id.eq.${opponentId},friend_id.eq.${userId})`,
        )
        .eq("status", "accepted")
        .limit(1)
        .single();
      if (!friendship) {
        throw new GameRuleError("You must be friends to challenge this player");
      }
    }

    // Load and validate deck
    const { data: deckCards } = await admin
      .from("deck_cards")
      .select("card_id, quantity")
      .eq("deck_id", deck_id);
    if (!deckCards || deckCards.length === 0) {
      throw new NotFoundError("Deck not found or empty");
    }

    // Verify deck ownership
    const { data: deck } = await admin
      .from("decks")
      .select("owner_id")
      .eq("id", deck_id)
      .single();
    if (!deck || deck.owner_id !== userId) {
      throw new ValidationError("Not your deck");
    }

    // Load card catalog
    const { data: cards } = await admin.from("cards").select("*");
    if (!cards || cards.length === 0) throw new NotFoundError("Card catalog not available");
    const cardCatalog = new Map<string, Card>(
      cards.map((c: Card) => [c.id, c]),
    );

    // Validate deck
    const validation = validateDeck(deckCards as DeckCardEntry[], cards as Card[]);
    if (!validation.valid) {
      throw new GameRuleError(`Invalid deck: ${validation.errors.join(", ")}`);
    }

    // Expand deck cards to flat array
    const expandedDeck: string[] = [];
    for (const dc of deckCards as DeckCardEntry[]) {
      const qty = Math.max(0, Math.min(dc.quantity, 2));
      for (let i = 0; i < qty; i++) {
        expandedDeck.push(dc.card_id);
      }
    }

    // For local games, opponent uses same deck
    const opponentDeck = opponent_type === "local"
      ? [...expandedDeck]
      : expandedDeck; // In friend games, for now use same deck (opponent deck validation TODO)

    // Create game row
    const { data: gameRow, error: gameErr } = await admin
      .from("games")
      .insert({
        player_1_id: userId,
        player_2_id: opponentId,
        status: "active",
        current_turn: 1,
        active_player_id: userId,
        game_mode: opponent_type === "local" ? "local" : "online",
      })
      .select()
      .single();
    if (gameErr) throw new Error(`Failed to create game: ${gameErr.message}`);

    // Initialize game state
    const gameState = initializeGame(
      gameRow.id,
      userId,
      opponentId,
      expandedDeck,
      opponentDeck,
      cardCatalog,
    );

    // Write all state to DB
    const gameId = gameRow.id;

    // Insert streams
    const { error: streamsErr } = await admin.from("game_streams").insert([
      { game_id: gameId, player_id: userId, stream_data: gameState.streams[userId] },
      { game_id: gameId, player_id: opponentId, stream_data: gameState.streams[opponentId] },
    ]);
    if (streamsErr) throw new Error(`Failed to insert streams: ${streamsErr.message}`);

    // Insert hands
    const { error: handsErr } = await admin.from("game_hands").insert([
      { game_id: gameId, player_id: userId, hand_data: gameState.hands[userId] },
      { game_id: gameId, player_id: opponentId, hand_data: gameState.hands[opponentId] },
    ]);
    if (handsErr) throw new Error(`Failed to insert hands: ${handsErr.message}`);

    // Insert draw piles
    const { error: pilesErr } = await admin.from("game_draw_piles").insert([
      { game_id: gameId, player_id: userId, pile_data: gameState.drawPiles[userId] },
      { game_id: gameId, player_id: opponentId, pile_data: gameState.drawPiles[opponentId] },
    ]);
    if (pilesErr) throw new Error(`Failed to insert draw piles: ${pilesErr.message}`);

    // Insert controllers
    const { error: ctrlErr } = await admin.from("game_controllers").insert([
      {
        game_id: gameId,
        player_id: userId,
        hp: gameState.controllers[userId].hp,
        max_hp: gameState.controllers[userId].maxHp,
      },
      {
        game_id: gameId,
        player_id: opponentId,
        hp: gameState.controllers[opponentId].hp,
        max_hp: gameState.controllers[opponentId].maxHp,
      },
    ]);
    if (ctrlErr) throw new Error(`Failed to insert controllers: ${ctrlErr.message}`);

    // Insert player state
    const { error: psErr } = await admin.from("game_player_state").insert([
      {
        game_id: gameId,
        player_id: userId,
        action_points: gameState.actionPoints[userId].current,
        max_action_points: gameState.actionPoints[userId].max,
      },
      {
        game_id: gameId,
        player_id: opponentId,
        action_points: gameState.actionPoints[opponentId].current,
        max_action_points: gameState.actionPoints[opponentId].max,
      },
    ]);
    if (psErr) throw new Error(`Failed to insert player state: ${psErr.message}`);

    // Build client response
    const response = buildClientResponse(gameState, userId, cardCatalog);

    return new Response(JSON.stringify(response), {
      status: 201,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err) {
    return errorResponse(err, corsHeaders);
  }
});
