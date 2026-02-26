import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Compact operator display showing initial, HP bar, and attack value.
class OperatorToken extends StatelessWidget {
  const OperatorToken({
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

  Color _hpColor() {
    if (maxHp == 0) return TreeColors.dormant;
    final ratio = currentHp / maxHp;
    if (ratio > 0.66) return TreeColors.highlight;
    if (ratio > 0.33) return TreeColors.activation;
    return TreeColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? TreeColors.activation
        : (isOwn ? TreeColors.highlight : TreeColors.error);
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return GestureDetector(
      onTap: onTap,
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
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: TreeColors.textPrimary,
                  ),
            ),
          ),
          const SizedBox(height: 2),
          _HpBar(
            current: currentHp,
            max: maxHp,
            color: _hpColor(),
          ),
          const SizedBox(height: 2),
          Text(
            'ATK $attack',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: TreeColors.textSecondary,
                  fontSize: 9,
                ),
          ),
        ],
      ),
    );
  }
}

class _HpBar extends StatelessWidget {
  const _HpBar({
    required this.current,
    required this.max,
    required this.color,
  });

  final int current;
  final int max;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ratio = max > 0 ? (current / max).clamp(0.0, 1.0) : 0.0;
    return SizedBox(
      width: 36,
      height: 2,
      child: CustomPaint(
        painter: _HpBarPainter(ratio: ratio, color: color),
      ),
    );
  }
}

class _HpBarPainter extends CustomPainter {
  _HpBarPainter({required this.ratio, required this.color});

  final double ratio;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = TreeColors.branchDefault,
    );
    // Fill
    if (ratio > 0) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width * ratio, size.height),
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_HpBarPainter oldDelegate) =>
      oldDelegate.ratio != ratio || oldDelegate.color != color;
}
