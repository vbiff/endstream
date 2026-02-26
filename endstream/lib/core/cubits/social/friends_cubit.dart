import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show RealtimeChannel;

import '../../models/models.dart';
import '../../services/social_service.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit(this._socialService) : super(const FriendsInitial());

  final SocialService _socialService;
  RealtimeChannel? _presenceChannel;
  RealtimeChannel? _challengeChannel;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _wasDisconnected = false;

  /// Load friends list, pending requests, and challenges.
  Future<void> loadFriends() async {
    emit(const FriendsLoading());
    try {
      final results = await Future.wait([
        _socialService.getFriends(),
        _socialService.getPendingRequests(),
        _socialService.getPendingChallenges(),
      ]);
      final friends = results[0] as List<Player>;
      final pending = results[1] as List<Friendship>;
      final challenges = results[2] as List<Challenge>;
      emit(FriendsLoaded(
        friends: friends,
        pendingRequests: pending,
        onlineIds: const {},
        pendingChallenges: challenges,
      ));
      _subscribeToPresence();
      _subscribeToChallenges();
      _subscribeToConnectivity();
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  void _subscribeToPresence() {
    _presenceChannel?.unsubscribe();
    _presenceChannel = _socialService.subscribeToPresence(
      onSync: (presences) {
        if (isClosed) return;
        final current = state;
        if (current is FriendsLoaded) {
          emit(current.copyWith(
            onlineIds: presences.keys.toSet(),
          ));
        }
      },
    );
  }

  void _subscribeToChallenges() {
    _challengeChannel?.unsubscribe();
    _challengeChannel = _socialService.subscribeToChallenges(
      onChallengeReceived: (challenge) {
        if (isClosed) return;
        final current = state;
        if (current is FriendsLoaded) {
          // Don't add duplicates
          if (current.pendingChallenges.any((c) => c.id == challenge.id)) {
            return;
          }
          emit(current.copyWith(
            pendingChallenges: [challenge, ...current.pendingChallenges],
          ));
        }
      },
    );
  }

  void _subscribeToConnectivity() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((results) {
      if (isClosed) return;
      final hasConnection =
          results.any((r) => r != ConnectivityResult.none);
      if (!hasConnection) {
        _wasDisconnected = true;
      } else if (_wasDisconnected) {
        _wasDisconnected = false;
        _subscribeToPresence();
        _subscribeToChallenges();
      }
    });
  }

  /// Send a friend request.
  Future<void> sendFriendRequest(String playerId) async {
    try {
      await _socialService.sendFriendRequest(playerId);
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  /// Accept a friend request.
  Future<void> acceptRequest(String requesterId) async {
    try {
      await _socialService.acceptFriendRequest(requesterId);
      await loadFriends();
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  /// Decline a friend request.
  Future<void> declineRequest(String requesterId) async {
    try {
      await _socialService.declineFriendRequest(requesterId);
      await loadFriends();
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  /// Remove a friend.
  Future<void> removeFriend(String friendId) async {
    try {
      await _socialService.removeFriend(friendId);
      await loadFriends();
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  /// Search for players and emit results into state.
  Future<void> searchPlayers(String query) async {
    final current = state;
    if (current is! FriendsLoaded) return;

    if (query.isEmpty) {
      emit(current.copyWith(searchResults: const []));
      return;
    }

    try {
      final results = await _socialService.searchPlayers(query);
      if (state is FriendsLoaded) {
        emit((state as FriendsLoaded).copyWith(searchResults: results));
      }
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  /// Clear search results.
  void clearSearch() {
    final current = state;
    if (current is FriendsLoaded) {
      emit(current.copyWith(searchResults: const []));
    }
  }

  /// Send a challenge to a friend.
  Future<void> sendChallenge({
    required String toPlayerId,
    required String deckId,
  }) async {
    try {
      await _socialService.sendChallenge(
        toPlayerId: toPlayerId,
        deckId: deckId,
      );
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  /// Accept a challenge.
  Future<void> acceptChallenge(String challengeId) async {
    try {
      await _socialService.acceptChallenge(challengeId);
      await _loadChallenges();
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  /// Decline a challenge.
  Future<void> declineChallenge(String challengeId) async {
    try {
      await _socialService.declineChallenge(challengeId);
      await _loadChallenges();
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  Future<void> _loadChallenges() async {
    final current = state;
    if (current is! FriendsLoaded) return;
    try {
      final challenges = await _socialService.getPendingChallenges();
      if (!isClosed && state is FriendsLoaded) {
        emit((state as FriendsLoaded).copyWith(pendingChallenges: challenges));
      }
    } catch (_) {
      // Keep current state if challenge refresh fails
    }
  }

  @override
  Future<void> close() {
    _presenceChannel?.unsubscribe();
    _challengeChannel?.unsubscribe();
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
