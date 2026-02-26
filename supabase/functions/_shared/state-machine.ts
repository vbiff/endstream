import { GAME_CONSTANTS, LOCAL_OPPONENT_ID } from "./constants.ts";
import {
  hasOperatorsRemaining,
  resolveCombat,
  resolveControllerAttack,
} from "./combat-resolver.ts";
import {
  processAbility,
  processEndOfTurnEffects,
  processPlayCard,
  processStartOfTurnEffects,
} from "./effect-processor.ts";
import { GameRuleError } from "./errors.ts";
import {
  findOperator,
  findOperatorTurnpoint,
  isAdjacent,
  validateAction,
} from "./rules-engine.ts";
import type {
  Ability,
  ActionResult,
  Card,
  ClientGameStateResponse,
  GameAction,
  ServerGameState,
  Stream,
  Turnpoint,
} from "./types.ts";

// ── Initialize a new game ───────────────────────────────────────────

export function initializeGame(
  gameId: string,
  player1Id: string,
  player2Id: string,
  player1Deck: string[], // flat array of card IDs (30 items)
  player2Deck: string[],
  cardCatalog: Map<string, Card>,
): ServerGameState {
  // Shuffle decks
  const deck1 = shuffle([...player1Deck]);
  const deck2 = shuffle([...player2Deck]);

  // Deal initial hands (5 cards each)
  const hand1 = deck1.splice(0, GAME_CONSTANTS.INITIAL_HAND_SIZE);
  const hand2 = deck2.splice(0, GAME_CONSTANTS.INITIAL_HAND_SIZE);

  // Build empty streams (2 streams x 6 centuries)
  const stream1 = buildEmptyStream();
  const stream2 = buildEmptyStream();

  return {
    game: {
      id: gameId,
      player_1_id: player1Id,
      player_2_id: player2Id,
      status: "active",
      winner_id: null,
      current_turn: 1,
      active_player_id: player1Id, // Player 1 goes first
      game_mode: player2Id === LOCAL_OPPONENT_ID ? "local" : "online",
    },
    streams: {
      [player1Id]: stream1,
      [player2Id]: stream2,
    },
    hands: {
      [player1Id]: hand1,
      [player2Id]: hand2,
    },
    drawPiles: {
      [player1Id]: deck1,
      [player2Id]: deck2,
    },
    actionPoints: {
      [player1Id]: { current: GAME_CONSTANTS.AP_PER_TURN, max: GAME_CONSTANTS.AP_PER_TURN },
      [player2Id]: { current: GAME_CONSTANTS.AP_PER_TURN, max: GAME_CONSTANTS.AP_PER_TURN },
    },
    controllers: {
      [player1Id]: { hp: GAME_CONSTANTS.CONTROLLER_HP, maxHp: GAME_CONSTANTS.CONTROLLER_HP },
      [player2Id]: { hp: GAME_CONSTANTS.CONTROLLER_HP, maxHp: GAME_CONSTANTS.CONTROLLER_HP },
    },
  };
}

function buildEmptyStream(): Stream {
  const stream: Turnpoint[] = [];
  for (let c = 0; c < GAME_CONSTANTS.BOARD_CENTURIES; c++) {
    stream.push({
      centuryIndex: c,
      operators: [],
      activeEffects: [],
      controllerPresent: c === GAME_CONSTANTS.CONTROLLER_CENTURY,
    });
  }
  return stream;
}

function shuffle<T>(array: T[]): T[] {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
}

// ── Process a single action ─────────────────────────────────────────

export function processAction(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
  cardCatalog: Map<string, Card>,
  abilityMap: Map<string, Ability>,
): ActionResult {
  // Validate first
  validateAction(state, action, playerId, cardCatalog);

  switch (action.type) {
    case "play_card":
      return processPlayCard(state, action, playerId, cardCatalog);

    case "move":
      return processMove(state, action, playerId);

    case "attack":
      return processAttack(state, action, playerId, cardCatalog);

    case "ability":
      return processAbility(state, action, playerId, abilityMap);

    case "end_turn":
      return advanceTurn(state, playerId);

    default:
      throw new GameRuleError(`Unknown action type: ${action.type}`);
  }
}

