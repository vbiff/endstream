import 'package:flutter/material.dart';

import '../../../core/models/game_card.dart';
import 'hand_card_item.dart';

/// Scrollable list of cards in the player's hand.
class HandCardList extends StatelessWidget {
  const HandCardList({
    super.key,
    required this.hand,
    required this.actionPoints,
    required this.isMyTurn,
    this.selectedCardId,
    this.onSelectCard,
    this.onLongPressCard,
  });

  final List<GameCard> hand;
  final int actionPoints;
  final bool isMyTurn;
  final String? selectedCardId;
  final void Function(GameCard)? onSelectCard;
  final void Function(GameCard)? onLongPressCard;

  @override
  Widget build(BuildContext context) {
    if (hand.isEmpty) {
      return const _EmptyHandMessage();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: hand.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final card = hand[index];
        final isPlayable = isMyTurn && card.cost <= actionPoints;
        final isSelected = card.id == selectedCardId;

        return HandCardItem(
          card: card,
          isSelected: isSelected,
          isPlayable: isPlayable,
          onTap: isPlayable ? () => onSelectCard?.call(card) : null,
          onLongPress: () => onLongPressCard?.call(card),
        );
      },
    );
  }
}

class _EmptyHandMessage extends StatelessWidget {
  const _EmptyHandMessage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'NO CARDS IN HAND',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF3A3A42),
            ),
      ),
    );
  }
}
