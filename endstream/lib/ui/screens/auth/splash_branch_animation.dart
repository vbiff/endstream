import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Animated vertical branches that grow top-to-bottom during splash.
class SplashBranchAnimation extends StatelessWidget {
  const SplashBranchAnimation({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final height = 120.0 * progress.clamp(0.0, 1.0);
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SplashBranchLine(height: height, color: TreeColors.branchDefault),
          const SizedBox(width: 12),
          _SplashBranchLine(
            height: (height * 0.85).clamp(0.0, 120.0),
            color: TreeColors.branchActive,
          ),
          const SizedBox(width: 12),
          _SplashBranchLine(
            height: (height * 0.7).clamp(0.0, 120.0),
            color: TreeColors.branchDefault,
          ),
        ],
      ),
    );
  }
}

class _SplashBranchLine extends StatelessWidget {
  const _SplashBranchLine({required this.height, required this.color});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: 1,
        height: height,
        child: ColoredBox(color: color),
      ),
    );
  }
}
