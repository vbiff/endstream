import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Top bar for deck editor with name, card count, save, and cancel.
class DeckEditorTopBar extends StatelessWidget {
  const DeckEditorTopBar({
    super.key,
    required this.deckName,
    required this.totalCards,
    required this.hasChanges,
    required this.onSave,
    required this.onCancel,
  });

  final String deckName;
  final int totalCards;
  final bool hasChanges;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onCancel,
            child: const Text(
              '<',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 18,
                color: TreeColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              deckName.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
                color: TreeColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TreeBadge(
            text: '$totalCards/30',
            color: totalCards >= 30
                ? TreeColors.activation
                : TreeColors.dormant,
          ),
          if (hasChanges) ...[
            const SizedBox(width: 8),
            TreeButton(
              onPressed: onSave,
              label: 'SAVE',
            ),
          ],
        ],
      ),
    );
  }
}
