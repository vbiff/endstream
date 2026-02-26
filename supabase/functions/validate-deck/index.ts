import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { createAdminClient, getUserId } from "../_shared/supabase-client.ts";
import { validateDeck } from "../_shared/deck-validator.ts";
import { errorResponse, NotFoundError, ValidationError } from "../_shared/errors.ts";

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const userId = await getUserId(req);
    const { deck_id } = await req.json();
    if (!deck_id) throw new ValidationError("deck_id is required");

    const admin = createAdminClient();

    // Fetch deck and verify ownership
    const { data: deck, error: deckErr } = await admin
      .from("decks")
      .select("id, owner_id")
      .eq("id", deck_id)
      .single();
    if (deckErr || !deck) throw new NotFoundError("Deck not found");
    if (deck.owner_id !== userId) throw new ValidationError("Not your deck");

    // Fetch deck cards
    const { data: deckCards } = await admin
      .from("deck_cards")
      .select("card_id, quantity")
      .eq("deck_id", deck_id);

    // Fetch full card catalog
    const { data: cards } = await admin.from("cards").select("*");

    const result = validateDeck(deckCards ?? [], cards ?? []);

    // Update deck validity flag
    await admin
      .from("decks")
      .update({ is_valid: result.valid })
      .eq("id", deck_id);

    return new Response(JSON.stringify(result), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err) {
    return errorResponse(err);
  }
});
