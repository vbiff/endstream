import 'package:flutter/material.dart';

import '../../../core/cubits/games/game_board_bloc.dart';
import '../../../core/models/operator_instance.dart';
import '../../../core/models/turnpoint.dart';
import '../../animations/easing_curves.dart';
import 'stream_panel.dart';

/// Wraps [StreamPanel] with dim/brighten animation on turn changes.
///
/// When [isMyTurn] transitions, the panel opacity animates from 0.5↔1.0
/// with staggered propagation (opponent panel dims when it's your turn,
/// brightens when it's their turn).
class AnimatedStreamPanel extends StatefulWidget {
  const AnimatedStreamPanel({
    super.key,
    required this.label,
    required this.turnpoints,
    required this.isOpponent,
    required this.selection,
    required this.isMyTurn,
    required this.isActivePanel,
    this.selectedOperatorId,
    this.onOperatorTap,
    this.onCellTap,
    this.isCellValidTarget,
  });

  final String label;
  final List<Turnpoint> turnpoints;
  final bool isOpponent;
  final SelectionState selection;
  final bool isMyTurn;

  /// Whether this panel belongs to the active player (should be bright).
  final bool isActivePanel;
  final String? selectedOperatorId;
  final void Function(OperatorInstance)? onOperatorTap;
  final void Function(int centuryIndex)? onCellTap;
  final bool Function(int centuryIndex)? isCellValidTarget;

  @override
  State<AnimatedStreamPanel> createState() => _AnimatedStreamPanelState();
}

class _AnimatedStreamPanelState extends State<AnimatedStreamPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: TreeCurves.standard),
    );
    // Start at correct value
    if (widget.isActivePanel) {
      _controller.value = 1.0;
    } else {
      _controller.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedStreamPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActivePanel != oldWidget.isActivePanel) {
      if (widget.isActivePanel) {
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: child,
        );
      },
      child: StreamPanel(
        label: widget.label,
        turnpoints: widget.turnpoints,
        isOpponent: widget.isOpponent,
        selection: widget.selection,
        isMyTurn: widget.isMyTurn,
        selectedOperatorId: widget.selectedOperatorId,
        onOperatorTap: widget.onOperatorTap,
        onCellTap: widget.onCellTap,
        isCellValidTarget: widget.isCellValidTarget,
      ),
    );
  }
}
