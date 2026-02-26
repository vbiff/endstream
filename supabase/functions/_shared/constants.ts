export const GAME_CONSTANTS = {
  /** Action points granted at start of each turn */
  AP_PER_TURN: 3,
  /** Number of centuries (turnpoints) per stream */
  BOARD_CENTURIES: 6,
  /** Number of parallel streams */
  BOARD_STREAMS: 2,
  /** Century index where controllers are placed */
  CONTROLLER_CENTURY: 5,
  /** Maximum century index where operators can deploy */
  MAX_DEPLOY_CENTURY: 4,
  /** Initial hand size (cards dealt at game start) */
  INITIAL_HAND_SIZE: 5,
  /** Cards drawn per turn */
  CARDS_PER_TURN_DRAW: 1,
  /** Controller starting HP */
  CONTROLLER_HP: 10,
  /** Required deck size */
  DECK_SIZE: 30,
  /** Maximum copies of a single card in a deck */
  MAX_COPIES_PER_CARD: 2,
  /** Minimum number of operator cards required */
  MIN_OPERATORS: 1,
  /** Rank range for matchmaking */
  MATCHMAKING_RANK_RANGE: 200,
} as const;
