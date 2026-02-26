import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';
import 'tree_node.dart';

/// Friend row showing online status, name, rank, and a trailing diamond.
class FriendEntry extends StatelessWidget {
  const FriendEntry({
    super.key,
    required this.displayName,
    required this.isOnline,
    this.rank = 1000,
    this.wins = 0,
    this.onTap,
  });

  final String displayName;
  final bool isOnline;
  final int rank;
  final int wins;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            TreeNode(
              size: 10,
              shape: TreeNodeShape.square,
              color: isOnline ? TreeColors.highlight : TreeColors.dormant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayName,
                    style: textTheme.titleMedium?.copyWith(
                      color: TreeColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rank $rank',
                    style: textTheme.labelSmall?.copyWith(
                      color: TreeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            TreeNode(
              size: 8,
              shape: TreeNodeShape.diamond,
              color: TreeColors.nodePoint,
            ),
          ],
        ),
      ),
    );
  }
}
