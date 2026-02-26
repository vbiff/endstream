import 'package:flutter/material.dart';

import '../../../core/models/models.dart';
import '../shared/shared.dart';
import 'deck_editor_deck_card_item.dart';

/// Grid showing cards currently in the deck.
class DeckEditorContentsGrid extends StatelessWidget {
  const DeckEditorContentsGrid({
    super.key,
    required this.deckCards,
    required this.allCards,
    required this.onRemove,
    required this.onCardTap,
  });

  final List<DeckCard> deckCards;
  final List<GameCard> allCards;
  final ValueChanged<String> onRemove;
  final ValueChanged<GameCard> onCardTap;

  GameCard? _findCard(String cardId) {
    try {
      return allCards.firstWhere((c) => c.id == cardId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (deckCards.isEmpty) {
      return const ScreenEmptyDisplay(message: 'Deck is empty');
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: deckCards.length,
      itemBuilder: (context, index) {
        final deckCard = deckCards[index];
        final card = _findCard(deckCard.cardId);
        if (card == null) return const SizedBox.shrink();

        return DeckEditorDeckCardItem(
          card: card,
          quantity: deckCard.quantity,
          onTap: () => onCardTap(card),
          onRemove: () => onRemove(deckCard.cardId),
        );
      },
    );
  }
}
