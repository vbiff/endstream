import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../animations/easing_curves.dart';

/// Operator token with animated HP bar — tweens on HP changes via
/// [didUpdateWidget], and plays scale/fade elimination when HP hits 0.
class AnimatedOperatorToken extends StatefulWidget {
  const AnimatedOperatorToken({
    super.key,
    required this.name,
    required this.currentHp,
    required this.maxHp,
    required this.attack,
    required this.isOwn,
    this.isSelected = false,
    this.onTap,
  });

  final String name;
  final int currentHp;
  final int maxHp;
  final int attack;
  final bool isOwn;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<AnimatedOperatorToken> createState() => _AnimatedOperatorTokenState();
}

class _AnimatedOperatorTokenState extends State<AnimatedOperatorToken>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hpController;
  late double _displayedRatio;
  late double _targetRatio;

  @override
  void initState() {
    super.initState();
    _hpController = AnimationController(
      vsync: this,
      duration: TreeDurations.fast,
    );
    _displayedRatio = _ratio(widget.currentHp, widget.maxHp);
    _targetRatio = _displayedRatio;
  }

  @override
  void didUpdateWidget(AnimatedOperatorToken oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentHp != oldWidget.currentHp ||
        widget.maxHp != oldWidget.maxHp) {
      _displayedRatio = _ratio(oldWidget.currentHp, oldWidget.maxHp);
      _targetRatio = _ratio(widget.currentHp, widget.maxHp);
      _hpController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _hpController.dispose();
    super.dispose();
  }

  double _ratio(int current, int max) =>
      max > 0 ? (current / max).clamp(0.0, 1.0) : 0.0;

  Color _hpColor(double ratio) {
    if (ratio > 0.66) return TreeColors.highlight;
    if (ratio > 0.33) return TreeColors.activation;
    return TreeColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isSelected
        ? TreeColors.activation
        : (widget.isOwn ? TreeColors.highlight : TreeColors.error);
    final initial =
        widget.name.isNotEmpty ? widget.name[0].toUpperCase() : '?';

    return Semantics(
      label:
          '${widget.name}, ${widget.currentHp} of ${widget.maxHp} HP, attack ${widget.attack}',
      button: widget.onTap != null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: TreeColors.surface,
                border: Border.all(color: borderColor, width: 1),
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: TreeColors.textPrimary),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedBuilder(
              animation: _hpController,
              builder: (context, _) {
                final t = CurvedAnimation(
                  parent: _hpController,
                  curve: TreeCurves.standard,
                ).value;
                final ratio = _displayedRatio + (_targetRatio - _displayedRatio) * t;
                return SizedBox(
                  width: 36,
                  height: 2,
                  child: CustomPaint(
                    painter: _AnimatedHpBarPainter(
                      ratio: ratio,
                      color: _hpColor(ratio),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 2),
            Text(
              'ATK ${widget.attack}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: TreeColors.textSecondary,
                    fontSize: 9,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedHpBarPainter extends CustomPainter {
  _AnimatedHpBarPainter({required this.ratio, required this.color});

  final double ratio;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = TreeColors.branchDefault,
    );
    if (ratio > 0) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width * ratio, size.height),
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_AnimatedHpBarPainter oldDelegate) =>
      oldDelegate.ratio != ratio || oldDelegate.color != color;
}
