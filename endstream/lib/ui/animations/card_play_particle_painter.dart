import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints angular-path particles traveling from hand area to target cell.
///
/// Particles follow segmented paths (not curves) and converge on the target.
class CardPlayParticlePainter extends CustomPainter {
  CardPlayParticlePainter({
    required this.from,
    required this.to,
    required this.animation,
  }) : super(repaint: animation) {
    _precomputeParticles();
  }

  final Offset from;
  final Offset to;
  final Animation<double> animation;

  static const _particleCount = 8;
  static const _particleSize = 2.5;

  // Cached Paint object
  final Paint _paint = Paint()..style = PaintingStyle.fill;

  // Precomputed per-particle random values
  late final List<double> _laterals;
  late final List<double> _alphaFactors;

  void _precomputeParticles() {
    final rng = math.Random(from.dx.toInt() ^ to.dy.toInt());
    _laterals = List.generate(
      _particleCount,
      (_) => (rng.nextDouble() - 0.5) * 60,
    );
    _alphaFactors = List.generate(
      _particleCount,
      (_) => 0.5 + rng.nextDouble() * 0.5,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final progress = animation.value;
    if (progress <= 0) return;

    final alpha = progress < 0.8 ? 1.0 : (1.0 - progress) / 0.2;

    for (int i = 0; i < _particleCount; i++) {
      // Each particle has a slightly different timing offset
      final offset = i * 0.06;
      final particleT = ((progress - offset) / (1.0 - offset)).clamp(0.0, 1.0);
      if (particleT <= 0) continue;

      // Angular path: go sideways first, then straight to target
      final midpoint = Offset(
        from.dx + _laterals[i],
        from.dy + (to.dy - from.dy) * 0.4,
      );

      Offset pos;
      if (particleT < 0.4) {
        pos = Offset.lerp(from, midpoint, particleT / 0.4)!;
      } else {
        pos = Offset.lerp(midpoint, to, (particleT - 0.4) / 0.6)!;
      }

      final particleAlpha = (alpha * _alphaFactors[i]).clamp(0.0, 1.0);
      _paint.color = TreeColors.activation.withValues(alpha: particleAlpha);

      canvas.drawRect(
        Rect.fromCenter(
          center: pos,
          width: _particleSize,
          height: _particleSize,
        ),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(CardPlayParticlePainter oldDelegate) =>
      oldDelegate.from != from || oldDelegate.to != to;
}
