import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

/// Abstract interface for social operations (friends, challenges, presence).
abstract class SocialService {
  // ── Friends ──

  /// Get all accepted friends as Player objects.
  Future<List<Player>> getFriends();

  /// Get pending friend requests sent TO the current user.
  Future<List<Friendship>> getPendingRequests();

  /// Send a friend request.
  Future<void> sendFriendRequest(String friendId);

  /// Accept a friend request.
  Future<void> acceptFriendRequest(String requesterId);

  /// Decline a friend request.
  Future<void> declineFriendRequest(String requesterId);

  /// Remove a friend.
  Future<void> removeFriend(String friendId);

  /// Search for players by display name.
  Future<List<Player>> searchPlayers(String query);

  // ── Player Profiles ──

  /// Get a player's public profile.
  Future<Player> getPlayerProfile(String playerId);

  // ── Challenges ──

  /// Send a game challenge to a friend.
  Future<Challenge> sendChallenge({
    required String toPlayerId,
    required String deckId,
  });

  /// Get pending challenges sent to the current user.
  Future<List<Challenge>> getPendingChallenges();

  /// Accept a challenge.
  Future<void> acceptChallenge(String challengeId);

  /// Decline a challenge.
  Future<void> declineChallenge(String challengeId);

  // ── Presence ──

  /// Subscribe to friend presence (online/offline tracking).
  RealtimeChannel subscribeToPresence({
    required void Function(Map<String, dynamic> presences) onSync,
  });

  /// Subscribe to incoming challenges via Realtime.
  RealtimeChannel subscribeToChallenges({
    required void Function(Challenge challenge) onChallengeReceived,
  });
}