// ── Move operator ───────────────────────────────────────────────────

function processMove(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
): ActionResult {
  const operator = findOperator(state, action.sourceId!)!;
  const targetPos = action.target!.position!;

  // Deduct AP
  state.actionPoints[playerId].current -= 1;

  // Remove from current turnpoint
  const loc = findOperatorTurnpoint(state, action.sourceId!)!;
  loc.turnpoint.operators = loc.turnpoint.operators.filter(
    (o) => o.instanceId !== operator.instanceId,
  );

  // Add to target turnpoint
  const playerIds = Object.keys(state.streams);
  const destStream = state.streams[playerIds[targetPos.stream]];
  const destTp = destStream[targetPos.centuryIndex];
  operator.position = targetPos;
  destTp.operators.push(operator);
  operator.hasActedThisTurn = true;

  return {
    success: true,
    description: `Moved to stream ${targetPos.stream}, century ${targetPos.centuryIndex}`,
    changes: { operatorInstanceId: operator.instanceId, position: targetPos },
  };
}

// ── Attack ──────────────────────────────────────────────────────────

function processAttack(
  state: ServerGameState,
  action: GameAction,
  playerId: string,
  cardCatalog: Map<string, Card>,
): ActionResult {
  // Deduct AP
  state.actionPoints[playerId].current -= 1;

  if (action.target?.operatorInstanceId) {
    // Attack an operator
    return resolveCombat(
      state,
      action.sourceId!,
      action.target.operatorInstanceId,
      cardCatalog,
    );
  } else {
    // Attack a controller
    const playerIds = Object.keys(state.streams);
    const opponentId = playerIds.find((id) => id !== playerId)!;
    return resolveControllerAttack(state, action.sourceId!, opponentId, cardCatalog);
  }
}

// ── Advance turn ────────────────────────────────────────────────────

export function advanceTurn(
  state: ServerGameState,
  playerId: string,
): ActionResult {
  // End-of-turn effects
  processEndOfTurnEffects(state);

  // Check win conditions after end-of-turn effects
  const winResult = checkWinConditions(state);
  if (winResult) {
    state.game.status = "completed";
    state.game.winner_id = winResult.winnerId;
    return {
      success: true,
      description: `Game over: ${winResult.reason}`,
      changes: { gameOver: true, winnerId: winResult.winnerId, reason: winResult.reason },
    };
  }

  // Switch active player
  const playerIds = [state.game.player_1_id, state.game.player_2_id];
  const nextPlayerId = playerIds.find((id) => id !== playerId)!;
  state.game.active_player_id = nextPlayerId;
  state.game.current_turn += 1;

  // Start-of-turn effects (for next player)
  processStartOfTurnEffects(state, nextPlayerId);

  // Draw a card for next player
  drawCard(state, nextPlayerId);

  return {
    success: true,
    description: `Turn ended. Turn ${state.game.current_turn} begins for ${nextPlayerId}`,
    changes: { turnEnded: true, nextPlayerId, newTurn: state.game.current_turn },
  };
}

function drawCard(state: ServerGameState, playerId: string): void {
  const pile = state.drawPiles[playerId];
  if (pile.length > 0) {
    const card = pile.shift()!;
    state.hands[playerId].push(card);
  }
  // If deck is empty, player simply doesn't draw
}

// ── Win condition check ─────────────────────────────────────────────

