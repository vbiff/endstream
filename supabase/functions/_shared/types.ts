// ── Enums (match Postgres enum values exactly) ──────────────────────

export type CardType = "operator" | "tactic" | "event" | "equipment";
export type CardRarity = "common" | "rare" | "epic" | "legendary";
export type GameStatus = "active" | "completed" | "abandoned";
export type ActionType = "play_card" | "move" | "attack" | "ability" | "end_turn";
export type FriendshipStatus = "pending" | "accepted";
export type ChallengeStatus = "pending" | "accepted" | "declined" | "expired";

// ── Board geometry ──────────────────────────────────────────────────

export interface StreamPosition {
  stream: 0 | 1;
  centuryIndex: number; // 0–5
}

// ── Status effects ──────────────────────────────────────────────────

export interface StatusEffect {
  type: string; // e.g. "surge_protocol", "lockdown", "expose", "atk_buff"
  value?: number;
  turnsRemaining: number;
  sourcePlayerId: string;
}

// ── Operator instance (on the board) ────────────────────────────────

export interface OperatorInstance {
  instanceId: string; // unique per game instance (UUID)
  operatorCardId: string; // FK → cards.id
  ownerId: string; // FK → players.id
  currentHp: number;
  maxHp: number;
  attack: number;
  position: StreamPosition;
  statusEffects: StatusEffect[];
  hasActedThisTurn: boolean;
  equipmentCardIds: string[];
}

// ── Turnpoint active effects (events on the board) ──────────────────

export interface TurnpointEffect {
  type: string; // "dead_century" | "temporal_haven" | "stream_collapse"
  sourceCardId: string;
  sourcePlayerId: string;
  turnsRemaining: number;
}

// ── Turnpoint ───────────────────────────────────────────────────────

export interface Turnpoint {
  centuryIndex: number; // 0–5
  operators: OperatorInstance[];
  activeEffects: TurnpointEffect[];
  controllerPresent: boolean;
}

// ── Stream (one player's side of the board) ─────────────────────────

export type Stream = Turnpoint[];

// ── Card (from DB) ──────────────────────────────────────────────────

export interface Card {
  id: string;
  name: string;
  type: CardType;
  cost: number;
  rarity: CardRarity;
  text: string | null;
  flavor_text?: string | null;
  art_asset_path?: string | null;
  hp: number | null;
  attack: number | null;
}

// ── Ability (from DB) ───────────────────────────────────────────────

export interface Ability {
  id: string;
  card_id: string;
  name: string;
  description: string | null;
  cost: number;
}

// ── Game action (client → server) ───────────────────────────────────

export interface GameAction {
  type: ActionType;
  /** Card ID when playing a card, operator instanceId when moving/attacking/ability */
  sourceId?: string;
  /** Target position, operator instanceId, or card ID depending on action */
  target?: {
    position?: StreamPosition;
    operatorInstanceId?: string;
    abilityId?: string;
  };
}

// ── Full server-side game state (never sent to client as-is) ────────

export interface ServerGameState {
  game: {
    id: string;
    player_1_id: string;
    player_2_id: string;
    status: GameStatus;
    winner_id: string | null;
    current_turn: number;
    active_player_id: string;
  };
  streams: Record<string, Stream>; // keyed by player_id
  hands: Record<string, string[]>; // keyed by player_id → card IDs
  drawPiles: Record<string, string[]>; // keyed by player_id → card IDs
  actionPoints: Record<string, { current: number; max: number }>;
  controllers: Record<string, { hp: number; maxHp: number }>;
}

// ── Client response (sent back after actions) ───────────────────────

export interface ClientGameStateResponse {
  game: {
    id: string;
    status: GameStatus;
    current_turn: number;
    active_player_id: string;
    winner_id: string | null;
  };
  myStream: Stream;
  opponentStream: Stream;
  myHand: Card[];
  handSize: number;
  opponentHandSize: number;
  actionPoints: number;
  maxActionPoints: number;
  myControllerId: string;
  myControllerHp: number;
  opponentControllerHp: number;
  myPlayerId: string;
  opponentPlayerId: string;
  lastAction?: {
    type: ActionType;
    result?: Record<string, unknown>;
  };
}

// ── Action result (returned from processAction) ─────────────────────

export interface ActionResult {
  success: boolean;
  description: string;
  changes?: Record<string, unknown>;
}

// ── Deck validation ─────────────────────────────────────────────────

export interface DeckValidationResult {
  valid: boolean;
  errors: string[];
}

// ── Deck card entry (from deck_cards join) ──────────────────────────

export interface DeckCardEntry {
  card_id: string;
  quantity: number;
}
