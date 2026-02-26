import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/games/game_board_bloc.dart';
import '../../../core/cubits/settings/settings_cubit.dart';
import '../../../core/models/client_game_state.dart';
import '../../../core/models/game_card.dart';
import '../../../core/models/operator_instance.dart';
import '../../animations/animation_request.dart';
import '../../animations/board_animation_controller.dart';
import '../../animations/board_animation_overlay.dart';
import '../../animations/position_resolver.dart';
import '../../components/component_enums.dart';
import '../../components/tree_button.dart';
import '../../components/tree_modal.dart';
import '../../overlays/targeting_overlay.dart';
import 'action_error_banner.dart';
import 'animated_game_board_top_bar.dart';
import 'game_board_page_view.dart';

/// Main game board layout — top bar + paged content + optional targeting overlay.
///
/// Supports two usage modes:
/// - **BLoC mode** (default): When callbacks are null, reads `GameBoardBloc` from context.
/// - **Callback mode**: When callbacks are provided, uses them directly (e.g., tutorial).
class GameBoardBody extends StatefulWidget {
  const GameBoardBody({
    super.key,
    required this.gameState,
    required this.selection,
    required this.isMyTurn,
    this.isSubmitting = false,
    this.actionError,
    this.onSelectCard,
    this.onSelectOperator,
    this.onSelectTarget,
    this.onConfirm,
    this.onCancel,
    this.onEndTurn,
    this.onConcede,
  });

  final ClientGameState gameState;
  final SelectionState selection;
  final bool isMyTurn;
  final bool isSubmitting;
  final String? actionError;
  final void Function(GameCard)? onSelectCard;
  final void Function(OperatorInstance)? onSelectOperator;
  final void Function(StreamPosition)? onSelectTarget;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final VoidCallback? onEndTurn;
  final VoidCallback? onConcede;

  @override
  State<GameBoardBody> createState() => _GameBoardBodyState();
}

class _GameBoardBodyState extends State<GameBoardBody> {
  bool _showConcedeConfirm = false;
  late final BoardAnimationController _animController;
  late final PositionResolver _positionResolver;

  /// The state currently rendered by the UI. During animations this lags
  /// behind [widget.gameState] so the user sees the old board while effects
  /// play, then snaps to the new state on completion.
  late ClientGameState _displayedState;
  ClientGameState? _pendingState;

  bool get _usesCallbacks => widget.onSelectCard != null;

  bool get _reduceMotion {
    try {
      return context.read<SettingsCubit>().state.reduceMotion;
    } catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _animController = BoardAnimationController();
    _positionResolver = PositionResolver();
    _displayedState = widget.gameState;
  }

  @override
  void didUpdateWidget(GameBoardBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.gameState != oldWidget.gameState) {
      _onGameStateChanged(oldWidget.gameState, widget.gameState);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _positionResolver.clear();
    super.dispose();
  }

  void _onGameStateChanged(
    ClientGameState oldState,
    ClientGameState newState,
  ) {
    if (_reduceMotion) {
      setState(() => _displayedState = newState);
      return;
    }

    final requests = _diffStates(oldState, newState);
    if (requests.isEmpty) {
      setState(() => _displayedState = newState);
      return;
    }

    // Buffer: keep rendering old state while animations play
    _pendingState = newState;
    _animController.enqueue(
      requests,
      onAllComplete: () {
        if (mounted) {
          setState(() {
            _displayedState = _pendingState ?? newState;
            _pendingState = null;
          });
        }
      },
    );
  }

  /// Diff two game states to detect what animations should play.
  List<AnimationRequest> _diffStates(
    ClientGameState oldState,
    ClientGameState newState,
  ) {
    final requests = <AnimationRequest>[];

    // Build operator maps by instanceId
    final oldOps = <String, OperatorInstance>{};
    final newOps = <String, OperatorInstance>{};

    for (final tp in [...oldState.myStream, ...oldState.opponentStream]) {
      for (final op in tp.operators) {
        final id = op.instanceId ?? op.operatorCardId;
        oldOps[id] = op;
      }
    }
    for (final tp in [...newState.myStream, ...newState.opponentStream]) {
      for (final op in tp.operators) {
        final id = op.instanceId ?? op.operatorCardId;
        newOps[id] = op;
      }
    }

    // Detect combat (HP decreased) and eliminations (operator removed)
    for (final entry in oldOps.entries) {
      final oldOp = entry.value;
      final newOp = newOps[entry.key];

      if (newOp == null) {
        // Operator eliminated — find who might have attacked
        // Default to a generic elimination at old position
        requests.add(CombatAnimationRequest(
          attackerInstanceId: '',
          defenderInstanceId: entry.key,
          attackerPosition: oldOp.position,
          defenderPosition: oldOp.position,
          damage: oldOp.currentHp,
          isElimination: true,
        ));
      } else if (newOp.currentHp < oldOp.currentHp) {
        // HP decreased — combat hit
        requests.add(CombatAnimationRequest(
          attackerInstanceId: '',
          defenderInstanceId: entry.key,
          attackerPosition: newOp.position,
          defenderPosition: newOp.position,
          damage: oldOp.currentHp - newOp.currentHp,
        ));
      }
    }

    // Detect movement (same instance, different position)
    for (final entry in oldOps.entries) {
      final oldOp = entry.value;
      final newOp = newOps[entry.key];
      if (newOp != null && oldOp.position != newOp.position) {
        requests.add(MoveAnimationRequest(
          operatorInstanceId: entry.key,
          fromPosition: oldOp.position,
          toPosition: newOp.position,
        ));
      }
    }

    // Detect card play (hand shrunk)
    if (newState.myHand.length < oldState.myHand.length) {
      final oldCardIds = oldState.myHand.map((c) => c.id).toSet();
      final newCardIds = newState.myHand.map((c) => c.id).toSet();
      final playedIds = oldCardIds.difference(newCardIds);
      for (final cardId in playedIds) {
        // Find where the card might have been deployed — check for new operators
        for (final entry in newOps.entries) {
          if (!oldOps.containsKey(entry.key)) {
            requests.add(CardPlayAnimationRequest(
              cardId: cardId,
              targetPosition: entry.value.position,
            ));
            break;
          }
        }
      }
    }

    return requests;
  }

