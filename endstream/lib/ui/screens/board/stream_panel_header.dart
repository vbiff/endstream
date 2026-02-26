import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/component_enums.dart';
import '../../components/tree_node.dart';

/// Header label for a stream panel with indicator node.
class StreamPanelHeader extends StatelessWidget {
  const StreamPanelHeader({
    super.key,
    required this.label,
    required this.isOpponent,
  });

  final String label;
  final bool isOpponent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          TreeNode(
            size: 6,
            shape: TreeNodeShape.diamond,
            color: isOpponent ? TreeColors.error : TreeColors.highlight,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: TreeColors.textSecondary,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }
}
