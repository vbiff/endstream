part of 'friends_cubit.dart';

sealed class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object?> get props => [];
}

final class FriendsInitial extends FriendsState {
  const FriendsInitial();
}

final class FriendsLoading extends FriendsState {
  const FriendsLoading();
}

final class FriendsLoaded extends FriendsState {
  const FriendsLoaded({
    required this.friends,
    required this.pendingRequests,
    required this.onlineIds,
    this.pendingChallenges = const [],
    this.searchResults = const [],
  });

  final List<Player> friends;
  final List<Friendship> pendingRequests;
  final Set<String> onlineIds;
  final List<Challenge> pendingChallenges;
  final List<Player> searchResults;

  List<Player> get onlineFriends =>
      friends.where((f) => onlineIds.contains(f.id)).toList();

  List<Player> get offlineFriends =>
      friends.where((f) => !onlineIds.contains(f.id)).toList();

  FriendsLoaded copyWith({
    List<Player>? friends,
    List<Friendship>? pendingRequests,
    Set<String>? onlineIds,
    List<Challenge>? pendingChallenges,
    List<Player>? searchResults,
  }) =>
      FriendsLoaded(
        friends: friends ?? this.friends,
        pendingRequests: pendingRequests ?? this.pendingRequests,
        onlineIds: onlineIds ?? this.onlineIds,
        pendingChallenges: pendingChallenges ?? this.pendingChallenges,
        searchResults: searchResults ?? this.searchResults,
      );

  @override
  List<Object?> get props =>
      [friends, pendingRequests, onlineIds, pendingChallenges, searchResults];
}

final class FriendsError extends FriendsState {
  const FriendsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
