import { GAME_CONSTANTS } from "./constants.ts";
import type { Card, DeckCardEntry, DeckValidationResult } from "./types.ts";

/**
 * Validate a deck against game rules.
 * Rules:
 *  - Exactly 30 total cards
 *  - Max 2 copies of any single card
 *  - At least 1 operator card
 *  - All card IDs must exist in the catalog
 */
export function validateDeck(
  deckCards: DeckCardEntry[],
  cardCatalog: Card[],
): DeckValidationResult {
  const errors: string[] = [];
  const catalogMap = new Map(cardCatalog.map((c) => [c.id, c]));

  // Check total count
  const totalCards = deckCards.reduce((sum, dc) => sum + dc.quantity, 0);
  if (totalCards !== GAME_CONSTANTS.DECK_SIZE) {
    errors.push(
      `Deck must contain exactly ${GAME_CONSTANTS.DECK_SIZE} cards, found ${totalCards}`,
    );
  }

  let operatorCount = 0;

  for (const dc of deckCards) {
    // Check card exists
    const card = catalogMap.get(dc.card_id);
    if (!card) {
      errors.push(`Card ID ${dc.card_id} not found in catalog`);
      continue;
    }

    // Check max copies
    if (dc.quantity > GAME_CONSTANTS.MAX_COPIES_PER_CARD) {
      errors.push(
        `Card "${card.name}" has ${dc.quantity} copies, max is ${GAME_CONSTANTS.MAX_COPIES_PER_CARD}`,
      );
    }

    // Count operators
    if (card.type === "operator") {
      operatorCount += dc.quantity;
    }
  }

  // Check minimum operators
  if (operatorCount < GAME_CONSTANTS.MIN_OPERATORS) {
    errors.push(
      `Deck must contain at least ${GAME_CONSTANTS.MIN_OPERATORS} operator card(s), found ${operatorCount}`,
    );
  }

  return { valid: errors.length === 0, errors };
}
