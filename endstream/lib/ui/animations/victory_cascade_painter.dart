import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints upward-propagating activation-yellow highlight pulses for victory.
///
/// Lines propagate from bottom-center upward in a tree-like pattern.
class VictoryCascadePainter extends CustomPainter {
  VictoryCascadePainter({required Animation<double> animation})
      : _animation = animation,
        super(repaint: animation) {
    _precomputeLines();
  }

  final Animation<double> _animation;

  static const _lineCount = 12;
  static const _maxHeight = 0.8; // fraction of canvas height

  // Cached Paint objects
  final Paint _linePaint = Paint()
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;
  final Paint _nodePaint = Paint()..style = PaintingStyle.fill;

  // Reusable Path object
  final Path _path = Path();

  // Precomputed per-line random values
  late final List<double> _spreadFactors;
  late final List<double> _heightFactors;

  void _precomputeLines() {
    final rng = math.Random(42);
    _spreadFactors = List.generate(_lineCount, (_) => rng.nextDouble() - 0.5);
    _heightFactors = List.generate(_lineCount, (_) => 0.6 + rng.nextDouble() * 0.4);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final progress = _animation.value;
    if (progress <= 0) return;

    final centerX = size.width / 2;
    final bottomY = size.height;

    for (int i = 0; i < _lineCount; i++) {
      final lineDelay = i * 0.06;
      final lineT = ((progress - lineDelay) / (1.0 - lineDelay)).clamp(0.0, 1.0);
      if (lineT <= 0) continue;

      final spreadX = _spreadFactors[i] * size.width * 0.6;
      final height = size.height * _maxHeight * _heightFactors[i];

      final startX = centerX + spreadX * 0.3;
      final startY = bottomY;
      final endX = centerX + spreadX;
      final endY = bottomY - height * lineT;

      final midX = startX + (endX - startX) * 0.4;
      final midY = startY + (endY - startY) * 0.5;

      final alpha = (1.0 - (lineT * 0.4)).clamp(0.0, 1.0);
      _linePaint.color = TreeColors.activation.withValues(alpha: alpha * 0.6);

      _path
        ..reset()
        ..moveTo(startX, startY)
        ..lineTo(midX, midY)
        ..lineTo(endX, endY);

      canvas.drawPath(_path, _linePaint);

      // Node at tip
      _nodePaint.color = TreeColors.activation.withValues(alpha: alpha);
      canvas.drawRect(
        Rect.fromCenter(center: Offset(endX, endY), width: 3, height: 3),
        _nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(VictoryCascadePainter oldDelegate) => false;
}
