import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints downward-propagating error-red dimming lines for defeat.
///
/// Lines propagate from top-center downward, simulating timeline collapse.
class DefeatCascadePainter extends CustomPainter {
  DefeatCascadePainter({required this.progress});

  /// 0.0 = cascade starts, 1.0 = fully collapsed.
  final double progress;

  static const _lineCount = 10;
  static const _maxHeight = 0.7;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final centerX = size.width / 2;
    final rng = math.Random(37);

    for (int i = 0; i < _lineCount; i++) {
      final lineDelay = i * 0.07;
      final lineT = ((progress - lineDelay) / (1.0 - lineDelay)).clamp(0.0, 1.0);
      if (lineT <= 0) continue;

      final spreadX = (rng.nextDouble() - 0.5) * size.width * 0.5;
      final height = size.height * _maxHeight * (0.5 + rng.nextDouble() * 0.5);

      final startX = centerX + spreadX * 0.2;
      final startY = 0.0;
      final endX = centerX + spreadX;
      final endY = height * lineT;

      final midX = startX + (endX - startX) * 0.5;
      final midY = endY * 0.4;

      final alpha = (1.0 - (lineT * 0.3)).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = TreeColors.error.withValues(alpha: alpha * 0.5)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      final path = Path()
        ..moveTo(startX, startY)
        ..lineTo(midX, midY)
        ..lineTo(endX, endY);

      canvas.drawPath(path, paint);

      // Fracture mark at tip
      final markPaint = Paint()
        ..color = TreeColors.error.withValues(alpha: alpha * 0.8)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
        Offset(endX - 3, endY - 3),
        Offset(endX + 3, endY + 3),
        markPaint,
      );
    }
  }

  @override
  bool shouldRepaint(DefeatCascadePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
