import { GAME_CONSTANTS } from "./constants.ts";
import {
  applyDamage,
  applyHealing,
  eliminateOperator,
} from "./combat-resolver.ts";
import { GameRuleError } from "./errors.ts";
import {
  findOperator,
  findOperatorTurnpoint,
  getEffectiveAttack,
  isAdjacent,
} from "./rules-engine.ts";
import type {
  Ability,
  ActionResult,
  Card,
  GameAction,
  OperatorInstance,
  ServerGameState,
  StreamPosition,
  Turnpoint,
  TurnpointEffect,
} from "./types.ts";

// ── Card IDs (from seed data) ───────────────────────────────────────

const CARD_IDS = {
  // Operators
  KAEL: "10000000-0000-4000-a000-000000000001",
  MIRA: "10000000-0000-4000-a000-000000000002",
  VOSS: "10000000-0000-4000-a000-000000000003",
  ASH: "10000000-0000-4000-a000-000000000004",
  SABLE: "10000000-0000-4000-a000-000000000005",
  THANE: "10000000-0000-4000-a000-000000000006",
  // Tactics
  TEMPORAL_FRACTURE: "20000000-0000-4000-a000-000000000001",
  STREAM_MENDING: "20000000-0000-4000-a000-000000000002",
  SURGE_PROTOCOL: "20000000-0000-4000-a000-000000000003",
  CHRONO_SEVERANCE: "20000000-0000-4000-a000-000000000004",
  // Events
  DEAD_CENTURY: "30000000-0000-4000-a000-000000000001",
  TEMPORAL_HAVEN: "30000000-0000-4000-a000-000000000002",
  STREAM_COLLAPSE: "30000000-0000-4000-a000-000000000003",
  // Equipment
  NULL_BLADE: "40000000-0000-4000-a000-000000000001",
  PHASE_ARMOR: "40000000-0000-4000-a000-000000000002",
} as const;

const ABILITY_IDS = {
  TEMPORAL_DASH: "a0000000-0000-4000-a000-000000000001",
  RECONSTRUCT: "a0000000-0000-4000-a000-000000000002",
  LOCKDOWN: "a0000000-0000-4000-a000-000000000003",
  IGNITE: "a0000000-0000-4000-a000-000000000004",
  EXPOSE: "a0000000-0000-4000-a000-000000000005",
  STABILIZE: "a0000000-0000-4000-a000-000000000006",
} as const;

// ── Play card dispatch ──────────────────────────────────────────────

export function processPlayCard(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
  cardCatalog: Map<string, Card>,
): ActionResult {
  const cardId = action.sourceId!;
  const card = cardCatalog.get(cardId)!;

  // Remove first occurrence of card from hand and deduct AP
  const handIdx = state.hands[playerId].indexOf(cardId);
  if (handIdx === -1) {
    throw new GameRuleError("Card not in hand after validation");
  }
  state.hands[playerId].splice(handIdx, 1);
  state.actionPoints[playerId].current -= card.cost;

  switch (card.type) {
    case "operator":
      return deployOperator(state, card, action, playerId);
    case "tactic":
      return processTactic(state, card, action, playerId, cardCatalog);
    case "event":
      return processEvent(state, card, action, playerId);
    case "equipment":
      return processEquipment(state, card, action, playerId);
    default:
      throw new GameRuleError(`Unknown card type: ${card.type}`);
  }
}

// ── Deploy operator ─────────────────────────────────────────────────

function deployOperator(
  state: ServerGameState,
  card: Card,
  action: GameAction,
  playerId: string,
): ActionResult {
  const pos = action.target!.position!;
  const playerIds = Object.keys(state.streams);
  const stream = state.streams[playerIds[pos.stream]];
  const turnpoint = stream[pos.centuryIndex];

  const instance: OperatorInstance = {
    instanceId: crypto.randomUUID(),
    operatorCardId: card.id,
    ownerId: playerId,
    currentHp: card.hp!,
    maxHp: card.hp!,
    attack: card.attack!,
    position: pos,
    statusEffects: [],
    hasActedThisTurn: true, // Cannot act on deploy turn
    equipmentCardIds: [],
  };

  turnpoint.operators.push(instance);

  // Kael special: may immediately move to adjacent turnpoint (handled client-side as follow-up)
  // For now, deploy is complete. Kael's Temporal Dash ability handles this.

  return {
    success: true,
    description: `Deployed ${card.name} to stream ${pos.stream}, century ${pos.centuryIndex}`,
    changes: { operatorInstanceId: instance.instanceId, position: pos },
  };
}

