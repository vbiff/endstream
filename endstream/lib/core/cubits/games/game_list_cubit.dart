import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show RealtimeChannel;

import '../../models/models.dart';
import '../../services/game_service.dart';

part 'game_list_state.dart';

class GameListCubit extends Cubit<GameListState> {
  GameListCubit(this._gameService) : super(const GameListInitial());

  final GameService _gameService;
  RealtimeChannel? _gamesChannel;

  /// Load all games for the current player.
  Future<void> loadGames() async {
    emit(const GameListLoading());
    try {
      final games = await _gameService.getActiveGames();
      emit(GameListLoaded(games, currentUserId: _gameService.userId));
      _subscribeToGamesRealtime();
    } catch (e) {
      emit(GameListError(e.toString()));
    }
  }

  void _subscribeToGamesRealtime() {
    _gamesChannel?.unsubscribe();
    _gamesChannel = _gameService.subscribeToGamesList(
      onGameUpdated: _handleGameUpdated,
      onGameInserted: _handleGameInserted,
    );
  }

  void _handleGameUpdated(Game game) {
    if (isClosed) return;
    final current = state;
    if (current is! GameListLoaded) return;

    final updatedGames = current.games.map((g) {
      return g.id == game.id ? game : g;
    }).toList();
    emit(GameListLoaded(updatedGames, currentUserId: current.currentUserId));
  }

  void _handleGameInserted(Game game) {
    if (isClosed) return;
    final current = state;
    if (current is! GameListLoaded) return;

    if (current.games.any((g) => g.id == game.id)) return;
    emit(GameListLoaded(
      [game, ...current.games],
      currentUserId: current.currentUserId,
    ));
  }

  /// Create a new game. Returns the Game from the created ClientGameState.
  Future<Game?> createGame({
    required OpponentType opponentType,
    required String deckId,
    String? friendId,
  }) async {
    try {
      final gameState = await _gameService.createGame(
        opponentType: opponentType,
        deckId: deckId,
        friendId: friendId,
      );
      await loadGames();
      return gameState.game;
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

  @override
  Future<void> close() async {
    if (_gamesChannel != null) {
      await _gameService.unsubscribeFromGamesList(_gamesChannel!);
    }
    return super.close();
  }
}
