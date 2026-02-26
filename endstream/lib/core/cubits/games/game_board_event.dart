part of 'game_board_bloc.dart';

sealed class GameBoardEvent extends Equatable {
  const GameBoardEvent();

  @override
  List<Object?> get props => [];
}

final class LoadGame extends GameBoardEvent {
  const LoadGame(this.gameId);
  final String gameId;

  @override
  List<Object?> get props => [gameId];
}

final class SelectCard extends GameBoardEvent {
  const SelectCard(this.card);
  final GameCard card;

  @override
  List<Object?> get props => [card.id];
}

final class SelectOperator extends GameBoardEvent {
  const SelectOperator(this.operator);
  final OperatorInstance operator;

  @override
  List<Object?> get props => [operator.operatorCardId];
}

final class SelectTarget extends GameBoardEvent {
  const SelectTarget(this.position);
  final StreamPosition position;

  @override
  List<Object?> get props => [position];
}

final class ConfirmAction extends GameBoardEvent {
  const ConfirmAction();
}

final class CancelAction extends GameBoardEvent {
  const CancelAction();
}

final class EndTurn extends GameBoardEvent {
  const EndTurn();
}

final class ReceiveOpponentAction extends GameBoardEvent {
  const ReceiveOpponentAction(this.action);
  final GameAction action;

  @override
  List<Object?> get props => [action.id];
}

final class GameStateUpdated extends GameBoardEvent {
  const GameStateUpdated(this.payload);
  final Map<String, dynamic> payload;

  @override
  List<Object?> get props => [payload];
}
