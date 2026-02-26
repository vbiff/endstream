import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Small angular label for status indicators, costs, and tags.
class TreeBadge extends StatelessWidget {
  const TreeBadge({
    super.key,
    required this.text,
    this.color = TreeColors.highlight,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        color: color.withValues(alpha: 0.15),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
            ),
      ),
      ),
    );
  }
}
