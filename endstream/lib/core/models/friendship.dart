import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'friendship.freezed.dart';
part 'friendship.g.dart';

@freezed
class Friendship with _$Friendship {
  const factory Friendship({
    required String playerId,
    required String friendId,
    @Default(FriendshipStatus.pending) FriendshipStatus status,
    DateTime? createdAt,
  }) = _Friendship;

  factory Friendship.fromJson(Map<String, dynamic> json) =>
      _$FriendshipFromJson(json);
}
