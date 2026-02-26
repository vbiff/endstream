import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

/// Abstract interface for game operations.
abstract class GameService {
  /// Current user ID.
  String get userId;

  /// Fetch all active games for the current player.
  Future<List<Game>> getActiveGames();

  /// Fetch a single game by ID.
  Future<Game> getGame(String gameId);

  /// Load full client game state (game + streams + hand + controllers + AP).
  Future<ClientGameState> getGameState(String gameId);

  /// Create a new game via Edge Function.
  Future<ClientGameState> createGame({
    required OpponentType opponentType,
    required String deckId,
    String? friendId,
  });

  /// Submit a game action via Edge Function.
  Future<ClientGameState> submitAction({
    required String gameId,
    required GameAction action,
  });

  /// Concede a game via Edge Function.
  Future<void> concedeGame(String gameId);

  /// Subscribe to real-time game state changes.
  RealtimeChannel subscribeToGame(
    String gameId, {
    required void Function(Map<String, dynamic> payload) onGameUpdate,
    required void Function(Map<String, dynamic> payload) onActionPerformed,
  });

  /// Unsubscribe from a game channel.
  Future<void> unsubscribeFromGame(RealtimeChannel channel);

  /// Subscribe to real-time updates on the games list.
  RealtimeChannel subscribeToGamesList({
    required void Function(Game game) onGameUpdated,
    required void Function(Game game) onGameInserted,
  });

  /// Unsubscribe from the games list channel.
  Future<void> unsubscribeFromGamesList(RealtimeChannel channel);

  /// Join matchmaking queue via Edge Function.
  Future<Map<String, dynamic>> joinMatchmaking({required String deckId});

  /// Leave the matchmaking queue.
  Future<void> leaveMatchmaking();

  /// Subscribe to new game inserts (for matchmaking wait).
  RealtimeChannel subscribeToNewGame({
    required void Function(Game game) onGameCreated,
  });
}
