import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Fading logo text that appears at ~60% of splash progress.
class SplashLogoNode extends StatelessWidget {
  const SplashLogoNode({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final opacity = ((progress - 0.6) / 0.4).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity,
      child: const Text(
        'ENDSTREAM',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 28,
          fontWeight: FontWeight.w300,
          letterSpacing: 4.0,
          color: TreeColors.textPrimary,
        ),
      ),
    );
  }
}
