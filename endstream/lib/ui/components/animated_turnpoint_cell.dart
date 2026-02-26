import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../animations/easing_curves.dart';

/// Wraps a turnpoint cell with a brief border flash when a new operator arrives.
///
/// Detects arrival by comparing [operatorCount] in [didUpdateWidget].
/// When count increases, flashes the border from activation color to transparent.
class AnimatedTurnpointCell extends StatefulWidget {
  const AnimatedTurnpointCell({
    super.key,
    required this.operatorCount,
    required this.child,
  });

  final int operatorCount;
  final Widget child;

  @override
  State<AnimatedTurnpointCell> createState() => _AnimatedTurnpointCellState();
}

class _AnimatedTurnpointCellState extends State<AnimatedTurnpointCell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _flashOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: TreeDurations.fast,
    );
    _flashOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: TreeCurves.standard),
    );
  }

  @override
  void didUpdateWidget(AnimatedTurnpointCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.operatorCount > oldWidget.operatorCount &&
        !MediaQuery.disableAnimationsOf(context)) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flashOpacity,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: TreeColors.activation
                  .withValues(alpha: _flashOpacity.value * 0.6),
              width: _controller.isAnimating ? 1.5 : 0,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
