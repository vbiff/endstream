import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

class GameService {
  GameService(this._client);
  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  /// Fetch all active games for the current player.
  Future<List<Game>> getActiveGames() async {
    final data = await _client
        .from('games')
        .select()
        .or('player_1_id.eq.$_userId,player_2_id.eq.$_userId')
        .order('last_action_at', ascending: false);
    return (data as List).map((row) => Game.fromJson(row)).toList();
  }

  /// Fetch a single game by ID.
  Future<Game> getGame(String gameId) async {
    final data = await _client
        .from('games')
        .select()
        .eq('id', gameId)
        .single();
    return Game.fromJson(data);
  }

  /// Load full client game state (game + streams + hand).
  Future<ClientGameState> getGameState(String gameId) async {
    final game = await getGame(gameId);

    // Load streams
    final streamsData = await _client
        .from('game_streams')
        .select()
        .eq('game_id', gameId);

    List<Turnpoint> myStream = [];
    List<Turnpoint> opponentStream = [];

    for (final row in streamsData) {
      final streamData = row['stream_data'] as List;
      final turnpoints =
          streamData.map((tp) => Turnpoint.fromJson(tp as Map<String, dynamic>)).toList();
      if (row['player_id'] == _userId) {
        myStream = turnpoints;
      } else {
        opponentStream = turnpoints;
      }
    }

    // Load hand
    final handData = await _client
        .from('game_hands')
        .select()
        .eq('game_id', gameId)
        .eq('player_id', _userId)
        .single();

    final handCardIds = handData['hand_data'] as List;
    List<GameCard> myHand = [];
    if (handCardIds.isNotEmpty) {
      final cardIds = handCardIds.cast<String>();
      final cardsData = await _client
          .from('cards')
          .select('*, abilities(*)')
          .inFilter('id', cardIds);
      myHand = (cardsData as List)
          .map((c) => GameCard.fromJson(c))
          .toList();
    }

    return ClientGameState(
      game: game,
      myStream: myStream,
      opponentStream: opponentStream,
      myHand: myHand,
      myPlayerId: _userId,
    );
  }

  /// Create a new game via Edge Function.
  Future<Game> createGame({
    required OpponentType opponentType,
    required String deckId,
    String? friendId,
  }) async {
    final response = await _client.functions.invoke(
      'create-game',
      body: {
        'player_id': _userId,
        'opponent_type': opponentType.name,
        'deck_id': deckId,
        if (friendId != null) 'friend_id': friendId,
      },
    );
    return Game.fromJson(response.data as Map<String, dynamic>);
  }

  /// Submit a game action via Edge Function.
  Future<ClientGameState> submitAction({
    required String gameId,
    required GameAction action,
  }) async {
    final response = await _client.functions.invoke(
      'submit-action',
      body: {
        'game_id': gameId,
        'action': action.toJson(),
      },
    );
    return ClientGameState.fromJson(response.data as Map<String, dynamic>);
  }

  /// Concede a game via Edge Function.
  Future<void> concedeGame(String gameId) async {
    await _client.functions.invoke(
      'concede-game',
      body: {
        'game_id': gameId,
        'player_id': _userId,
      },
    );
  }

  /// Subscribe to real-time game state changes.
  RealtimeChannel subscribeToGame(
    String gameId, {
    required void Function(Map<String, dynamic> payload) onGameUpdate,
    required void Function(Map<String, dynamic> payload) onActionPerformed,
  }) {
    final channel = _client.channel('game:$gameId');
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'games',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: gameId,
          ),
          callback: (payload) => onGameUpdate(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'game_actions',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'game_id',
            value: gameId,
          ),
          callback: (payload) => onActionPerformed(payload.newRecord),
        )
        .subscribe();
    return channel;
  }

  /// Unsubscribe from a game channel.
  Future<void> unsubscribeFromGame(RealtimeChannel channel) async {
    await _client.removeChannel(channel);
  }
}
