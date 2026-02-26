export class AuthError extends Error {
  readonly status = 401;
  constructor(message = "Unauthorized") {
    super(message);
    this.name = "AuthError";
  }
}

export class ValidationError extends Error {
  readonly status = 400;
  constructor(message: string) {
    super(message);
    this.name = "ValidationError";
  }
}

export class GameRuleError extends Error {
  readonly status = 422;
  constructor(message: string) {
    super(message);
    this.name = "GameRuleError";
  }
}

export class NotFoundError extends Error {
  readonly status = 404;
  constructor(message: string) {
    super(message);
    this.name = "NotFoundError";
  }
}

/** Build a JSON error response from any thrown error. */
export function errorResponse(err: unknown): Response {
  if (
    err instanceof AuthError ||
    err instanceof ValidationError ||
    err instanceof GameRuleError ||
    err instanceof NotFoundError
  ) {
    return new Response(
      JSON.stringify({ error: err.name, message: err.message }),
      { status: err.status, headers: { "Content-Type": "application/json" } },
    );
  }
  console.error("Unhandled error:", err);
  return new Response(
    JSON.stringify({ error: "InternalError", message: "Internal server error" }),
    { status: 500, headers: { "Content-Type": "application/json" } },
  );
}
