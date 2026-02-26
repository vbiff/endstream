import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';
import 'tree_node.dart';

/// Node with a centered numeric value and label below.
class ResourceCounter extends StatelessWidget {
  const ResourceCounter({
    super.key,
    required this.value,
    required this.label,
    this.color = TreeColors.highlight,
  });

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 28,
          height: 28,
          child: Stack(
            alignment: Alignment.center,
            children: [
              TreeNode(
                size: 28,
                color: color,
                shape: TreeNodeShape.square,
              ),
              Text(
                '$value',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: TreeColors.textPrimary,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: TreeColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
