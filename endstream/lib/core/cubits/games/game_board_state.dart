part of 'game_board_bloc.dart';

// ── Board States ──

sealed class GameBoardState extends Equatable {
  const GameBoardState();

  @override
  List<Object?> get props => [];
}

final class GameBoardInitial extends GameBoardState {
  const GameBoardInitial();
}

final class GameBoardLoading extends GameBoardState {
  const GameBoardLoading();
}

final class GameBoardLoaded extends GameBoardState {
  const GameBoardLoaded({
    required this.gameState,
    required this.selection,
    this.lastOpponentAction,
    this.isSubmitting = false,
    this.actionError,
  });

  final ClientGameState gameState;
  final SelectionState selection;
  final GameAction? lastOpponentAction;
  final bool isSubmitting;
  final String? actionError;

  bool get isMyTurn =>
      gameState.game.activePlayerId == gameState.myPlayerId;

  GameBoardLoaded copyWith({
    ClientGameState? gameState,
    SelectionState? selection,
    GameAction? lastOpponentAction,
    bool? isSubmitting,
    String? actionError,
    bool clearActionError = false,
  }) =>
      GameBoardLoaded(
        gameState: gameState ?? this.gameState,
        selection: selection ?? this.selection,
        lastOpponentAction: lastOpponentAction ?? this.lastOpponentAction,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        actionError: clearActionError ? null : (actionError ?? this.actionError),
      );

  @override
  List<Object?> get props =>
      [gameState, selection, lastOpponentAction, isSubmitting, actionError];
}

final class GameBoardError extends GameBoardState {
  const GameBoardError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

final class GameBoardGameOver extends GameBoardState {
  const GameBoardGameOver({
    required this.gameState,
    required this.winnerId,
  });

  final ClientGameState gameState;
  final String? winnerId;

  @override
  List<Object?> get props => [gameState, winnerId];
}

// ── Selection States (substates during ACTION_PHASE) ──

sealed class SelectionState extends Equatable {
  const SelectionState();

  static const SelectionState none = NoneSelected();

  static SelectionState cardSelected(GameCard card) =>
      CardSelectedState(card);

  static SelectionState operatorSelected(OperatorInstance operator) =>
      OperatorSelectedState(operator);

  static SelectionState targeting({
    GameCard? sourceCard,
    OperatorInstance? sourceOperator,
    StreamPosition? targetPosition,
  }) =>
      TargetingState(
        sourceCard: sourceCard,
        sourceOperator: sourceOperator,
        targetPosition: targetPosition,
      );

  @override
  List<Object?> get props => [];
}

final class NoneSelected extends SelectionState {
  const NoneSelected();
}

final class CardSelectedState extends SelectionState {
  const CardSelectedState(this.card);
  final GameCard card;

  @override
  List<Object?> get props => [card.id];
}

final class OperatorSelectedState extends SelectionState {
  const OperatorSelectedState(this.operator);
  final OperatorInstance operator;

  @override
  List<Object?> get props => [operator.instanceId ?? operator.operatorCardId];
}

final class TargetingState extends SelectionState {
  const TargetingState({
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
