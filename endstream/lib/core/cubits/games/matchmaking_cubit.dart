import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show RealtimeChannel;

import '../../services/game_service.dart';

part 'matchmaking_state.dart';

class MatchmakingCubit extends Cubit<MatchmakingState> {
  MatchmakingCubit(this._gameService) : super(const MatchmakingInitial());

  final GameService _gameService;
  Timer? _elapsedTimer;
  Timer? _timeoutTimer;
  RealtimeChannel? _gameChannel;
  String? _deckId;
  int _elapsed = 0;

  static const _timeoutDuration = Duration(seconds: 120);

  /// Start searching for an opponent.
  Future<void> startSearching({required String deckId}) async {
    _deckId = deckId;
    _elapsed = 0;
    emit(const MatchmakingSearching(0));

    // Start elapsed counter
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;
      _elapsed++;
      if (state is MatchmakingSearching) {
        emit(MatchmakingSearching(_elapsed));
      }
    });

    // Start timeout timer
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(_timeoutDuration, () {
      if (isClosed) return;
      if (state is MatchmakingSearching) {
        _cleanup();
        _gameService.leaveMatchmaking();
        emit(const MatchmakingTimeout());
      }
    });

    // Subscribe to game inserts BEFORE calling Edge Function
    _gameChannel?.unsubscribe();
    _gameChannel = _gameService.subscribeToNewGame(
      onGameCreated: (game) {
        if (isClosed) return;
        if (state is MatchmakingSearching) {
          _cleanup();
          emit(MatchmakingMatched(game.id));
        }
      },
    );

    // Call matchmaking Edge Function
    try {
      final result = await _gameService.joinMatchmaking(deckId: deckId);
      final status = result['status'] as String?;

      if (status == 'matched') {
        // Matched immediately — extract game id
        final gameData = result['game'] as Map<String, dynamic>?;
        final gameId = gameData?['game']?['id'] as String? ??
            gameData?['id'] as String?;
        if (gameId != null) {
          _cleanup();
          emit(MatchmakingMatched(gameId));
        }
      }
      // If "queued", wait for Realtime subscription to fire
    } catch (e) {
      _cleanup();
      emit(MatchmakingError(e.toString()));
    }
  }

  /// Cancel the matchmaking search.
  Future<void> cancelSearch() async {
    _cleanup();
    try {
      await _gameService.leaveMatchmaking();
    } catch (_) {}
    emit(const MatchmakingCancelled());
  }

  /// Retry the search with the same deck.
  Future<void> retrySearch() async {
    if (_deckId != null) {
      await startSearching(deckId: _deckId!);
    }
  }

  void _cleanup() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
    if (_gameChannel != null) {
      _gameService.unsubscribeFromGamesList(_gameChannel!);
      _gameChannel = null;
    }
  }

  @override
  Future<void> close() {
    _cleanup();
    return super.close();
  }
}
