import type {
  ActionResult,
  Card,
  OperatorInstance,
  ServerGameState,
} from "./types.ts";
import { findOperator, findOperatorTurnpoint, getEffectiveAttack } from "./rules-engine.ts";

/**
 * Resolve combat between an attacking operator and a defending operator.
 * Returns the result and mutates state in place.
 */
export function resolveCombat(
  state: ServerGameState,
  attackerInstanceId: string,
  defenderInstanceId: string,
  cardCatalog: Map<string, Card>,
): ActionResult {
  const attacker = findOperator(state, attackerInstanceId);
  const defender = findOperator(state, defenderInstanceId);
  if (!attacker || !defender) {
    return { success: false, description: "Operator not found" };
  }

  const damage = getEffectiveAttack(attacker, cardCatalog);
  defender.currentHp -= damage;

  const result: ActionResult = {
    success: true,
    description: `${attackerInstanceId} dealt ${damage} damage to ${defenderInstanceId}`,
    changes: {
      damage,
      defenderHpBefore: defender.currentHp + damage,
      defenderHpAfter: defender.currentHp,
    },
  };

  // Mark attacker as acted
  attacker.hasActedThisTurn = true;

  // Check elimination
  if (defender.currentHp <= 0) {
    eliminateOperator(state, defenderInstanceId);
    result.changes!.eliminated = true;
    result.description += ` (eliminated)`;
  }

  return result;
}

/**
 * Resolve an attack on a controller.
 * Returns the result and mutates state in place.
 */
export function resolveControllerAttack(
  state: ServerGameState,
  attackerInstanceId: string,
  targetPlayerId: string,
  cardCatalog: Map<string, Card>,
): ActionResult {
  const attacker = findOperator(state, attackerInstanceId);
  if (!attacker) {
    return { success: false, description: "Attacker not found" };
  }

  const damage = getEffectiveAttack(attacker, cardCatalog);
  const controller = state.controllers[targetPlayerId];
  controller.hp -= damage;

  attacker.hasActedThisTurn = true;

  return {
    success: true,
    description: `${attackerInstanceId} dealt ${damage} damage to controller`,
    changes: {
      damage,
      controllerHpBefore: controller.hp + damage,
      controllerHpAfter: controller.hp,
      controllerDestroyed: controller.hp <= 0,
    },
  };
}

/**
 * Apply direct damage to an operator.
 */
export function applyDamage(
  state: ServerGameState,
  targetInstanceId: string,
  damage: number,
): { eliminated: boolean } {
  const op = findOperator(state, targetInstanceId);
  if (!op) return { eliminated: false };

  op.currentHp -= damage;
  if (op.currentHp <= 0) {
    eliminateOperator(state, targetInstanceId);
    return { eliminated: true };
  }
  return { eliminated: false };
}

/**
 * Apply healing to an operator (capped at maxHp).
 */
export function applyHealing(
  state: ServerGameState,
  targetInstanceId: string,
  amount: number,
): void {
  const op = findOperator(state, targetInstanceId);
  if (!op) return;
  op.currentHp = Math.min(op.currentHp + amount, op.maxHp);
}

/**
 * Remove an operator from the board, destroying its equipment.
 */
export function eliminateOperator(
  state: ServerGameState,
  instanceId: string,
): void {
  const loc = findOperatorTurnpoint(state, instanceId);
  if (!loc) return;

  loc.turnpoint.operators = loc.turnpoint.operators.filter(
    (o) => o.instanceId !== instanceId,
  );
}

/**
 * Check if a player has any operators remaining on the board.
 */
export function hasOperatorsRemaining(
  state: ServerGameState,
  playerId: string,
): boolean {
  for (const streamOwnerId of Object.keys(state.streams)) {
    for (const tp of state.streams[streamOwnerId]) {
      if (tp.operators.some((o) => o.ownerId === playerId)) return true;
    }
  }
  return false;
}
