import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/cubits/games/game_board_bloc.dart';
import 'targeting_action_buttons.dart';

/// Bottom-positioned overlay during targeting — shows source info and confirm/cancel.
class TargetingOverlay extends StatelessWidget {
  const TargetingOverlay({
    super.key,
    required this.selection,
    required this.onConfirm,
    required this.onCancel,
  });

  final TargetingState selection;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  String _sourceLabel() {
    if (selection.sourceCard != null) {
      return 'PLAYING: ${selection.sourceCard!.name.toUpperCase()}';
    }
    if (selection.sourceOperator != null) {
      return 'MOVING: ${selection.sourceOperator!.operatorCardId.toUpperCase()}';
    }
    return 'SELECT TARGET';
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          color: TreeColors.surface,
          border: Border(
            top: BorderSide(color: TreeColors.activation, width: 1),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _sourceLabel(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: TreeColors.activation,
                      letterSpacing: 1.0,
                    ),
              ),
              if (selection.targetPosition != null) ...[
                const SizedBox(height: 4),
                _TargetLabel(
                  stream: selection.targetPosition!.stream,
                  centuryIndex: selection.targetPosition!.centuryIndex,
                ),
              ],
              const SizedBox(height: 12),
              TargetingActionButtons(
                canConfirm: selection.targetPosition != null,
                onConfirm: onConfirm,
                onCancel: onCancel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TargetLabel extends StatelessWidget {
  const _TargetLabel({
    required this.stream,
    required this.centuryIndex,
  });

  final int stream;
  final int centuryIndex;

  @override
  Widget build(BuildContext context) {
    final century = 2100 + (centuryIndex * 100);
    final streamName = stream == 0 ? 'YOUR STREAM' : 'OPPONENT STREAM';

    return Text(
      'TARGET: $streamName — $century',
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: TreeColors.textSecondary,
          ),
    );
  }
}
