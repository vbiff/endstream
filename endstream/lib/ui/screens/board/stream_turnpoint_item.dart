import 'package:flutter/material.dart';

import '../../../core/models/operator_instance.dart';
import '../../../core/models/turnpoint.dart';
import '../../components/turnpoint_cell.dart';
import '../../overlays/targeting_highlight_border.dart';

/// Single turnpoint row in a stream list — wraps TurnpointCell with targeting highlight.
class StreamTurnpointItem extends StatelessWidget {
  const StreamTurnpointItem({
    super.key,
    required this.turnpoint,
    required this.centuryIndex,
    required this.isOpponent,
    required this.isValidTarget,
    this.selectedOperatorId,
    this.onOperatorTap,
    this.onCellTap,
  });

  final Turnpoint turnpoint;
  final int centuryIndex;
  final bool isOpponent;
  final bool isValidTarget;
  final String? selectedOperatorId;
  final void Function(OperatorInstance)? onOperatorTap;
  final VoidCallback? onCellTap;

  @override
  Widget build(BuildContext context) {
    final cell = TurnpointCell(
      century: turnpoint.century,
      terrainType: turnpoint.terrainType,
      operators: turnpoint.operators,
      effects: turnpoint.activeEffects,
      isValidTarget: isValidTarget,
      onTap: isValidTarget ? onCellTap : null,
      onOperatorTap: onOperatorTap,
      isOpponent: isOpponent,
      selectedOperatorId: selectedOperatorId,
    );

    if (isValidTarget) {
      return TargetingHighlightBorder(child: cell);
    }

    return cell;
  }
}