  void _selectCard(BuildContext context, GameCard card) {
    if (_usesCallbacks) {
      widget.onSelectCard?.call(card);
    } else {
      context.read<GameBoardBloc>().add(SelectCard(card));
    }
  }

  void _selectOperator(BuildContext context, OperatorInstance op) {
    if (_usesCallbacks) {
      widget.onSelectOperator?.call(op);
    } else {
      context.read<GameBoardBloc>().add(SelectOperator(op));
    }
  }

  void _selectTarget(BuildContext context, StreamPosition pos) {
    if (_usesCallbacks) {
      widget.onSelectTarget?.call(pos);
    } else {
      context.read<GameBoardBloc>().add(SelectTarget(pos));
    }
  }

  void _confirm(BuildContext context) {
    if (_usesCallbacks) {
      widget.onConfirm?.call();
    } else {
      context.read<GameBoardBloc>().add(const ConfirmAction());
    }
  }

  void _cancel(BuildContext context) {
    if (_usesCallbacks) {
      widget.onCancel?.call();
    } else {
      context.read<GameBoardBloc>().add(const CancelAction());
    }
  }

  void _endTurn(BuildContext context) {
    if (_usesCallbacks) {
      widget.onEndTurn?.call();
    } else {
      context.read<GameBoardBloc>().add(const EndTurn());
    }
  }

  void _concede(BuildContext context) {
    if (_usesCallbacks) {
      widget.onConcede?.call();
    } else {
      setState(() => _showConcedeConfirm = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canInteract =
        widget.isMyTurn && !widget.isSubmitting && !_animController.isAnimating;
    final state = _displayedState;

    return Column(
      children: [
        AnimatedGameBoardTopBar(
          turnNumber: state.game.currentTurn,
          actionPoints: state.actionPoints,
          maxActionPoints: state.maxActionPoints,
          isMyTurn: widget.isMyTurn,
        ),
        if (widget.actionError != null)
          ActionErrorBanner(message: widget.actionError!),
        Expanded(
          child: Stack(
            children: [
              GameBoardPageView(
                myStream: state.myStream,
                opponentStream: state.opponentStream,
                myHand: state.myHand,
                selection: widget.selection,
                isMyTurn: canInteract,
                actionPoints: state.actionPoints,
                maxActionPoints: state.maxActionPoints,
                myPlayerId: state.myPlayerId,
                positionResolver: _positionResolver,
                onSelectCard: canInteract
                    ? (card) => _selectCard(context, card)
                    : (_) {},
                onSelectOperator: canInteract
                    ? (op) => _selectOperator(context, op)
                    : (_) {},
                onSelectTarget: canInteract
                    ? (pos) => _selectTarget(context, pos)
                    : (_) {},
                onEndTurn: canInteract
                    ? () => _endTurn(context)
                    : () {},
                onConcede: () => _concede(context),
              ),
              BoardAnimationOverlay(
                controller: _animController,
                positionResolver: _positionResolver,
              ),
              if (widget.selection is TargetingState)
                TargetingOverlay(
                  selection: widget.selection as TargetingState,
                  onConfirm: widget.isSubmitting
                      ? () {}
                      : () => _confirm(context),
                  onCancel: () => _cancel(context),
                ),
              if (_showConcedeConfirm)
                _ConcedeConfirmModal(
                  onConfirm: () {
                    setState(() => _showConcedeConfirm = false);
                    if (_usesCallbacks) {
                      widget.onConcede?.call();
                    } else {
                      context.read<GameBoardBloc>().add(const ConcedeGame());
                    }
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
