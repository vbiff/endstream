import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme.dart';
import '../../ui/animations/easing_curves.dart';

/// Angular container panel — the foundational layout primitive.
class TreeCard extends StatelessWidget {
  const TreeCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.highlighted = false,
    this.highlightColor,
    this.onTap,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool highlighted;
  final Color? highlightColor;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final gestureChild = GestureDetector(
      onTap: onTap != null
          ? () {
              HapticFeedback.selectionClick();
              onTap!();
            }
          : null,
      child: AnimatedContainer(
        duration: TreeDurations.fast,
        curve: TreeCurves.standard,
        padding: padding,
        decoration: BoxDecoration(
          color: TreeColors.surface,
          border: Border.all(
            color: highlighted
                ? (highlightColor ?? TreeColors.highlight)
                : TreeColors.branchDefault,
            width: 1,
          ),
        ),
        child: child,
      ),
    );
    if (onTap != null) {
      return Semantics(
        button: true,
        label: semanticLabel,
        child: gestureChild,
      );
    }
    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, child: gestureChild);
    }
    return gestureChild;
  }
}
