import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../services/game_service.dart';

part 'game_list_state.dart';

class GameListCubit extends Cubit<GameListState> {
  GameListCubit(this._gameService) : super(const GameListInitial());

  final GameService _gameService;

  /// Load all games for the current player.
  Future<void> loadGames() async {
    emit(const GameListLoading());
    try {
      final games = await _gameService.getActiveGames();
      emit(GameListLoaded(games));
    } catch (e) {
      emit(GameListError(e.toString()));
    }
  }

  /// Create a new game.
  Future<Game?> createGame({
    required OpponentType opponentType,
    required String deckId,
    String? friendId,
  }) async {
    try {
      final game = await _gameService.createGame(
        opponentType: opponentType,
        deckId: deckId,
        friendId: friendId,
      );
      // Reload the list
      await loadGames();
      return game;
    } catch (e) {
      emit(GameListError(e.toString()));
      return null;
    }
  }

  /// Concede a game.
  Future<void> concedeGame(String gameId) async {
    try {
      await _gameService.concedeGame(gameId);
      await loadGames();
    } catch (e) {
      emit(GameListError(e.toString()));
    }
  }
}
