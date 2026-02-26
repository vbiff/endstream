import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints a fracture effect — angular segments drifting apart and fading.
///
/// Used when an operator is eliminated (HP reaches 0).
class EliminationPainter extends CustomPainter {
  EliminationPainter({
    required this.center,
    required this.progress,
  });

  final Offset center;

  /// 0.0 = fracture begins, 1.0 = fully faded.
  final double progress;

  static const _segmentCount = 6;
  static const _maxDrift = 20.0;
  static const _segmentLength = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    final drift = _maxDrift * progress;
    final rng = math.Random(center.dx.toInt() ^ center.dy.toInt());

    final paint = Paint()
      ..color = TreeColors.error.withValues(alpha: alpha)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < _segmentCount; i++) {
      final angle = (i / _segmentCount) * math.pi * 2 + rng.nextDouble() * 0.5;
      final driftOffset = Offset(
        math.cos(angle) * drift,
        math.sin(angle) * drift,
      );
      final start = center + driftOffset;
      final segAngle = angle + rng.nextDouble() * 0.8 - 0.4;
      final end = start +
          Offset(
            math.cos(segAngle) * _segmentLength,
            math.sin(segAngle) * _segmentLength,
          );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(EliminationPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.center != center;
}
