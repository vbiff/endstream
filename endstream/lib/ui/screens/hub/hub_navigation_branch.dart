import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// A single navigation branch with node, label, and optional badge count.
class HubNavigationBranch extends StatelessWidget {
  const HubNavigationBranch({
    super.key,
    required this.label,
    required this.onTap,
    this.badgeCount,
  });

  final String label;
  final VoidCallback onTap;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const TreeNode(size: 8, color: TreeColors.nodePoint),
          const SizedBox(width: 12),
          const TreeBranch(
            direction: TreeBranchDirection.horizontal,
            length: 24,
            color: TreeColors.branchActive,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                color: TreeColors.textPrimary,
              ),
            ),
          ),
          if (badgeCount != null && badgeCount! > 0)
            TreeBadge(
              text: '$badgeCount',
              color: TreeColors.activation,
            ),
          const TreeNode(
            size: 6,
            color: TreeColors.dormant,
            shape: TreeNodeShape.diamond,
          ),
        ],
      ),
    );
  }
}
