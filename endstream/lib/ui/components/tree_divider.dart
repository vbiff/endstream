import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';
import 'tree_node.dart';

/// Thin horizontal line with a center diamond node.
class TreeDivider extends StatelessWidget {
  const TreeDivider({
    super.key,
    this.color = TreeColors.branchDefault,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Row(
      children: [
        Expanded(child: _Line(color: color)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TreeNode(
            size: 6,
            color: color,
            shape: TreeNodeShape.diamond,
          ),
        ),
        Expanded(child: _Line(color: color)),
      ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}
