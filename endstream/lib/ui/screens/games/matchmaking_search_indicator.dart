import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Animated indicator with two diamond nodes and a pulsing branch between them.
class MatchmakingSearchIndicator extends StatefulWidget {
  const MatchmakingSearchIndicator({super.key});

  @override
  State<MatchmakingSearchIndicator> createState() =>
      _MatchmakingSearchIndicatorState();
}

class _MatchmakingSearchIndicatorState extends State<MatchmakingSearchIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
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
      builder: (context, _) {
        final opacity = 0.3 + (_controller.value * 0.7);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TreeNode(
              size: 10,
              color: TreeColors.highlight,
              shape: TreeNodeShape.diamond,
            ),
            const SizedBox(width: 8),
            Opacity(
              opacity: opacity,
              child: TreeBranch(
                length: 80,
                animated: true,
                color: TreeColors.branchActive,
                thickness: 1.0,
              ),
            ),
            const SizedBox(width: 8),
            Opacity(
              opacity: 1.0 - (_controller.value * 0.5),
              child: const TreeNode(
                size: 10,
                color: TreeColors.dormant,
                shape: TreeNodeShape.diamond,
              ),
            ),
          ],
        );
      },
    );
  }
}
