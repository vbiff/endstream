import { GAME_CONSTANTS } from "./constants.ts";
import { GameRuleError } from "./errors.ts";
import type {
  Card,
  GameAction,
  OperatorInstance,
  ServerGameState,
  StreamPosition,
  Turnpoint,
} from "./types.ts";

/** Check if two positions are adjacent (same stream ±1 century, or same century other stream). */
export function isAdjacent(a: StreamPosition, b: StreamPosition): boolean {
  if (a.stream === b.stream) {
    return Math.abs(a.centuryIndex - b.centuryIndex) === 1;
  }
  return a.centuryIndex === b.centuryIndex;
}

/** Check if a turnpoint has a Stream Collapse effect active. */
function hasStreamCollapse(turnpoint: Turnpoint): boolean {
  return turnpoint.activeEffects.some((e) => e.type === "stream_collapse");
}

/** Find an operator by instanceId across all streams. */
export function findOperator(
  state: ServerGameState,
  instanceId: string,
): OperatorInstance | null {
  for (const playerId of Object.keys(state.streams)) {
    for (const tp of state.streams[playerId]) {
      const op = tp.operators.find((o) => o.instanceId === instanceId);
      if (op) return op;
    }
  }
  return null;
}

/** Find the turnpoint containing an operator. */
export function findOperatorTurnpoint(
  state: ServerGameState,
  instanceId: string,
): { playerId: string; turnpoint: Turnpoint } | null {
  for (const playerId of Object.keys(state.streams)) {
    for (const tp of state.streams[playerId]) {
      if (tp.operators.some((o) => o.instanceId === instanceId)) {
        return { playerId, turnpoint: tp };
      }
    }
  }
  return null;
}

/** Get a turnpoint by position across both players' streams. */
export function getTurnpoint(
  state: ServerGameState,
  position: StreamPosition,
): Turnpoint | null {
  const playerIds = Object.keys(state.streams);
  const stream = state.streams[playerIds[position.stream]];
  if (!stream) return null;
  return stream[position.centuryIndex] ?? null;
}

/** Get the effective attack of an operator (base + equipment + status buffs). */
export function getEffectiveAttack(
  op: OperatorInstance,
  cardCatalog: Map<string, Card>,
): number {
  let atk = op.attack;

  // Equipment bonuses (Null Blade = +2 ATK)
  for (const eqId of op.equipmentCardIds) {
    const card = cardCatalog.get(eqId);
    if (card?.name === "Null Blade") atk += 2;
  }

  // Status effect modifiers
  for (const effect of op.statusEffects) {
    if (effect.type === "surge_protocol") atk += (effect.value ?? 2);
    if (effect.type === "expose") atk -= (effect.value ?? 1);
  }

  return Math.max(0, atk);
}

/**
 * Validate whether a game action is legal.
 * Throws GameRuleError if invalid.
 */
export function validateAction(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
  cardCatalog: Map<string, Card>,
): void {
  // Must be active player
  if (state.game.active_player_id !== playerId) {
    throw new GameRuleError("Not your turn");
  }
  if (state.game.status !== "active") {
    throw new GameRuleError("Game is not active");
  }

  switch (action.type) {
    case "play_card":
      validatePlayCard(state, action, playerId, cardCatalog);
      break;
    case "move":
      validateMove(state, action, playerId);
      break;
    case "attack":
      validateAttack(state, action, playerId);
      break;
    case "ability":
      validateAbility(state, action, playerId);
      break;
    case "end_turn":
      // Always valid if it's your turn
      break;
    default:
      throw new GameRuleError(`Unknown action type: ${action.type}`);
  }
}

function validatePlayCard(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
  cardCatalog: Map<string, Card>,
): void {
  if (!action.sourceId) throw new GameRuleError("sourceId (card_id) required");

  // Card must be in hand
  const hand = state.hands[playerId];
  if (!hand?.includes(action.sourceId)) {
    throw new GameRuleError("Card not in hand");
  }

  const card = cardCatalog.get(action.sourceId);
  if (!card) throw new GameRuleError("Card not found in catalog");

  // Enough AP
  const ap = state.actionPoints[playerId];
  if (ap.current < card.cost) {
    throw new GameRuleError(
      `Not enough AP: need ${card.cost}, have ${ap.current}`,
    );
  }

  // Type-specific validations
  switch (card.type) {
    case "operator": {
      // Must target own stream, centuries 0-4
      const pos = action.target?.position;
      if (!pos) throw new GameRuleError("Target position required for operator deploy");
      if (pos.centuryIndex > GAME_CONSTANTS.MAX_DEPLOY_CENTURY) {
        throw new GameRuleError("Cannot deploy operator to controller century");
      }
      // Verify it's the player's own stream
      const playerIds = Object.keys(state.streams);
      const playerStreamIndex = playerIds.indexOf(playerId);
      if (pos.stream !== playerStreamIndex) {
        throw new GameRuleError("Must deploy operator on own stream");
      }
      break;
    }
    case "tactic": {
      // Tactics target operators or positions depending on the card
      if (!action.target) throw new GameRuleError("Target required for tactic");
      break;
    }
    case "event": {
      // Events target a turnpoint position
      if (!action.target?.position) {
        throw new GameRuleError("Target position required for event");
      }
      break;
    }
    case "equipment": {
      // Must target a friendly operator
      if (!action.target?.operatorInstanceId) {
        throw new GameRuleError("Target operator required for equipment");
      }
      const targetOp = findOperator(state, action.target.operatorInstanceId);
      if (!targetOp) throw new GameRuleError("Target operator not found");
      if (targetOp.ownerId !== playerId) {
        throw new GameRuleError("Can only equip friendly operators");
      }
      break;
    }
  }
}

