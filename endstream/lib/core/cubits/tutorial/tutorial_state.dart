part of 'tutorial_bloc.dart';

// ── Tutorial States ──

sealed class TutorialState extends Equatable {
  const TutorialState();

  @override
  List<Object?> get props => [];
}

final class TutorialInitial extends TutorialState {
  const TutorialInitial();
}

final class TutorialInProgress extends TutorialState {
  const TutorialInProgress({
    required this.stepIndex,
    required this.gameState,
    required this.selection,
    required this.hint,
    required this.isMyTurn,
    required this.isAiThinking,
  });

  final int stepIndex;
  final ClientGameState gameState;
  final TutorialSelection selection;
  final TutorialHint hint;
  final bool isMyTurn;
  final bool isAiThinking;

  TutorialInProgress copyWith({
    int? stepIndex,
    ClientGameState? gameState,
    TutorialSelection? selection,
    TutorialHint? hint,
    bool? isMyTurn,
    bool? isAiThinking,
  }) =>
      TutorialInProgress(
        stepIndex: stepIndex ?? this.stepIndex,
        gameState: gameState ?? this.gameState,
        selection: selection ?? this.selection,
        hint: hint ?? this.hint,
        isMyTurn: isMyTurn ?? this.isMyTurn,
        isAiThinking: isAiThinking ?? this.isAiThinking,
      );

  @override
  List<Object?> get props => [
        stepIndex,
        gameState,
        selection,
        hint.title,
        isMyTurn,
        isAiThinking,
      ];
}

final class TutorialComplete extends TutorialState {
  const TutorialComplete();
}

// ── Tutorial Selection States (mirror of game board SelectionState) ──

sealed class TutorialSelection extends Equatable {
  const TutorialSelection();

  @override
  List<Object?> get props => [];
}

final class TutorialNoneSelected extends TutorialSelection {
  const TutorialNoneSelected();
}

final class TutorialCardSelected extends TutorialSelection {
  const TutorialCardSelected(this.card);
  final GameCard card;

  @override
  List<Object?> get props => [card.id];
}

final class TutorialOperatorSelected extends TutorialSelection {
  const TutorialOperatorSelected(this.operator);
  final OperatorInstance operator;

  @override
  List<Object?> get props => [operator.instanceId];
}

final class TutorialTargeting extends TutorialSelection {
  const TutorialTargeting({
    this.sourceCard,
    this.sourceOperator,
    this.targetPosition,
  });

  final GameCard? sourceCard;
  final OperatorInstance? sourceOperator;
  final StreamPosition? targetPosition;

  @override
  List<Object?> get props => [sourceCard, sourceOperator, targetPosition];
}
