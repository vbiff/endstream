import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { createAdminClient, getUserId } from "../_shared/supabase-client.ts";
import { errorResponse, GameRuleError, NotFoundError, ValidationError } from "../_shared/errors.ts";

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
    const { game_id } = await req.json();
    if (!game_id) throw new ValidationError("game_id is required");

    const admin = createAdminClient();

    // Fetch game
    const { data: game, error: gameErr } = await admin
      .from("games")
      .select("id, player_1_id, player_2_id, status")
      .eq("id", game_id)
      .single();
    if (gameErr || !game) throw new NotFoundError("Game not found");

    // Verify participant
    const isPlayer1 = game.player_1_id === userId;
    const isPlayer2 = game.player_2_id === userId;
    if (!isPlayer1 && !isPlayer2) {
      throw new ValidationError("You are not a participant in this game");
    }

    // Verify game is active
    if (game.status !== "active") {
      throw new GameRuleError("Game is not active");
    }

    // Set winner to the other player
    const winnerId = isPlayer1 ? game.player_2_id : game.player_1_id;

    // Update game atomically
    const { error: rpcErr } = await admin.rpc("update_game_state", {
      p_game_id: game_id,
      p_game_updates: { status: "completed", winner_id: winnerId },
      p_action_record: {
        turn: 0,
        player_id: userId,
        type: "end_turn",
        source: { reason: "concede" },
        target: null,
        result: { winner_id: winnerId },
      },
    });
    if (rpcErr) throw new Error(`Failed to update game state: ${rpcErr.message}`);

    return new Response(
      JSON.stringify({
        game_id,
        status: "completed",
        winner_id: winnerId,
        conceded_by: userId,
      }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  } catch (err) {
    return errorResponse(err, corsHeaders);
  }
});
