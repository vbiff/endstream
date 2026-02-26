import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../animations/easing_curves.dart';

/// Pulsing indicator that shows whose turn it is.
class TurnIndicatorBadge extends StatefulWidget {
  const TurnIndicatorBadge({
    super.key,
    required this.isMyTurn,
  });

  final bool isMyTurn;

  @override
  State<TurnIndicatorBadge> createState() => _TurnIndicatorBadgeState();
}

class _TurnIndicatorBadgeState extends State<TurnIndicatorBadge>
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
    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: TreeCurves.subtle),
    );
    if (widget.isMyTurn) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(TurnIndicatorBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMyTurn && !oldWidget.isMyTurn) {
      _controller.repeat(reverse: true);
    } else if (!widget.isMyTurn && oldWidget.isMyTurn) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isMyTurn ? TreeColors.activation : TreeColors.dormant;
    final label = widget.isMyTurn ? 'YOUR TURN' : 'WAITING';

    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Opacity(
          opacity: widget.isMyTurn ? _opacity.value : 0.6,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
          color: color.withValues(alpha: 0.1),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
              ),
        ),
      ),
    );
  }
}