function validateMove(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
): void {
  if (!action.sourceId) throw new GameRuleError("sourceId (operatorInstanceId) required");
  if (!action.target?.position) throw new GameRuleError("Target position required");

  const operator = findOperator(state, action.sourceId);
  if (!operator) throw new GameRuleError("Operator not found");
  if (operator.ownerId !== playerId) throw new GameRuleError("Not your operator");
  if (operator.hasActedThisTurn) throw new GameRuleError("Operator has already acted this turn");

  // Check for lockdown status
  if (operator.statusEffects.some((e) => e.type === "lockdown")) {
    throw new GameRuleError("Operator is locked down and cannot move");
  }

  // Check AP
  const ap = state.actionPoints[playerId];
  if (ap.current < 1) throw new GameRuleError("Not enough AP to move (need 1)");

  // Check adjacency
  const targetPos = action.target.position;
  if (!isAdjacent(operator.position, targetPos)) {
    throw new GameRuleError("Target must be adjacent");
  }

  // Check Stream Collapse on source and destination
  const sourceLoc = findOperatorTurnpoint(state, action.sourceId);
  if (sourceLoc && hasStreamCollapse(sourceLoc.turnpoint)) {
    throw new GameRuleError("Cannot move out of a turnpoint affected by Stream Collapse");
  }

  const playerIds = Object.keys(state.streams);
  const destStream = state.streams[playerIds[targetPos.stream]];
  if (destStream) {
    const destTp = destStream[targetPos.centuryIndex];
    if (destTp && hasStreamCollapse(destTp)) {
      throw new GameRuleError("Cannot move into a turnpoint affected by Stream Collapse");
    }
  }
}

function validateAttack(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
): void {
  if (!action.sourceId) throw new GameRuleError("sourceId (operatorInstanceId) required");

  const attacker = findOperator(state, action.sourceId);
  if (!attacker) throw new GameRuleError("Attacker not found");
  if (attacker.ownerId !== playerId) throw new GameRuleError("Not your operator");
  if (attacker.hasActedThisTurn) throw new GameRuleError("Operator has already acted this turn");

  const ap = state.actionPoints[playerId];
  if (ap.current < 1) throw new GameRuleError("Not enough AP to attack (need 1)");

  // Target can be an operator or a controller position
  if (action.target?.operatorInstanceId) {
    const defender = findOperator(state, action.target.operatorInstanceId);
    if (!defender) throw new GameRuleError("Target operator not found");
    if (defender.ownerId === playerId) throw new GameRuleError("Cannot attack own operator");

    // Must be in same or adjacent turnpoint
    if (
      !positionsMatch(attacker.position, defender.position) &&
      !isAdjacent(attacker.position, defender.position)
    ) {
      throw new GameRuleError("Target not in range (same or adjacent turnpoint)");
    }
  } else if (action.target?.position) {
    // Attacking a controller at century 5
    const targetPos = action.target.position;
    if (targetPos.centuryIndex !== GAME_CONSTANTS.CONTROLLER_CENTURY) {
      throw new GameRuleError("Can only attack controller at century " + GAME_CONSTANTS.CONTROLLER_CENTURY);
    }
    // Must be adjacent or at the controller position
    if (
      !positionsMatch(attacker.position, targetPos) &&
      !isAdjacent(attacker.position, targetPos)
    ) {
      throw new GameRuleError("Not in range to attack controller");
    }
    // Must be opponent's stream
    const playerIds = Object.keys(state.streams);
    const opponentStreamIndex = playerIds.indexOf(playerId) === 0 ? 1 : 0;
    if (targetPos.stream !== opponentStreamIndex) {
      throw new GameRuleError("Can only attack opponent's controller");
    }
  } else {
    throw new GameRuleError("Attack target required (operator or position)");
  }
}

function validateAbility(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
): void {
  if (!action.sourceId) throw new GameRuleError("sourceId (operatorInstanceId) required");
  if (!action.target?.abilityId) throw new GameRuleError("abilityId required");

  const operator = findOperator(state, action.sourceId);
  if (!operator) throw new GameRuleError("Operator not found");
  if (operator.ownerId !== playerId) throw new GameRuleError("Not your operator");
  if (operator.hasActedThisTurn) throw new GameRuleError("Operator has already acted this turn");

  // AP check — abilities cost at least 1 AP (specific costs handled in effect processor)
  const ap = state.actionPoints[playerId];
  if (ap.current < 1) throw new GameRuleError("Not enough AP for ability");
}

function positionsMatch(a: StreamPosition, b: StreamPosition): boolean {
  return a.stream === b.stream && a.centuryIndex === b.centuryIndex;
}

/**
 * Get valid target positions for a move action.
 */
export function getValidMoveTargets(
  state: ServerGameState,
  operatorInstanceId: string,
): StreamPosition[] {
  const op = findOperator(state, operatorInstanceId);
  if (!op) return [];

  const targets: StreamPosition[] = [];
  const playerIds = Object.keys(state.streams);

  // Check if source has stream collapse
  const sourceLoc = findOperatorTurnpoint(state, operatorInstanceId);
  if (sourceLoc && hasStreamCollapse(sourceLoc.turnpoint)) return [];

  for (let s = 0; s < GAME_CONSTANTS.BOARD_STREAMS; s++) {
    for (let c = 0; c < GAME_CONSTANTS.BOARD_CENTURIES; c++) {
      const pos: StreamPosition = { stream: s as 0 | 1, centuryIndex: c };
      if (isAdjacent(op.position, pos)) {
        const destStream = state.streams[playerIds[s]];
        if (destStream) {
          const destTp = destStream[c];
          if (!destTp || !hasStreamCollapse(destTp)) {
            targets.push(pos);
          }
        }
      }
    }
  }

  return targets;
}
