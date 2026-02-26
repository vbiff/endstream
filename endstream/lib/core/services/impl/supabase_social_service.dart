import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/models.dart';
import '../social_service.dart';

class SupabaseSocialService implements SocialService {
  SupabaseSocialService(this._client);
  final SupabaseClient _client;

  String get _userId {
    final user = _client.auth.currentUser;
    if (user == null) throw StateError('User not authenticated');
    return user.id;
  }

  @override
  Future<List<Player>> getFriends() async {
    final data = await _client
        .from('friendships')
        .select()
        .or('player_id.eq.$_userId,friend_id.eq.$_userId')
        .eq('status', 'accepted');

    final friendIds = (data as List).map((row) {
      final playerId = row['player_id'] as String;
      final friendId = row['friend_id'] as String;
      return playerId == _userId ? friendId : playerId;
    }).toList();

    if (friendIds.isEmpty) return [];

    final profiles = await _client
        .from('players')
        .select()
        .inFilter('id', friendIds);
    return (profiles as List).map((p) => Player.fromJson(p)).toList();
  }

  @override
  Future<List<Friendship>> getPendingRequests() async {
    final data = await _client
        .from('friendships')
        .select()
        .eq('friend_id', _userId)
        .eq('status', 'pending');
    return (data as List).map((row) => Friendship.fromJson(row)).toList();
  }

  @override
  Future<void> sendFriendRequest(String friendId) async {
    await _client.from('friendships').insert({
      'player_id': _userId,
      'friend_id': friendId,
      'status': 'pending',
    });
  }

  @override
  Future<void> acceptFriendRequest(String requesterId) async {
    await _client
        .from('friendships')
        .update({'status': 'accepted'})
        .eq('player_id', requesterId)
        .eq('friend_id', _userId);
  }

  @override
  Future<void> declineFriendRequest(String requesterId) async {
    await _client
        .from('friendships')
        .delete()
        .eq('player_id', requesterId)
        .eq('friend_id', _userId);
  }

  @override
  Future<void> removeFriend(String friendId) async {
    await _client
        .from('friendships')
        .delete()
        .or(
          'and(player_id.eq.$_userId,friend_id.eq.$friendId),'
          'and(player_id.eq.$friendId,friend_id.eq.$_userId)',
        );
  }

  @override
  Future<List<Player>> searchPlayers(String query) async {
    final data = await _client
        .from('players')
        .select()
        .ilike('display_name', '%$query%')
        .neq('id', _userId)
        .limit(20);
    return (data as List).map((p) => Player.fromJson(p)).toList();
  }

  @override
  Future<Player> getPlayerProfile(String playerId) async {
    final data = await _client
        .from('players')
        .select()
        .eq('id', playerId)
        .single();
    return Player.fromJson(data);
  }

  @override
  Future<Challenge> sendChallenge({
    required String toPlayerId,
    required String deckId,
  }) async {
    final data = await _client.from('challenges').insert({
      'from_player_id': _userId,
      'to_player_id': toPlayerId,
      'deck_id': deckId,
    }).select().single();
    return Challenge.fromJson(data);
  }

  @override
  Future<List<Challenge>> getPendingChallenges() async {
    final data = await _client
        .from('challenges')
        .select()
        .eq('to_player_id', _userId)
        .eq('status', 'pending')
        .order('created_at', ascending: false);
    return (data as List).map((c) => Challenge.fromJson(c)).toList();
  }

  @override
  Future<void> acceptChallenge(String challengeId) async {
    await _client
        .from('challenges')
        .update({'status': 'accepted'})
        .eq('id', challengeId);
  }

  @override
  Future<void> declineChallenge(String challengeId) async {
    await _client
        .from('challenges')
        .update({'status': 'declined'})
        .eq('id', challengeId);
  }

  @override
  RealtimeChannel subscribeToPresence({
    required void Function(Map<String, dynamic> presences) onSync,
  }) {
    final channel = _client.channel('presence:friends');
    channel.onPresenceSync((_) {
      final state = channel.presenceState();
      final presences = <String, dynamic>{};
      for (final presence in state) {
        final userId = presence.presences.firstOrNull?.payload['user_id'];
        if (userId != null) {
          presences[userId.toString()] = true;
        }
      }
      onSync(presences);
    }).subscribe((status, [error]) {
      if (status == RealtimeSubscribeStatus.subscribed) {
        channel.track({'user_id': _userId, 'online_at': DateTime.now().toIso8601String()});
      }
    });
    return channel;
  }

  @override
  RealtimeChannel subscribeToChallenges({
    required void Function(Challenge challenge) onChallengeReceived,
  }) {
    final channel = _client.channel('challenges:$_userId');
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'challenges',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'to_player_id',
            value: _userId,
          ),
          callback: (payload) {
            onChallengeReceived(Challenge.fromJson(payload.newRecord));
          },
        )
        .subscribe();
    return channel;
  }
}
