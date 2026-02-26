import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints an illuminating line from attacker to defender with a 3-cycle flicker.
///
/// Progress 0.0→0.6: line extends from [from] toward [to].
/// Progress 0.6→1.0: 3 flicker cycles at full extension, then fade.
class CombatLinePainter extends CustomPainter {
  CombatLinePainter({
    required this.from,
    required this.to,
    required this.progress,
    required this.damage,
  });

  final Offset from;
  final Offset to;
  final double progress;
  final int damage;

  static const _lineExtendEnd = 0.6;
  static const _flickerCycles = 3;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final extendProgress = (progress / _lineExtendEnd).clamp(0.0, 1.0);
    final currentTo = Offset.lerp(from, to, extendProgress)!;

    // Flicker alpha during post-extension phase
    double alpha = 1.0;
    if (progress > _lineExtendEnd) {
      final flickerT = (progress - _lineExtendEnd) / (1.0 - _lineExtendEnd);
      // 3 sine cycles → flicker
      alpha = (math.sin(flickerT * _flickerCycles * math.pi * 2) * 0.3 + 0.7)
          .clamp(0.0, 1.0);
      // Fade out in final 20%
      if (flickerT > 0.8) {
        alpha *= 1.0 - ((flickerT - 0.8) / 0.2);
      }
    }

    // Main line
    final paint = Paint()
      ..color = TreeColors.error.withValues(alpha: alpha)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(from, currentTo, paint);

    // Glow line (wider, lower opacity)
    final glowPaint = Paint()
      ..color = TreeColors.error.withValues(alpha: alpha * 0.3)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(from, currentTo, glowPaint);

    // Impact marker at defender when line fully extended
    if (extendProgress >= 1.0) {
      final markerPaint = Paint()
        ..color = TreeColors.error.withValues(alpha: alpha)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromCenter(center: to, width: 6, height: 6),
        markerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CombatLinePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.from != from ||
      oldDelegate.to != to;
}
