import { createClient, SupabaseClient } from "https://esm.sh/@supabase/supabase-js@2";
import { AuthError } from "./errors.ts";

/** Create a Supabase client authenticated as the requesting user. */
export function createUserClient(req: Request): SupabaseClient {
  const authHeader = req.headers.get("Authorization");
  if (!authHeader) throw new AuthError("Missing Authorization header");

  return createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    {
      global: { headers: { Authorization: authHeader } },
      auth: { persistSession: false },
    },
  );
}

/** Create a Supabase client with service role (full DB access, bypasses RLS). */
export function createAdminClient(): SupabaseClient {
  return createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    { auth: { persistSession: false } },
  );
}

/** Extract the authenticated user ID from a request. Throws on failure. */
export async function getUserId(req: Request): Promise<string> {
  const client = createUserClient(req);
  const { data, error } = await client.auth.getUser();
  if (error || !data.user) throw new AuthError("Invalid or expired token");
  return data.user.id;
}
