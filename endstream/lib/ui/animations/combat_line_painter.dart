import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../../app/theme.dart';
import 'elimination_painter.dart';

/// Paints an illuminating line from attacker to defender with a 3-cycle flicker.
///
/// Progress 0.0→0.6: line extends from [from] toward [to].
/// Progress 0.6→1.0: 3 flicker cycles at full extension, then fade.
///
/// When [isElimination] is true, delegates to [EliminationPainter] for the
/// final 25% of the animation.
class CombatLinePainter extends CustomPainter {
  CombatLinePainter({
    required this.from,
    required this.to,
    required this.animation,
    required this.damage,
    this.isElimination = false,
  }) : super(repaint: animation);

  final Offset from;
  final Offset to;
  final Animation<double> animation;
  final int damage;
  final bool isElimination;

  static const _lineExtendEnd = 0.6;
  static const _flickerCycles = 3;

  // Cached Paint objects — reused across frames
  final Paint _linePaint = Paint()
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;
  final Paint _glowPaint = Paint()
    ..strokeWidth = 4.0
    ..style = PaintingStyle.stroke;
  final Paint _markerPaint = Paint()..style = PaintingStyle.fill;

  // Cached elimination sub-painter
  EliminationPainter? _eliminationPainter;

  @override
  void paint(Canvas canvas, Size size) {
    final progress = animation.value;
    if (progress <= 0) return;

    // Elimination phase: delegate to fracture effect
    if (isElimination && progress > 0.75) {
      _eliminationPainter ??= EliminationPainter(center: to);
      _eliminationPainter!.paintAt(
        canvas,
        size,
        ((progress - 0.75) / 0.25).clamp(0.0, 1.0),
      );
      return;
    }

    final extendProgress = (progress / _lineExtendEnd).clamp(0.0, 1.0);
    final currentTo = Offset.lerp(from, to, extendProgress)!;

    // Flicker alpha during post-extension phase
    double alpha = 1.0;
    if (progress > _lineExtendEnd) {
      final flickerT = (progress - _lineExtendEnd) / (1.0 - _lineExtendEnd);
      alpha = (math.sin(flickerT * _flickerCycles * math.pi * 2) * 0.3 + 0.7)
          .clamp(0.0, 1.0);
      if (flickerT > 0.8) {
        alpha *= 1.0 - ((flickerT - 0.8) / 0.2);
      }
    }

    // Main line
    _linePaint.color = TreeColors.error.withValues(alpha: alpha);
    canvas.drawLine(from, currentTo, _linePaint);

    // Glow line (wider, lower opacity)
    _glowPaint.color = TreeColors.error.withValues(alpha: alpha * 0.3);
    canvas.drawLine(from, currentTo, _glowPaint);

    // Impact marker at defender when line fully extended
    if (extendProgress >= 1.0) {
      _markerPaint.color = TreeColors.error.withValues(alpha: alpha);
      canvas.drawRect(
        Rect.fromCenter(center: to, width: 6, height: 6),
        _markerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CombatLinePainter oldDelegate) =>
      oldDelegate.from != from || oldDelegate.to != to;
}
