// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendshipImpl _$$FriendshipImplFromJson(Map<String, dynamic> json) =>
    _$FriendshipImpl(
      playerId: json['player_id'] as String,
      friendId: json['friend_id'] as String,
      status:
          $enumDecodeNullable(_$FriendshipStatusEnumMap, json['status']) ??
          FriendshipStatus.pending,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$FriendshipImplToJson(_$FriendshipImpl instance) =>
    <String, dynamic>{
      'player_id': instance.playerId,
      'friend_id': instance.friendId,
      'status': _$FriendshipStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$FriendshipStatusEnumMap = {
  FriendshipStatus.pending: 'pending',
  FriendshipStatus.accepted: 'accepted',
};
