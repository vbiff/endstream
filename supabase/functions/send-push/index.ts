import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { getUserId } from "../_shared/supabase-client.ts";
import { sendPushToPlayer } from "../_shared/push-sender.ts";
import { errorResponse, ValidationError } from "../_shared/errors.ts";

/**
 * send-push Edge Function
 * Triggered externally (e.g., pg_cron for turn reminders) or by other functions.
 * Requires service role auth or a valid user token.
 *
 * Body: { player_id, title, body, data? }
 */
Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // Verify caller is authenticated
    await getUserId(req);

    const { player_id, title, body, data } = await req.json();
    if (!player_id) throw new ValidationError("player_id is required");
    if (!title || !body) throw new ValidationError("title and body are required");

    await sendPushToPlayer(player_id, { title, body, data });

    return new Response(
      JSON.stringify({ success: true }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  } catch (err) {
    return errorResponse(err);
  }
});
