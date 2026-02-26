import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints upward-propagating activation-yellow highlight pulses for victory.
///
/// Lines propagate from bottom-center upward in a tree-like pattern.
class VictoryCascadePainter extends CustomPainter {
  VictoryCascadePainter({required this.progress});

  /// 0.0 = cascade starts, 1.0 = fully propagated.
  final double progress;

  static const _lineCount = 12;
  static const _maxHeight = 0.8; // fraction of canvas height

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final centerX = size.width / 2;
    final bottomY = size.height;
    final rng = math.Random(42);

    for (int i = 0; i < _lineCount; i++) {
      final lineDelay = i * 0.06;
      final lineT = ((progress - lineDelay) / (1.0 - lineDelay)).clamp(0.0, 1.0);
      if (lineT <= 0) continue;

      final spreadX = (rng.nextDouble() - 0.5) * size.width * 0.6;
      final height = size.height * _maxHeight * (0.6 + rng.nextDouble() * 0.4);

      final startX = centerX + spreadX * 0.3;
      final startY = bottomY;
      final endX = centerX + spreadX;
      final endY = bottomY - height * lineT;

      // Midpoint for angular path
      final midX = startX + (endX - startX) * 0.4;
      final midY = startY + (endY - startY) * 0.5;

      final alpha = (1.0 - (lineT * 0.4)).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = TreeColors.activation.withValues(alpha: alpha * 0.6)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      final path = Path()
        ..moveTo(startX, startY)
        ..lineTo(midX, midY)
        ..lineTo(endX, endY);

      canvas.drawPath(path, paint);

      // Node at tip
      final nodePaint = Paint()
        ..color = TreeColors.activation.withValues(alpha: alpha)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromCenter(center: Offset(endX, endY), width: 3, height: 3),
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(VictoryCascadePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
