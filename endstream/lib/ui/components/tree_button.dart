import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme.dart';
import '../../ui/animations/easing_curves.dart';
import '../background/time_tree_scope.dart';
import 'component_enums.dart';

/// Angular button with press-state color transition. No ripple effect.
class TreeButton extends StatefulWidget {
  const TreeButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = TreeButtonVariant.primary,
    this.enabled = true,
  });

  final VoidCallback? onPressed;
  final String label;
  final TreeButtonVariant variant;
  final bool enabled;

  @override
  State<TreeButton> createState() => _TreeButtonState();
}

class _TreeButtonState extends State<TreeButton> {
  bool _pressed = false;

  void _handleTapDown(TapDownDetails _) {
    if (widget.enabled) setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _pressed = false);
  }

  void _handleTapCancel() {
    setState(() => _pressed = false);
  }

  void _handleTap() {
    if (!widget.enabled) return;
    HapticFeedback.lightImpact();
    widget.onPressed?.call();
    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final center = box.localToGlobal(box.size.center(Offset.zero));
      TimeTreeScope.maybeOf(context)?.emitRipple(center, 0.1);
    }
  }

  Color _borderColor() {
    if (!widget.enabled) return TreeColors.dormant;
    if (_pressed) return TreeColors.activation;
    switch (widget.variant) {
      case TreeButtonVariant.primary:
        return TreeColors.branchDefault;
      case TreeButtonVariant.secondary:
        return TreeColors.highlight;
      case TreeButtonVariant.danger:
        return TreeColors.error;
    }
  }

  Color _fillColor() {
    if (!widget.enabled) return TreeColors.surface;
    if (_pressed) {
      switch (widget.variant) {
        case TreeButtonVariant.primary:
          return TreeColors.branchActive;
        case TreeButtonVariant.secondary:
          return TreeColors.surface;
        case TreeButtonVariant.danger:
          return TreeColors.surface;
      }
    }
    return TreeColors.surface;
  }

  Color _textColor() {
    if (!widget.enabled) return TreeColors.dormant;
    return TreeColors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      enabled: widget.enabled,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: TreeDurations.instant,
          curve: TreeCurves.standard,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _fillColor(),
            border: Border.all(color: _borderColor(), width: 1),
          ),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: _textColor()),
          ),
        ),
      ),
    );
  }
}
