import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/games/game_board_bloc.dart';
import '../../../core/models/client_game_state.dart';
import '../../components/component_enums.dart';
import '../../components/tree_button.dart';
import '../../components/tree_modal.dart';
import '../../overlays/targeting_overlay.dart';
import 'game_board_page_view.dart';
import 'game_board_top_bar.dart';

/// Main game board layout — top bar + paged content + optional targeting overlay.
class GameBoardBody extends StatefulWidget {
  const GameBoardBody({
    super.key,
    required this.gameState,
    required this.selection,
    required this.isMyTurn,
  });

  final ClientGameState gameState;
  final SelectionState selection;
  final bool isMyTurn;

  @override
  State<GameBoardBody> createState() => _GameBoardBodyState();
}

class _GameBoardBodyState extends State<GameBoardBody> {
  bool _showConcedeConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GameBoardTopBar(
          turnNumber: widget.gameState.game.currentTurn,
          actionPoints: widget.gameState.actionPoints,
          maxActionPoints: widget.gameState.maxActionPoints,
          isMyTurn: widget.isMyTurn,
        ),
        Expanded(
          child: Stack(
            children: [
              GameBoardPageView(
                myStream: widget.gameState.myStream,
                opponentStream: widget.gameState.opponentStream,
                myHand: widget.gameState.myHand,
                selection: widget.selection,
                isMyTurn: widget.isMyTurn,
                actionPoints: widget.gameState.actionPoints,
                maxActionPoints: widget.gameState.maxActionPoints,
                myPlayerId: widget.gameState.myPlayerId,
                onSelectCard: (card) =>
                    context.read<GameBoardBloc>().add(SelectCard(card)),
                onSelectOperator: (op) =>
                    context.read<GameBoardBloc>().add(SelectOperator(op)),
                onSelectTarget: (pos) =>
                    context.read<GameBoardBloc>().add(SelectTarget(pos)),
                onEndTurn: () =>
                    context.read<GameBoardBloc>().add(const EndTurn()),
                onConcede: () =>
                    setState(() => _showConcedeConfirm = true),
              ),
              if (widget.selection is TargetingState)
                TargetingOverlay(
                  selection: widget.selection as TargetingState,
                  onConfirm: () => context
                      .read<GameBoardBloc>()
                      .add(const ConfirmAction()),
                  onCancel: () => context
                      .read<GameBoardBloc>()
                      .add(const CancelAction()),
                ),
              if (_showConcedeConfirm)
                _ConcedeConfirmModal(
                  onConfirm: () {
                    setState(() => _showConcedeConfirm = false);
                    Navigator.of(context).pop();
                  },
                  onCancel: () =>
                      setState(() => _showConcedeConfirm = false),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Concede confirmation dialog using TreeModal.
class _ConcedeConfirmModal extends StatelessWidget {
  const _ConcedeConfirmModal({
    required this.onConfirm,
    required this.onCancel,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return TreeModal(
      onClose: onCancel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CONCEDE GAME',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: TreeColors.error,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'This action cannot be undone. The timeline will collapse.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: TreeColors.textSecondary,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TreeButton(
                  onPressed: onConfirm,
                  label: 'CONCEDE',
                  variant: TreeButtonVariant.danger,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TreeButton(
                  onPressed: onCancel,
                  label: 'CANCEL',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
