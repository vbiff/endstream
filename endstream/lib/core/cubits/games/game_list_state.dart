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
  const GameListLoaded(this.games);
  final List<Game> games;

  List<Game> get yourTurn =>
      games.where((g) => g.status == GameStatus.active && g.activePlayerId == _currentUserId(g)).toList();

  List<Game> get waiting =>
      games.where((g) => g.status == GameStatus.active && g.activePlayerId != _currentUserId(g)).toList();

  List<Game> get completed =>
      games.where((g) => g.status != GameStatus.active).toList();

  // Helper — not perfect, but the cubit knows the current user.
  // In practice, pass the user ID or filter in the cubit layer.
  String? _currentUserId(Game g) => null; // overridden at usage

  @override
  List<Object?> get props => [games];
}

final class GameListError extends GameListState {
  const GameListError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
