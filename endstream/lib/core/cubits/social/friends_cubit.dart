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

  /// Load friends list and pending requests.
  Future<void> loadFriends() async {
    emit(const FriendsLoading());
    try {
      final friends = await _socialService.getFriends();
      final pending = await _socialService.getPendingRequests();
      emit(FriendsLoaded(
        friends: friends,
        pendingRequests: pending,
        onlineIds: const {},
      ));
      _subscribeToPresence();
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  void _subscribeToPresence() {
    _presenceChannel?.unsubscribe();
    _presenceChannel = _socialService.subscribeToPresence(
      onSync: (presences) {
        final current = state;
        if (current is FriendsLoaded) {
          emit(current.copyWith(
            onlineIds: presences.keys.toSet(),
          ));
        }
      },
    );
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

  /// Search for players.
  Future<List<Player>> searchPlayers(String query) async {
    return _socialService.searchPlayers(query);
  }

  @override
  Future<void> close() {
    _presenceChannel?.unsubscribe();
    return super.close();
  }
}
