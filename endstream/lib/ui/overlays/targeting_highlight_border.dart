import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../animations/easing_curves.dart';

/// Pulsing activation-yellow border around valid target cells during targeting.
class TargetingHighlightBorder extends StatefulWidget {
  const TargetingHighlightBorder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<TargetingHighlightBorder> createState() =>
      _TargetingHighlightBorderState();
}

class _TargetingHighlightBorderState extends State<TargetingHighlightBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _opacity = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: TreeCurves.subtle),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: TreeColors.activation.withValues(alpha: _opacity.value),
              width: 2,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
