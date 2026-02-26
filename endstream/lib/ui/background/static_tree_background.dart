import 'package:flutter/material.dart';

/// Full-screen static tree image with a dark overlay for auth screens.
class StaticTreeBackground extends StatelessWidget {
  const StaticTreeBackground({
    super.key,
    this.overlayOpacity = 0.55,
  });

  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const _TreeImage(),
        _DarkOverlay(opacity: overlayOpacity),
      ],
    );
  }
}

class _TreeImage extends StatelessWidget {
  const _TreeImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/tree_background.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class _DarkOverlay extends StatelessWidget {
  const _DarkOverlay({required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withValues(alpha: opacity),
    );
  }
}
