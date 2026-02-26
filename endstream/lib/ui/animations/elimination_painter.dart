import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints a fracture effect — angular segments drifting apart and fading.
///
/// Used when an operator is eliminated (HP reaches 0).
/// Can be used standalone or via [paintAt] when embedded in another painter.
class EliminationPainter extends CustomPainter {
  EliminationPainter({
    required this.center,
    Animation<double>? animation,
  }) : _animation = animation,
       super(repaint: animation) {
    _precomputeSegments();
  }

  final Offset center;
  final Animation<double>? _animation;

  static const _segmentCount = 6;
  static const _maxDrift = 20.0;
  static const _segmentLength = 12.0;

  final Paint _paint = Paint()
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

  // Precomputed random offsets per segment
  late final List<double> _angles;
  late final List<double> _segAngles;

  void _precomputeSegments() {
    final rng = math.Random(center.dx.toInt() ^ center.dy.toInt());
    _angles = List.generate(
      _segmentCount,
      (i) => (i / _segmentCount) * math.pi * 2 + rng.nextDouble() * 0.5,
    );
    _segAngles = List.generate(
      _segmentCount,
      (i) => _angles[i] + rng.nextDouble() * 0.8 - 0.4,
    );
  }

  /// Paint with an externally provided progress value (used by CombatLinePainter).
  void paintAt(Canvas canvas, Size size, double progress) {
    _paintWithProgress(canvas, progress);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final progress = _animation?.value ?? 0.0;
    _paintWithProgress(canvas, progress);
  }

  void _paintWithProgress(Canvas canvas, double progress) {
    if (progress <= 0) return;

    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    final drift = _maxDrift * progress;

    _paint.color = TreeColors.error.withValues(alpha: alpha);

    for (int i = 0; i < _segmentCount; i++) {
      final angle = _angles[i];
      final driftOffset = Offset(
        math.cos(angle) * drift,
        math.sin(angle) * drift,
      );
      final start = center + driftOffset;
      final segAngle = _segAngles[i];
      final end = start +
          Offset(
            math.cos(segAngle) * _segmentLength,
            math.sin(segAngle) * _segmentLength,
          );

      canvas.drawLine(start, end, _paint);
    }
  }

  @override
  bool shouldRepaint(EliminationPainter oldDelegate) =>
      oldDelegate.center != center;
}
