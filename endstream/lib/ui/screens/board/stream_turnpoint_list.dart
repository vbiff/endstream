import 'package:flutter/material.dart';

import '../../../core/models/operator_instance.dart';
import '../../../core/models/turnpoint.dart';
import 'stream_turnpoint_item.dart';

/// Scrollable list of 6 turnpoints for a single stream.
class StreamTurnpointList extends StatelessWidget {
  const StreamTurnpointList({
    super.key,
    required this.turnpoints,
    required this.isOpponent,
    this.selectedOperatorId,
    this.onOperatorTap,
    this.onCellTap,
    this.isCellValidTarget,
  });

  final List<Turnpoint> turnpoints;
  final bool isOpponent;
  final String? selectedOperatorId;
  final void Function(OperatorInstance)? onOperatorTap;
  final void Function(int centuryIndex)? onCellTap;
  final bool Function(int centuryIndex)? isCellValidTarget;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: turnpoints.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final turnpoint = turnpoints[index];
        final isValid = isCellValidTarget?.call(index) ?? false;

        return StreamTurnpointItem(
          turnpoint: turnpoint,
          centuryIndex: index,
          isOpponent: isOpponent,
          isValidTarget: isValid,
          selectedOperatorId: selectedOperatorId,
          onOperatorTap: onOperatorTap,
          onCellTap: isValid ? () => onCellTap?.call(index) : null,
        );
      },
    );
  }
}
