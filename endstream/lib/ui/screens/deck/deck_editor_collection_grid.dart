import 'package:flutter/material.dart';

import '../../../core/models/models.dart';
import '../../components/components.dart';

/// Grid of available cards from the collection.
class DeckEditorCollectionGrid extends StatelessWidget {
  const DeckEditorCollectionGrid({
    super.key,
    required this.cards,
    required this.onAdd,
    required this.onCardTap,
  });

  final List<GameCard> cards;
  final ValueChanged<String> onAdd;
  final ValueChanged<GameCard> onCardTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return GestureDetector(
          onTap: () => onAdd(card.id),
          onLongPress: () => onCardTap(card),
          child: CardThumbnail(card: card),
        );
      },
    );
  }
}