// ── Tactics ──────────────────────────────────────────────────────────

function processTactic(
  state: ServerGameState,
  card: Card,
  action: GameAction,
  playerId: string,
  cardCatalog: Map<string, Card>,
): ActionResult {
  switch (card.id) {
    case CARD_IDS.TEMPORAL_FRACTURE: {
      // Deal 3 damage to target operator
      const targetId = action.target?.operatorInstanceId;
      if (!targetId) throw new GameRuleError("Target operator required");
      const { eliminated } = applyDamage(state, targetId, 3);
      return {
        success: true,
        description: `Temporal Fracture dealt 3 damage${eliminated ? " (eliminated)" : ""}`,
        changes: { damage: 3, eliminated, targetId },
      };
    }
    case CARD_IDS.STREAM_MENDING: {
      // Heal 3 HP to friendly operator
      const targetId = action.target?.operatorInstanceId;
      if (!targetId) throw new GameRuleError("Target operator required");
      const op = findOperator(state, targetId);
      if (!op) throw new GameRuleError("Target not found");
      if (op.ownerId !== playerId) throw new GameRuleError("Can only heal friendly operators");
      applyHealing(state, targetId, 3);
      return {
        success: true,
        description: `Stream Mending healed 3 HP`,
        changes: { healing: 3, targetId },
      };
    }
    case CARD_IDS.SURGE_PROTOCOL: {
      // +2 ATK until end of turn
      const targetId = action.target?.operatorInstanceId;
      if (!targetId) throw new GameRuleError("Target operator required");
      const op = findOperator(state, targetId);
      if (!op) throw new GameRuleError("Target not found");
      if (op.ownerId !== playerId) throw new GameRuleError("Can only buff friendly operators");
      op.statusEffects.push({
        type: "surge_protocol",
        value: 2,
        turnsRemaining: 1,
        sourcePlayerId: playerId,
      });
      return {
        success: true,
        description: `Surge Protocol: +2 ATK until end of turn`,
        changes: { targetId, atkBuff: 2 },
      };
    }
    case CARD_IDS.CHRONO_SEVERANCE: {
      // Deal 5 damage, if kills gain 1 AP
      const targetId = action.target?.operatorInstanceId;
      if (!targetId) throw new GameRuleError("Target operator required");
      const { eliminated } = applyDamage(state, targetId, 5);
      if (eliminated) {
        state.actionPoints[playerId].current += 1;
      }
      return {
        success: true,
        description: `Chrono Severance dealt 5 damage${eliminated ? " (eliminated, +1 AP)" : ""}`,
        changes: { damage: 5, eliminated, targetId, apGained: eliminated ? 1 : 0 },
      };
    }
    default:
      throw new GameRuleError(`Unknown tactic card: ${card.name}`);
  }
}

// ── Events ──────────────────────────────────────────────────────────

