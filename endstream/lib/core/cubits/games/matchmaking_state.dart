part of 'matchmaking_cubit.dart';

sealed class MatchmakingState extends Equatable {
  const MatchmakingState();

  @override
  List<Object?> get props => [];
}

final class MatchmakingInitial extends MatchmakingState {
  const MatchmakingInitial();
}

final class MatchmakingSearching extends MatchmakingState {
  const MatchmakingSearching(this.elapsedSeconds);
  final int elapsedSeconds;

  @override
  List<Object?> get props => [elapsedSeconds];
}

final class MatchmakingMatched extends MatchmakingState {
  const MatchmakingMatched(this.gameId);
  final String gameId;

  @override
  List<Object?> get props => [gameId];
}

final class MatchmakingCancelled extends MatchmakingState {
  const MatchmakingCancelled();
}

final class MatchmakingTimeout extends MatchmakingState {
  const MatchmakingTimeout();
}

final class MatchmakingError extends MatchmakingState {
  const MatchmakingError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
