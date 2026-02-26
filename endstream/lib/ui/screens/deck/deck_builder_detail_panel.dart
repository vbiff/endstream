import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/models.dart';
import '../../components/components.dart';

/// Detail panel for the selected deck with action buttons.
class DeckBuilderDetailPanel extends StatelessWidget {
  const DeckBuilderDetailPanel({
    super.key,
    required this.deck,
    required this.onEdit,
    required this.onDuplicate,
    required this.onDelete,
  });

  final Deck deck;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      padding: const EdgeInsets.all(16),
      highlighted: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  deck.name.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.0,
                    color: TreeColors.textPrimary,
                  ),
                ),
              ),
              TreeBadge(
                text: '${deck.cards.fold(0, (sum, c) => sum + c.quantity)} CARDS',
                color: deck.isValid
                    ? TreeColors.highlight
                    : TreeColors.dormant,
              ),
            ],
          ),
          const SizedBox(height: 4),
          TreeBadge(
            text: deck.isValid ? 'VALID' : 'INVALID',
            color: deck.isValid ? TreeColors.highlight : TreeColors.error,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TreeButton(
                  onPressed: onEdit,
                  label: 'EDIT',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TreeButton(
                  onPressed: onDuplicate,
                  label: 'DUPLICATE',
                  variant: TreeButtonVariant.secondary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TreeButton(
                  onPressed: onDelete,
                  label: 'DELETE',
                  variant: TreeButtonVariant.danger,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
