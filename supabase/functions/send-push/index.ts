import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { getUserId } from "../_shared/supabase-client.ts";
import { sendPushToPlayer } from "../_shared/push-sender.ts";
import { AuthError, errorResponse, ValidationError } from "../_shared/errors.ts";

/**
 * send-push Edge Function
 *
 * Accepts two auth modes:
 * 1. User JWT (normal client calls) — validated via getUserId()
 * 2. Cron secret header (pg_cron calls via pg_net) — validated via x-cron-secret
 *
 * Body: { player_id, title, body, data? }
 */
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
    // Authenticate: user JWT or cron secret
    let isAuthorized = false;

    try {
      await getUserId(req);
      isAuthorized = true;
    } catch {
      // User auth failed — check for cron secret
      const cronSecret = req.headers.get("x-cron-secret");
      const expectedSecret = Deno.env.get("CRON_SECRET");
      if (cronSecret && expectedSecret && cronSecret === expectedSecret) {
        isAuthorized = true;
      }
    }

    if (!isAuthorized) {
      throw new AuthError("Unauthorized");
    }

    const { player_id, title, body, data } = await req.json();
    if (!player_id) throw new ValidationError("player_id is required");
    if (!title || !body) throw new ValidationError("title and body are required");

    await sendPushToPlayer(player_id, { title, body, data });

    return new Response(
      JSON.stringify({ success: true }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  } catch (err) {
    return errorResponse(err, corsHeaders);
  }
});
