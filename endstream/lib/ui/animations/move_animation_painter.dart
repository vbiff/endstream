import 'package:flutter/rendering.dart';

import '../../app/theme.dart';

/// Paints a sliding token indicator with trailing dots during operator movement.
///
/// The main dot moves from [from] to [to] along [progress].
/// A trail of fading dots follows behind.
class MoveAnimationPainter extends CustomPainter {
  MoveAnimationPainter({
    required this.from,
    required this.to,
    required this.progress,
  });

  final Offset from;
  final Offset to;
  final double progress;

  static const _trailCount = 4;
  static const _trailSpacing = 0.08;
  static const _mainDotSize = 4.0;
  static const _trailDotSize = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final currentPos = Offset.lerp(from, to, progress)!;

    // Main dot
    final alpha = progress < 0.9 ? 1.0 : (1.0 - progress) / 0.1;
    final mainPaint = Paint()
      ..color = TreeColors.highlight.withValues(alpha: alpha.clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(
        center: currentPos,
        width: _mainDotSize,
        height: _mainDotSize,
      ),
      mainPaint,
    );

    // Trailing dots
    for (int i = 1; i <= _trailCount; i++) {
      final trailT = (progress - i * _trailSpacing).clamp(0.0, 1.0);
      if (trailT <= 0) continue;
      final trailPos = Offset.lerp(from, to, trailT)!;
      final trailAlpha = (alpha * (1.0 - i / (_trailCount + 1))).clamp(0.0, 1.0);
      final trailPaint = Paint()
        ..color = TreeColors.highlight.withValues(alpha: trailAlpha)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromCenter(
          center: trailPos,
          width: _trailDotSize,
          height: _trailDotSize,
        ),
        trailPaint,
      );
    }
  }

  @override
  bool shouldRepaint(MoveAnimationPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.from != from ||
      oldDelegate.to != to;
}
