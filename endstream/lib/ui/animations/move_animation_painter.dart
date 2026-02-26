import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import '../../app/theme.dart';
import 'easing_curves.dart';

/// Paints a sliding token indicator with trailing dots during operator movement.
///
/// The main dot moves from [from] to [to] along [progress].
/// A trail of fading dots follows behind.
class MoveAnimationPainter extends CustomPainter {
  MoveAnimationPainter({
    required this.from,
    required this.to,
    required this.animation,
  }) : super(repaint: animation);

  final Offset from;
  final Offset to;
  final Animation<double> animation;

  static const _trailCount = 4;
  static const _trailSpacing = 0.08;
  static const _mainDotSize = 4.0;
  static const _trailDotSize = 2.0;

  // Cached Paint objects
  final Paint _mainPaint = Paint()..style = PaintingStyle.fill;
  final Paint _trailPaint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final progress = TreeCurves.standard.transform(animation.value);
    if (progress <= 0) return;

    final currentPos = Offset.lerp(from, to, progress)!;

    // Main dot
    final alpha = progress < 0.9 ? 1.0 : (1.0 - progress) / 0.1;
    _mainPaint.color =
        TreeColors.highlight.withValues(alpha: alpha.clamp(0.0, 1.0));
    canvas.drawRect(
      Rect.fromCenter(
        center: currentPos,
        width: _mainDotSize,
        height: _mainDotSize,
      ),
      _mainPaint,
    );

    // Trailing dots
    for (int i = 1; i <= _trailCount; i++) {
      final trailT = (progress - i * _trailSpacing).clamp(0.0, 1.0);
      if (trailT <= 0) continue;
      final trailPos = Offset.lerp(from, to, trailT)!;
      final trailAlpha =
          (alpha * (1.0 - i / (_trailCount + 1))).clamp(0.0, 1.0);
      _trailPaint.color =
          TreeColors.highlight.withValues(alpha: trailAlpha);
      canvas.drawRect(
        Rect.fromCenter(
          center: trailPos,
          width: _trailDotSize,
          height: _trailDotSize,
        ),
        _trailPaint,
      );
    }
  }

  @override
  bool shouldRepaint(MoveAnimationPainter oldDelegate) =>
      oldDelegate.from != from || oldDelegate.to != to;
}
