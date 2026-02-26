import { createAdminClient } from "./supabase-client.ts";

interface PushPayload {
  title: string;
  body: string;
  data?: Record<string, string>;
}

/**
 * Send a push notification to a specific player.
 * Fetches their device tokens and sends via FCM HTTP v1 API.
 */
export async function sendPushToPlayer(
  playerId: string,
  payload: PushPayload,
): Promise<void> {
  const admin = createAdminClient();

  const { data: tokens } = await admin
    .from("device_tokens")
    .select("id, token, platform")
    .eq("player_id", playerId);

  if (!tokens || tokens.length === 0) return;

  const fcmKey = Deno.env.get("FCM_SERVER_KEY");
  if (!fcmKey) {
    console.warn("FCM_SERVER_KEY not set, skipping push notification");
    return;
  }

  const invalidTokenIds: string[] = [];

  for (const { id, token } of tokens) {
    try {
      const res = await fetch("https://fcm.googleapis.com/fcm/send", {
        method: "POST",
        headers: {
          Authorization: `key=${fcmKey}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          to: token,
          notification: {
            title: payload.title,
            body: payload.body,
          },
          data: payload.data ?? {},
        }),
      });

      if (res.ok) {
        const result = await res.json();
        // Check for invalid token response
        if (result.failure > 0) {
          const err = result.results?.[0]?.error;
          if (
            err === "NotRegistered" ||
            err === "InvalidRegistration"
          ) {
            invalidTokenIds.push(id);
          }
        }
      }
    } catch (err) {
      console.error(`Failed to send push to token ${id}:`, err);
    }
  }

  // Cleanup invalid tokens
  if (invalidTokenIds.length > 0) {
    const { error: deleteErr } = await admin
      .from("device_tokens")
      .delete()
      .in("id", invalidTokenIds);
    if (deleteErr) {
      console.error("Failed to cleanup invalid tokens:", deleteErr.message);
    }
  }
}

/**
 * Send a "your turn" notification to a player.
 */
export async function sendYourTurnNotification(
  playerId: string,
  gameId: string,
): Promise<void> {
  await sendPushToPlayer(playerId, {
    title: "EndStream",
    body: "It's your turn!",
    data: { type: "your_turn", game_id: gameId },
  });
}
