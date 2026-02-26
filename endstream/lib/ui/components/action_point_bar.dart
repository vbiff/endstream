import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';
import 'tree_node.dart';

/// Row of square nodes representing action points — spent nodes appear dormant.
class ActionPointBar extends StatelessWidget {
  const ActionPointBar({
    super.key,
    required this.total,
    required this.spent,
  });

  final int total;
  final int spent;

  @override
  Widget build(BuildContext context) {
    final available = total - spent;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        return Padding(
          padding: EdgeInsets.only(right: index < total - 1 ? 4 : 0),
          child: TreeNode(
            size: 10,
            shape: TreeNodeShape.square,
            color: index < available
                ? TreeColors.activation
                : TreeColors.dormant,
          ),
        );
      }),
    );
  }
}
