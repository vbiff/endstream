import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints downward-propagating error-red dimming lines for defeat.
///
/// Lines propagate from top-center downward, simulating timeline collapse.
class DefeatCascadePainter extends CustomPainter {
  DefeatCascadePainter({required Animation<double> animation})
      : _animation = animation,
        super(repaint: animation) {
    _precomputeLines();
  }

  final Animation<double> _animation;

  static const _lineCount = 10;
  static const _maxHeight = 0.7;

  // Cached Paint objects
  final Paint _linePaint = Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;
  final Paint _markPaint = Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  // Reusable Path object
  final Path _path = Path();

  // Precomputed per-line random values
  late final List<double> _spreadFactors;
  late final List<double> _heightFactors;

  void _precomputeLines() {
    final rng = math.Random(37);
    _spreadFactors = List.generate(_lineCount, (_) => rng.nextDouble() - 0.5);
    _heightFactors = List.generate(_lineCount, (_) => 0.5 + rng.nextDouble() * 0.5);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final progress = _animation.value;
    if (progress <= 0) return;

    final centerX = size.width / 2;

    for (int i = 0; i < _lineCount; i++) {
      final lineDelay = i * 0.07;
      final lineT = ((progress - lineDelay) / (1.0 - lineDelay)).clamp(0.0, 1.0);
      if (lineT <= 0) continue;

      final spreadX = _spreadFactors[i] * size.width * 0.5;
      final height = size.height * _maxHeight * _heightFactors[i];

      final startX = centerX + spreadX * 0.2;
      final startY = 0.0;
      final endX = centerX + spreadX;
      final endY = height * lineT;

      final midX = startX + (endX - startX) * 0.5;
      final midY = endY * 0.4;

      final alpha = (1.0 - (lineT * 0.3)).clamp(0.0, 1.0);
      _linePaint.color = TreeColors.error.withValues(alpha: alpha * 0.5);

      _path
        ..reset()
        ..moveTo(startX, startY)
        ..lineTo(midX, midY)
        ..lineTo(endX, endY);

      canvas.drawPath(_path, _linePaint);

      // Fracture mark at tip
      _markPaint.color = TreeColors.error.withValues(alpha: alpha * 0.8);
      canvas.drawLine(
        Offset(endX - 3, endY - 3),
        Offset(endX + 3, endY + 3),
        _markPaint,
      );
    }
  }

  @override
  bool shouldRepaint(DefeatCascadePainter oldDelegate) => false;
}
