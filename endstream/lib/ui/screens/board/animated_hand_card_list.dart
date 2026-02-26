import 'package:flutter/material.dart';

import '../../animations/easing_curves.dart';

/// Wraps its [child] with opacity animation on turn changes.
///
/// When [isMyTurn] is true, opacity is 1.0. When false, opacity dims to 0.6.
class AnimatedHandCardList extends StatefulWidget {
  const AnimatedHandCardList({
    super.key,
    required this.isMyTurn,
    required this.child,
  });

  final bool isMyTurn;
  final Widget child;

  @override
  State<AnimatedHandCardList> createState() => _AnimatedHandCardListState();
}

class _AnimatedHandCardListState extends State<AnimatedHandCardList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: TreeCurves.standard),
    );
    _controller.value = widget.isMyTurn ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(AnimatedHandCardList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMyTurn != oldWidget.isMyTurn) {
      if (widget.isMyTurn) {
        _controller.forward();
      } else {
        _controller.reverse();
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
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
