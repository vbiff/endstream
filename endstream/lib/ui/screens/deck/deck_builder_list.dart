import 'package:flutter/material.dart';

import '../../../core/models/models.dart';
import '../../components/components.dart';

/// Scrollable list of deck slots.
class DeckBuilderList extends StatelessWidget {
  const DeckBuilderList({
    super.key,
    required this.decks,
    required this.selectedDeckId,
    required this.onSelect,
  });

  final List<Deck> decks;
  final String? selectedDeckId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: decks.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final deck = decks[index];
          return SizedBox(
            width: 140,
            child: DeckSlot(
              name: deck.name,
              cardCount: deck.cards.length,
              isValid: deck.isValid,
              onTap: () => onSelect(deck.id),
            ),
          );
        },
      ),
    );
  }
}
