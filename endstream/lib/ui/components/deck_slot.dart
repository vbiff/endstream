import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';
import 'tree_badge.dart';
import 'tree_card.dart';
import 'tree_node.dart';

/// Deck entry in a list — shows name, card count, and validity badge.
class DeckSlot extends StatelessWidget {
  const DeckSlot({
    super.key,
    required this.name,
    required this.cardCount,
    required this.isValid,
    this.onTap,
  });

  final String name;
  final int cardCount;
  final bool isValid;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      label: '$name, $cardCount cards, ${isValid ? 'valid' : 'invalid'}',
      child: TreeCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TreeNode(
                  size: 10,
                  shape: TreeNodeShape.diamond,
                  color: isValid ? TreeColors.highlight : TreeColors.error,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      color: TreeColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$cardCount cards',
                  style: textTheme.labelSmall?.copyWith(
                    color: TreeColors.textSecondary,
                  ),
                ),
                TreeBadge(
                  text: isValid ? 'VALID' : 'INVALID',
                  color: isValid ? TreeColors.highlight : TreeColors.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
