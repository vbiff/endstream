import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../ui/animations/easing_curves.dart';

/// Toggle switch where a square node slides along a branch track.
class TreeToggle extends StatefulWidget {
  const TreeToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  State<TreeToggle> createState() => _TreeToggleState();
}

class _TreeToggleState extends State<TreeToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: TreeDurations.fast,
    );
    _position = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    if (widget.value) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(TreeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.enabled) {
      widget.onChanged?.call(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: 48,
        height: 24,
        child: AnimatedBuilder(
          animation: _position,
          builder: (context, _) {
            final thumbColor = widget.enabled
                ? (widget.value ? TreeColors.highlight : TreeColors.dormant)
                : TreeColors.dormant.withValues(alpha: 0.5);
            final trackBorder = widget.enabled
                ? TreeColors.branchDefault
                : TreeColors.branchDefault.withValues(alpha: 0.5);

            return CustomPaint(
              painter: _TogglePainter(
                position: _position.value,
                thumbColor: thumbColor,
                trackBorderColor: trackBorder,
                trackFillColor: TreeColors.surface,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TogglePainter extends CustomPainter {
  _TogglePainter({
    required this.position,
    required this.thumbColor,
    required this.trackBorderColor,
    required this.trackFillColor,
  });

  final double position;
  final Color thumbColor;
  final Color trackBorderColor;
  final Color trackFillColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Track
    final trackRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(
      trackRect,
      Paint()..color = trackFillColor,
    );
    canvas.drawRect(
      trackRect,
      Paint()
        ..color = trackBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Thumb — 12x12 square
    const thumbSize = 12.0;
    final padding = (size.height - thumbSize) / 2;
    final maxTravel = size.width - thumbSize - padding * 2;
    final thumbX = padding + (maxTravel * position);
    final thumbY = padding;

    canvas.drawRect(
      Rect.fromLTWH(thumbX, thumbY, thumbSize, thumbSize),
      Paint()..color = thumbColor,
    );
  }

  @override
  bool shouldRepaint(_TogglePainter oldDelegate) =>
      oldDelegate.position != position ||
      oldDelegate.thumbColor != thumbColor;
}