function processEvent(
  state: ServerGameState,
  card: Card,
  action: GameAction,
  playerId: string,
): ActionResult {
  const pos = action.target!.position!;
  const playerIds = Object.keys(state.streams);
  const stream = state.streams[playerIds[pos.stream]];
  const turnpoint = stream[pos.centuryIndex];

  let effect: TurnpointEffect;

  switch (card.id) {
    case CARD_IDS.DEAD_CENTURY:
      effect = {
        type: "dead_century",
        sourceCardId: card.id,
        sourcePlayerId: playerId,
        turnsRemaining: 3,
      };
      break;
    case CARD_IDS.TEMPORAL_HAVEN:
      effect = {
        type: "temporal_haven",
        sourceCardId: card.id,
        sourcePlayerId: playerId,
        turnsRemaining: 3,
      };
      break;
    case CARD_IDS.STREAM_COLLAPSE:
      effect = {
        type: "stream_collapse",
        sourceCardId: card.id,
        sourcePlayerId: playerId,
        turnsRemaining: 2,
      };
      break;
    default:
      throw new GameRuleError(`Unknown event card: ${card.name}`);
  }

  turnpoint.activeEffects.push(effect);

  return {
    success: true,
    description: `Placed ${card.name} on stream ${pos.stream}, century ${pos.centuryIndex}`,
    changes: { effectType: effect.type, position: pos, turnsRemaining: effect.turnsRemaining },
  };
}

// ── Equipment ───────────────────────────────────────────────────────

function processEquipment(
  state: ServerGameState,
  card: Card,
  action: GameAction,
  playerId: string,
): ActionResult {
  const targetId = action.target!.operatorInstanceId!;
  const op = findOperator(state, targetId);
  if (!op) throw new GameRuleError("Target operator not found");

  op.equipmentCardIds.push(card.id);

  switch (card.id) {
    case CARD_IDS.NULL_BLADE:
      // +2 ATK is handled via getEffectiveAttack reading equipmentCardIds
      return {
        success: true,
        description: `Equipped Null Blade (+2 ATK)`,
        changes: { targetId, atkBonus: 2 },
      };
    case CARD_IDS.PHASE_ARMOR:
      // +3 max HP and +3 current HP
      op.maxHp += 3;
      op.currentHp += 3;
      return {
        success: true,
        description: `Equipped Phase Armor (+3 HP)`,
        changes: { targetId, hpBonus: 3 },
      };
    default:
      throw new GameRuleError(`Unknown equipment card: ${card.name}`);
  }
}

// ── Ability dispatch ────────────────────────────────────────────────

export function processAbility(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
  abilityMap: Map<string, Ability>,
): ActionResult {
  const operatorInstanceId = action.sourceId!;
  const abilityId = action.target!.abilityId!;

  const ability = abilityMap.get(abilityId);
  if (!ability) throw new GameRuleError("Ability not found");

  const operator = findOperator(state, operatorInstanceId);
  if (!operator) throw new GameRuleError("Operator not found");

  // Verify this operator has this ability (card_id match)
  if (ability.card_id !== operator.operatorCardId) {
    throw new GameRuleError("Operator does not have this ability");
  }

  // Check AP cost
  const ap = state.actionPoints[playerId];
  if (ap.current < ability.cost) {
    throw new GameRuleError(`Not enough AP for ability: need ${ability.cost}, have ${ap.current}`);
  }

  ap.current -= ability.cost;
  operator.hasActedThisTurn = true;

  switch (abilityId) {
    case ABILITY_IDS.TEMPORAL_DASH:
      return processTemporalDash(state, operator, action);
    case ABILITY_IDS.RECONSTRUCT:
      return processReconstruct(state, operator, action, playerId);
    case ABILITY_IDS.LOCKDOWN:
      return processLockdown(state, operator, action, playerId);
    case ABILITY_IDS.IGNITE:
      return processIgnite(state, operator);
    case ABILITY_IDS.EXPOSE:
      return processExpose(state, operator, action, playerId);
    case ABILITY_IDS.STABILIZE:
      return processStabilize(state, operator);
    default:
      throw new GameRuleError(`Unknown ability: ${ability.name}`);
  }
}

