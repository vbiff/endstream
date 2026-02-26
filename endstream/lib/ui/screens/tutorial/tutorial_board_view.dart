import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/games/game_board_bloc.dart';
import '../../../core/cubits/tutorial/tutorial_bloc.dart';
import '../board/game_board_body.dart';
import 'tutorial_hint_overlay.dart';

/// Renders the game board with tutorial callbacks and hint overlay.
class TutorialBoardView extends StatelessWidget {
  const TutorialBoardView({
    super.key,
    required this.state,
  });

  final TutorialInProgress state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameBoardBody(
          gameState: state.gameState,
          selection: _mapSelection(state.selection),
          isMyTurn: state.isMyTurn,
          onSelectCard: (card) =>
              context.read<TutorialBloc>().add(TutorialSelectCard(card)),
          onSelectOperator: (op) =>
              context.read<TutorialBloc>().add(TutorialSelectOperator(op)),
          onSelectTarget: (pos) =>
              context.read<TutorialBloc>().add(TutorialSelectTarget(pos)),
          onConfirm: () =>
              context.read<TutorialBloc>().add(const TutorialConfirmAction()),
          onCancel: () =>
              context.read<TutorialBloc>().add(const TutorialCancelAction()),
          onEndTurn: () =>
              context.read<TutorialBloc>().add(const TutorialEndTurn()),
          onConcede: () {},
        ),
        if (state.isAiThinking) const _AiThinkingOverlay(),
        TutorialHintOverlay(
          hint: state.hint,
          onSkip: () =>
              context.read<TutorialBloc>().add(const SkipTutorial()),
        ),
      ],
    );
  }

  /// Maps tutorial selection to the game board's SelectionState.
  SelectionState _mapSelection(TutorialSelection sel) {
    return switch (sel) {
      TutorialNoneSelected() => const NoneSelected(),
      TutorialCardSelected(:final card) => CardSelectedState(card),
      TutorialOperatorSelected(:final operator) =>
        OperatorSelectedState(operator),
      TutorialTargeting(
        :final sourceCard,
        :final sourceOperator,
        :final targetPosition,
      ) =>
        TargetingState(
          sourceCard: sourceCard,
          sourceOperator: sourceOperator,
          targetPosition: targetPosition,
        ),
    };
  }
}

class _AiThinkingOverlay extends StatelessWidget {
  const _AiThinkingOverlay();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0x80000000),
      child: Center(
        child: Text(
          'AI IS THINKING...',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: TreeColors.textSecondary,
              ),
        ),
      ),
    );
  }
}
