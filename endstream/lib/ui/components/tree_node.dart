import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';

/// Small square or diamond marker representing a node on the time tree.
class TreeNode extends StatelessWidget {
  const TreeNode({
    super.key,
    this.size = 8.0,
    this.color = TreeColors.nodePoint,
    this.shape = TreeNodeShape.square,
  });

  final double size;
  final Color color;
  final TreeNodeShape shape;

  @override
  Widget build(BuildContext context) {
    final box = SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
      ),
    );

    final visual = shape == TreeNodeShape.diamond
        ? Transform.rotate(angle: math.pi / 4, child: box)
        : box;

    return ExcludeSemantics(child: visual);
  }
}