// Kael: Move to any adjacent turnpoint (doesn't cost a move action)
function processTemporalDash(
  state: ServerGameState,
  operator: OperatorInstance,
  action: GameAction,
): ActionResult {
  const targetPos = action.target?.position;
  if (!targetPos) throw new GameRuleError("Target position required for Temporal Dash");
  if (!isAdjacent(operator.position, targetPos)) {
    throw new GameRuleError("Target must be adjacent");
  }

  // Remove from current turnpoint
  const loc = findOperatorTurnpoint(state, operator.instanceId);
  if (loc) {
    loc.turnpoint.operators = loc.turnpoint.operators.filter(
      (o) => o.instanceId !== operator.instanceId,
    );
  }

  // Add to target turnpoint
  const playerIds = Object.keys(state.streams);
  const destStream = state.streams[playerIds[targetPos.stream]];
  const destTp = destStream[targetPos.centuryIndex];
  operator.position = targetPos;
  destTp.operators.push(operator);

  return {
    success: true,
    description: `Temporal Dash: moved to stream ${targetPos.stream}, century ${targetPos.centuryIndex}`,
    changes: { position: targetPos },
  };
}

// Mira: Heal 2 HP to friendly in same/adjacent turnpoint
function processReconstruct(
  state: ServerGameState,
  operator: OperatorInstance,
  action: GameAction,
  playerId: string,
): ActionResult {
  const targetId = action.target?.operatorInstanceId;
  if (!targetId) throw new GameRuleError("Target operator required for Reconstruct");
  const target = findOperator(state, targetId);
  if (!target) throw new GameRuleError("Target not found");
  if (target.ownerId !== playerId) throw new GameRuleError("Can only heal friendly operators");
  if (!isAdjacent(operator.position, target.position) &&
    !(operator.position.stream === target.position.stream &&
      operator.position.centuryIndex === target.position.centuryIndex)) {
    throw new GameRuleError("Target must be in same or adjacent turnpoint");
  }
  applyHealing(state, targetId, 2);
  return { success: true, description: "Reconstruct: healed 2 HP", changes: { healing: 2, targetId } };
}

// Voss: Lock enemy in same/adjacent turnpoint
function processLockdown(
  state: ServerGameState,
  operator: OperatorInstance,
  action: GameAction,
  playerId: string,
): ActionResult {
  const targetId = action.target?.operatorInstanceId;
  if (!targetId) throw new GameRuleError("Target operator required for Lockdown");
  const target = findOperator(state, targetId);
  if (!target) throw new GameRuleError("Target not found");
  if (target.ownerId === playerId) throw new GameRuleError("Must target enemy operator");
  if (!isAdjacent(operator.position, target.position) &&
    !(operator.position.stream === target.position.stream &&
      operator.position.centuryIndex === target.position.centuryIndex)) {
    throw new GameRuleError("Target must be in same or adjacent turnpoint");
  }
  target.statusEffects.push({
    type: "lockdown",
    turnsRemaining: 2, // lasts until end of next turn
    sourcePlayerId: playerId,
  });
  return { success: true, description: "Lockdown: target cannot move", changes: { targetId } };
}

// Ash: 1 damage to ALL operators in same turnpoint
function processIgnite(
  state: ServerGameState,
  operator: OperatorInstance,
): ActionResult {
  const loc = findOperatorTurnpoint(state, operator.instanceId);
  if (!loc) throw new GameRuleError("Operator location not found");

  const eliminated: string[] = [];
  // Apply damage to all operators in same turnpoint (including friendlies, including self)
  for (const op of [...loc.turnpoint.operators]) {
    if (op.instanceId === operator.instanceId) continue; // damage self last
    const result = applyDamage(state, op.instanceId, 1);
    if (result.eliminated) eliminated.push(op.instanceId);
  }
  // Damage self
  const selfResult = applyDamage(state, operator.instanceId, 1);
  if (selfResult.eliminated) eliminated.push(operator.instanceId);

  return {
    success: true,
    description: `Ignite: 1 damage to all in turnpoint`,
    changes: { eliminated },
  };
}

