part of 'game_list_cubit.dart';

sealed class GameListState extends Equatable {
  const GameListState();

  @override
  List<Object?> get props => [];
}

final class GameListInitial extends GameListState {
  const GameListInitial();
}

final class GameListLoading extends GameListState {
  const GameListLoading();
}

final class GameListLoaded extends GameListState {
  const GameListLoaded(this.games, {this.currentUserId});
  final List<Game> games;
  final String? currentUserId;

  List<Game> get yourTurn =>
      games.where((g) => g.status == GameStatus.active && g.activePlayerId == currentUserId).toList();

  List<Game> get waiting =>
      games.where((g) => g.status == GameStatus.active && g.activePlayerId != currentUserId).toList();

  List<Game> get completed =>
      games.where((g) => g.status != GameStatus.active).toList();

  @override
  List<Object?> get props => [games, currentUserId];
}

final class GameListError extends GameListState {
  const GameListError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
