import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/models.dart';
import '../game_service.dart';

class SupabaseGameService implements GameService {
  SupabaseGameService(this._client);
  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  String get userId => _userId;

  @override
  Future<List<Game>> getActiveGames() async {
    final data = await _client
        .from('games')
        .select()
        .or('player_1_id.eq.$_userId,player_2_id.eq.$_userId')
        .order('last_action_at', ascending: false);
    return (data as List).map((row) => Game.fromJson(row)).toList();
  }

  @override
  Future<Game> getGame(String gameId) async {
    final data = await _client
        .from('games')
        .select()
        .eq('id', gameId)
        .single();
    return Game.fromJson(data);
  }

  @override
  Future<ClientGameState> getGameState(String gameId) async {
    final gameFuture = getGame(gameId);
    final streamsFuture =
        _client.from('game_streams').select().eq('game_id', gameId);
    final handFuture = _client
        .from('game_hands')
        .select()
        .eq('game_id', gameId)
        .eq('player_id', _userId)
        .single();
    final controllersFuture =
        _client.from('game_controllers').select().eq('game_id', gameId);
    final playerStateFuture = _client
        .from('game_player_state')
        .select()
        .eq('game_id', gameId)
        .eq('player_id', _userId)
        .maybeSingle();

    final game = await gameFuture;
    final streamsData = await streamsFuture;
    final handData = await handFuture;
    final controllersData = await controllersFuture;
    final playerStateData = await playerStateFuture;

    List<Turnpoint> myStream = [];
    List<Turnpoint> opponentStream = [];
    for (final row in streamsData) {
      final streamData = row['stream_data'] as List;
      final turnpoints = streamData
          .map((tp) => Turnpoint.fromJson(tp as Map<String, dynamic>))
          .toList();
      if (row['player_id'] == _userId) {
        myStream = turnpoints;
      } else {
        opponentStream = turnpoints;
      }
    }

    final handCardIds = handData['hand_data'] as List;
    List<GameCard> myHand = [];
    if (handCardIds.isNotEmpty) {
      final cardIds = handCardIds.cast<String>();
      final cardsData = await _client
          .from('cards')
          .select('*, abilities(*)')
          .inFilter('id', cardIds);
      myHand =
          (cardsData as List).map((c) => GameCard.fromJson(c)).toList();
    }

    final opponentHandData = await _client
        .from('game_hands')
        .select('hand_data')
        .eq('game_id', gameId)
        .neq('player_id', _userId)
        .maybeSingle();
    final opponentHandSize =
        (opponentHandData?['hand_data'] as List?)?.length ?? 0;

    int myControllerHp = 10;
    int opponentControllerHp = 10;
    String opponentPlayerId = '';
    for (final row in controllersData) {
      if (row['player_id'] == _userId) {
        myControllerHp = row['hp'] as int;
      } else {
        opponentControllerHp = row['hp'] as int;
        opponentPlayerId = row['player_id'] as String;
      }
    }

    final actionPoints =
        playerStateData?['action_points'] as int? ?? 3;
    final maxActionPoints =
        playerStateData?['max_action_points'] as int? ?? 3;

    return ClientGameState(
      game: game,
      myStream: myStream,
      opponentStream: opponentStream,
      myHand: myHand,
      myPlayerId: _userId,
      actionPoints: actionPoints,
      maxActionPoints: maxActionPoints,
      handSize: myHand.length,
      opponentHandSize: opponentHandSize,
      myControllerHp: myControllerHp,
      opponentControllerHp: opponentControllerHp,
      opponentPlayerId: opponentPlayerId,
    );
  }

  @override
  Future<ClientGameState> createGame({
    required OpponentType opponentType,
    required String deckId,
    String? friendId,
  }) async {
    final response = await _client.functions.invoke(
      'create-game',
      body: {
        'opponent_type': opponentType.name,
        'deck_id': deckId,
        if (friendId != null) 'friend_id': friendId,
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw StateError('Invalid response from create-game');
    }
    return ClientGameState.fromJson(data);
  }

  @override
  Future<ClientGameState> submitAction({
    required String gameId,
    required GameAction action,
  }) async {
    final serverAction = <String, dynamic>{
      'type': action.type.value,
    };
    if (action.source != null) {
      serverAction['sourceId'] = action.source!.id;
    }
    if (action.target != null) {
      final target = <String, dynamic>{};
      if (action.target!.position != null) {
        target['position'] = action.target!.position;
      }
      if (action.target!.id.isNotEmpty) {
        if (action.target!.type == 'operator') {
          target['operatorInstanceId'] = action.target!.id;
        } else if (action.target!.type == 'ability') {
          target['abilityId'] = action.target!.id;
        }
      }
      if (target.isNotEmpty) serverAction['target'] = target;
    }
    final response = await _client.functions.invoke(
      'submit-action',
      body: {
        'game_id': gameId,
        'action': serverAction,
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw StateError('Invalid response from submit-action');
    }
    return ClientGameState.fromJson(data);
  }

  @override
  Future<void> concedeGame(String gameId) async {
    final response = await _client.functions.invoke(
      'concede-game',
      body: {
        'game_id': gameId,
        'player_id': _userId,
      },
    );
    final data = response.data;
    if (data is Map<String, dynamic> && data['error'] != null) {
      throw StateError(data['error'].toString());
    }
  }

  @override
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

  @override
  Future<void> unsubscribeFromGame(RealtimeChannel channel) async {
    await _client.removeChannel(channel);
  }

  @override
  RealtimeChannel subscribeToGamesList({
    required void Function(Game game) onGameUpdated,
    required void Function(Game game) onGameInserted,
  }) {
    final channel = _client.channel('games-list:$_userId');
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'games',
          callback: (payload) {
            try {
              final game = Game.fromJson(payload.newRecord);
              if (game.player1Id == _userId || game.player2Id == _userId) {
                onGameUpdated(game);
              }
            } catch (_) {}
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'games',
          callback: (payload) {
            try {
              final game = Game.fromJson(payload.newRecord);
              if (game.player1Id == _userId || game.player2Id == _userId) {
                onGameInserted(game);
              }
            } catch (_) {}
          },
        )
        .subscribe();
    return channel;
  }

  @override
  Future<void> unsubscribeFromGamesList(RealtimeChannel channel) async {
    await _client.removeChannel(channel);
  }

  @override
  Future<Map<String, dynamic>> joinMatchmaking({
    required String deckId,
  }) async {
    final response = await _client.functions.invoke(
      'matchmaking',
      body: {
        'deck_id': deckId,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<void> leaveMatchmaking() async {
    await _client
        .from('matchmaking_queue')
        .delete()
        .eq('player_id', _userId);
  }

  @override
  RealtimeChannel subscribeToNewGame({
    required void Function(Game game) onGameCreated,
  }) {
    final channel = _client.channel('matchmaking-game:$_userId');
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'games',
          callback: (payload) {
            try {
              final game = Game.fromJson(payload.newRecord);
              if (game.player1Id == _userId || game.player2Id == _userId) {
                onGameCreated(game);
              }
            } catch (_) {}
          },
        )
        .subscribe();
    return channel;
  }
}
