import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints angular-path particles traveling from hand area to target cell.
///
/// Particles follow segmented paths (not curves) and converge on the target.
class CardPlayParticlePainter extends CustomPainter {
  CardPlayParticlePainter({
    required this.from,
    required this.to,
    required this.progress,
  });

  final Offset from;
  final Offset to;
  final double progress;

  static const _particleCount = 8;
  static const _particleSize = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final rng = math.Random(from.dx.toInt() ^ to.dy.toInt());
    final alpha = progress < 0.8 ? 1.0 : (1.0 - progress) / 0.2;

    for (int i = 0; i < _particleCount; i++) {
      // Each particle has a slightly different timing offset
      final offset = i * 0.06;
      final particleT = ((progress - offset) / (1.0 - offset)).clamp(0.0, 1.0);
      if (particleT <= 0) continue;

      // Angular path: go sideways first, then straight to target
      final lateral = (rng.nextDouble() - 0.5) * 60;
      final midpoint = Offset(
        from.dx + lateral,
        from.dy + (to.dy - from.dy) * 0.4,
      );

      Offset pos;
      if (particleT < 0.4) {
        pos = Offset.lerp(from, midpoint, particleT / 0.4)!;
      } else {
        pos = Offset.lerp(midpoint, to, (particleT - 0.4) / 0.6)!;
      }

      final particleAlpha = (alpha * (0.5 + rng.nextDouble() * 0.5)).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = TreeColors.activation.withValues(alpha: particleAlpha)
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromCenter(
          center: pos,
          width: _particleSize,
          height: _particleSize,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CardPlayParticlePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.from != from ||
      oldDelegate.to != to;
}