export function checkWinConditions(
  state: ServerGameState,
): { winnerId: string; reason: string } | null {
  const p1 = state.game.player_1_id;
  const p2 = state.game.player_2_id;

  // Check controller destruction
  if (state.controllers[p1].hp <= 0) {
    return { winnerId: p2, reason: "Controller destroyed" };
  }
  if (state.controllers[p2].hp <= 0) {
    return { winnerId: p1, reason: "Controller destroyed" };
  }

  // Check all operators eliminated
  // Only check if at least one operator has been deployed (turn > 1 or operators exist)
  const p1HasOps = hasOperatorsRemaining(state, p1);
  const p2HasOps = hasOperatorsRemaining(state, p2);

  // Both must have had operators deployed at some point for elimination to count
  // We check if current turn > 2 (both players have had a chance to deploy)
  if (state.game.current_turn > 2) {
    if (!p1HasOps && p2HasOps) {
      return { winnerId: p2, reason: "All operators eliminated" };
    }
    if (!p2HasOps && p1HasOps) {
      return { winnerId: p1, reason: "All operators eliminated" };
    }
  }

  return null;
}

// ── Build client response ───────────────────────────────────────────

export function buildClientResponse(
  state: ServerGameState,
  requestingPlayerId: string,
  cardCatalog: Map<string, Card>,
  lastAction?: { type: string; result?: Record<string, unknown> },
): ClientGameStateResponse {
  const playerIds = Object.keys(state.streams);
  const opponentId = playerIds.find((id) => id !== requestingPlayerId)!;

  // Map hand card IDs to full card objects
  const myHandCards: Card[] = (state.hands[requestingPlayerId] ?? [])
    .map((id) => cardCatalog.get(id))
    .filter((c): c is Card => c !== undefined);

  return {
    game: {
      id: state.game.id,
      player_1_id: state.game.player_1_id,
      player_2_id: state.game.player_2_id,
      status: state.game.status,
      current_turn: state.game.current_turn,
      active_player_id: state.game.active_player_id,
      winner_id: state.game.winner_id,
      game_mode: state.game.game_mode,
    },
    myStream: state.streams[requestingPlayerId],
    opponentStream: state.streams[opponentId],
    myHand: myHandCards,
    handSize: state.hands[requestingPlayerId]?.length ?? 0,
    opponentHandSize: state.hands[opponentId]?.length ?? 0,
    actionPoints: state.actionPoints[requestingPlayerId]?.current ?? 0,
    maxActionPoints: state.actionPoints[requestingPlayerId]?.max ?? GAME_CONSTANTS.AP_PER_TURN,
    myControllerId: requestingPlayerId,
    myControllerHp: state.controllers[requestingPlayerId]?.hp ?? 0,
    opponentControllerHp: state.controllers[opponentId]?.hp ?? 0,
    myPlayerId: requestingPlayerId,
    opponentPlayerId: opponentId,
    lastAction: lastAction as ClientGameStateResponse["lastAction"],
  };
}

// ── Load full game state from DB rows ───────────────────────────────

export function loadGameState(
  game: Record<string, unknown>,
  streams: Record<string, unknown>[],
  hands: Record<string, unknown>[],
  drawPiles: Record<string, unknown>[],
  controllers: Record<string, unknown>[],
  playerStates: Record<string, unknown>[],
): ServerGameState {
  const state: ServerGameState = {
    game: {
      id: game.id as string,
      player_1_id: game.player_1_id as string,
      player_2_id: game.player_2_id as string,
      status: game.status as ServerGameState["game"]["status"],
      winner_id: (game.winner_id as string) ?? null,
      current_turn: game.current_turn as number,
      active_player_id: game.active_player_id as string,
      game_mode: (game.game_mode as "online" | "local") ?? "online",
    },
    streams: {},
    hands: {},
    drawPiles: {},
    actionPoints: {},
    controllers: {},
  };

  for (const s of streams) {
    state.streams[s.player_id as string] = s.stream_data as Stream;
  }
  for (const h of hands) {
    state.hands[h.player_id as string] = h.hand_data as string[];
  }
  for (const d of drawPiles) {
    state.drawPiles[d.player_id as string] = d.pile_data as string[];
  }
  for (const c of controllers) {
    state.controllers[c.player_id as string] = {
      hp: c.hp as number,
      maxHp: c.max_hp as number,
    };
  }
  for (const ps of playerStates) {
    state.actionPoints[ps.player_id as string] = {
      current: ps.action_points as number,
      max: ps.max_action_points as number,
    };
  }

  return state;
}
