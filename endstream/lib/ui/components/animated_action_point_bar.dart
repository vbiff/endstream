import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../animations/easing_curves.dart';
import 'component_enums.dart';
import 'tree_node.dart';

/// Action point bar with staggered left-to-right pulse animation on turn start.
///
/// When [isMyTurn] becomes true, each AP node pulses in sequence (Interval
/// stagger). When false, nodes immediately go dim.
class AnimatedActionPointBar extends StatefulWidget {
  const AnimatedActionPointBar({
    super.key,
    required this.total,
    required this.spent,
    required this.isMyTurn,
  });

  final int total;
  final int spent;
  final bool isMyTurn;

  @override
  State<AnimatedActionPointBar> createState() => _AnimatedActionPointBarState();
}

class _AnimatedActionPointBarState extends State<AnimatedActionPointBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    if (widget.isMyTurn) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedActionPointBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMyTurn && !oldWidget.isMyTurn) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1.0;
      } else {
        _controller.forward(from: 0.0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final available = (widget.total - widget.spent).clamp(0, widget.total);

    return Semantics(
      label: '$available of ${widget.total} action points',
      child: AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.total, (index) {
            final isAvailable = index < available;
            // Stagger: each node has a sub-interval
            final intervalStart = index / widget.total;
            final intervalEnd =
                ((index + 1) / widget.total).clamp(0.0, 1.0);
            final nodeProgress =
                Interval(intervalStart, intervalEnd, curve: TreeCurves.standard)
                    .transform(_controller.value);

            Color color;
            if (isAvailable && widget.isMyTurn) {
              // Pulse: scale from dormant to activation
              color = Color.lerp(
                    TreeColors.dormant,
                    TreeColors.activation,
                    nodeProgress,
                  ) ??
                  TreeColors.activation;
            } else {
              color = isAvailable ? TreeColors.activation : TreeColors.dormant;
            }

            return Padding(
              padding:
                  EdgeInsets.only(right: index < widget.total - 1 ? 4 : 0),
              child: TreeNode(
                size: 10,
                shape: TreeNodeShape.square,
                color: color,
              ),
            );
          }),
        );
      },
      ),
    );
  }
}
