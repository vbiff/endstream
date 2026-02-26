import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/action_point_bar.dart';
import '../../components/component_enums.dart';
import '../../components/tree_node.dart';

/// Top section of the hand panel — shows AP display and "HAND" label.
class HandActionBar extends StatelessWidget {
  const HandActionBar({
    super.key,
    required this.actionPoints,
    required this.maxActionPoints,
  });

  final int actionPoints;
  final int maxActionPoints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          TreeNode(
            size: 6,
            shape: TreeNodeShape.diamond,
            color: TreeColors.activation,
          ),
          const SizedBox(width: 8),
          Text(
            'HAND',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: TreeColors.textSecondary,
                  letterSpacing: 1.2,
                ),
          ),
          const Spacer(),
          Text(
            'AP ',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: TreeColors.textSecondary,
                ),
          ),
          ActionPointBar(
            total: maxActionPoints,
            spent: maxActionPoints - actionPoints,
          ),
        ],
      ),
    );
  }
}
