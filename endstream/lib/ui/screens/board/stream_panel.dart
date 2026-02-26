import 'package:flutter/material.dart';

import '../../../core/cubits/games/game_board_bloc.dart';
import '../../../core/models/operator_instance.dart';
import '../../../core/models/turnpoint.dart';
import 'stream_panel_header.dart';
import 'stream_turnpoint_list.dart';

/// Full stream panel — header + scrollable turnpoint list.
class StreamPanel extends StatelessWidget {
  const StreamPanel({
    super.key,
    required this.label,
    required this.turnpoints,
    required this.isOpponent,
    required this.selection,
    required this.isMyTurn,
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
  final String? selectedOperatorId;
  final void Function(OperatorInstance)? onOperatorTap;
  final void Function(int centuryIndex)? onCellTap;
  final bool Function(int centuryIndex)? isCellValidTarget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamPanelHeader(
          label: label,
          isOpponent: isOpponent,
        ),
        Expanded(
          child: StreamTurnpointList(
            turnpoints: turnpoints,
            isOpponent: isOpponent,
            selectedOperatorId: selectedOperatorId,
            onOperatorTap: onOperatorTap,
            onCellTap: onCellTap,
            isCellValidTarget: isCellValidTarget,
          ),
        ),
      ],
    );
  }
}