// Sable: Reduce target ATK by 1 until end of turn
function processExpose(
  state: ServerGameState,
  operator: OperatorInstance,
  action: GameAction,
  playerId: string,
): ActionResult {
  const targetId = action.target?.operatorInstanceId;
  if (!targetId) throw new GameRuleError("Target operator required for Expose");
  const target = findOperator(state, targetId);
  if (!target) throw new GameRuleError("Target not found");
  if (target.ownerId === playerId) throw new GameRuleError("Must target enemy operator");
  if (!isAdjacent(operator.position, target.position) &&
    !(operator.position.stream === target.position.stream &&
      operator.position.centuryIndex === target.position.centuryIndex)) {
    throw new GameRuleError("Target must be in same or adjacent turnpoint");
  }
  target.statusEffects.push({
    type: "expose",
    value: 1,
    turnsRemaining: 1,
    sourcePlayerId: playerId,
  });
  return { success: true, description: "Expose: -1 ATK until end of turn", changes: { targetId } };
}

// Thane: Remove one negative status, or heal 1 if none
function processStabilize(
  state: ServerGameState,
  operator: OperatorInstance,
): ActionResult {
  const negativeEffects = operator.statusEffects.filter(
    (e) => e.type === "lockdown" || e.type === "expose",
  );

  if (negativeEffects.length > 0) {
    // Remove first negative effect
    const toRemove = negativeEffects[0];
    operator.statusEffects = operator.statusEffects.filter((e) => e !== toRemove);
    return {
      success: true,
      description: `Stabilize: removed ${toRemove.type}`,
      changes: { removed: toRemove.type },
    };
  } else {
    // Heal 1 HP
    applyHealing(state, operator.instanceId, 1);
    return { success: true, description: "Stabilize: healed 1 HP", changes: { healing: 1 } };
  }
}

// ── End-of-turn effects ─────────────────────────────────────────────

/**
 * Process all end-of-turn effects:
 * - Dead Century damage
 * - Decrement timers on turnpoint effects and status effects
 * - Expire effects with 0 turns remaining
 * - Remove surge_protocol and expose (end-of-turn effects)
 */
export function processEndOfTurnEffects(state: ServerGameState): void {
  for (const playerId of Object.keys(state.streams)) {
    for (const tp of state.streams[playerId]) {
      // Dead Century: 1 damage to all operators
      if (tp.activeEffects.some((e) => e.type === "dead_century")) {
        for (const op of [...tp.operators]) {
          applyDamage(state, op.instanceId, 1);
        }
      }

      // Decrement turnpoint effect timers
      for (const effect of tp.activeEffects) {
        effect.turnsRemaining -= 1;
      }
      // Remove expired effects
      tp.activeEffects = tp.activeEffects.filter((e) => e.turnsRemaining > 0);
    }
  }

  // Decrement status effect timers on all operators
  for (const playerId of Object.keys(state.streams)) {
    for (const tp of state.streams[playerId]) {
      for (const op of tp.operators) {
        for (const effect of op.statusEffects) {
          effect.turnsRemaining -= 1;
        }
        op.statusEffects = op.statusEffects.filter((e) => e.turnsRemaining > 0);
      }
    }
  }
}

// ── Start-of-turn effects ───────────────────────────────────────────

/**
 * Process all start-of-turn effects for the active player:
 * - Temporal Haven: +1 HP to friendly operators
 * - Reset hasActedThisTurn
 * - Refresh AP
 */
export function processStartOfTurnEffects(
  state: ServerGameState,
  activePlayerId: string,
): void {
  // Refresh AP
  state.actionPoints[activePlayerId].current =
    state.actionPoints[activePlayerId].max;

  for (const playerId of Object.keys(state.streams)) {
    for (const tp of state.streams[playerId]) {
      // Temporal Haven: heal friendly operators
      const havenEffects = tp.activeEffects.filter(
        (e) => e.type === "temporal_haven" && e.sourcePlayerId === activePlayerId,
      );
      if (havenEffects.length > 0) {
        for (const op of tp.operators) {
          if (op.ownerId === activePlayerId) {
            applyHealing(state, op.instanceId, 1);
          }
        }
      }

      // Reset hasActedThisTurn for active player's operators
      for (const op of tp.operators) {
        if (op.ownerId === activePlayerId) {
          op.hasActedThisTurn = false;
        }
      }
    }
  }
}
