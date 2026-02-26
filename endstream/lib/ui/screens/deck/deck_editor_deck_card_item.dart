import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/models.dart';
import '../../components/components.dart';

/// Deck card item with quantity badge and remove ability.
class DeckEditorDeckCardItem extends StatelessWidget {
  const DeckEditorDeckCardItem({
    super.key,
    required this.card,
    required this.quantity,
    required this.onTap,
    required this.onRemove,
  });

  final GameCard card;
  final int quantity;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onRemove,
      child: Stack(
        children: [
          CardThumbnail(card: card),
          if (quantity > 1)
            Positioned(
              top: 2,
              right: 2,
              child: TreeBadge(
                text: 'x$quantity',
                color: TreeColors.activation,
              ),
            ),
        ],
      ),
    );
  }
}
