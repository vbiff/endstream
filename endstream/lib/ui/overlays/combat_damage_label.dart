import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../animations/easing_curves.dart';

/// Floating "-N" damage text that fades upward and disappears.
///
/// Self-removes after animation completes.
class CombatDamageLabel extends StatefulWidget {
  const CombatDamageLabel({
    super.key,
    required this.damage,
    required this.position,
    this.onComplete,
  });

  final int damage;

  /// Screen-space position where the label appears.
  final Offset position;

  final VoidCallback? onComplete;

  @override
  State<CombatDamageLabel> createState() => _CombatDamageLabelState();
}

class _CombatDamageLabelState extends State<CombatDamageLabel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _offsetY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: TreeCurves.standard),
      ),
    );
    _offsetY = Tween<double>(begin: 0.0, end: -24.0).animate(
      CurvedAnimation(parent: _controller, curve: TreeCurves.standard),
    );
    _controller.forward().then((_) => widget.onComplete?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: widget.position.dx - 16,
          top: widget.position.dy + _offsetY.value,
          child: Opacity(
            opacity: _opacity.value,
            child: child,
          ),
        );
      },
      child: Text(
        '-${widget.damage}',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: TreeColors.error,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
