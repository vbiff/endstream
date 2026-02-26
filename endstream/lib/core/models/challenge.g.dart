// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: json['id'] as String,
      fromPlayerId: json['from_player_id'] as String,
      toPlayerId: json['to_player_id'] as String,
      deckId: json['deck_id'] as String,
      status:
          $enumDecodeNullable(_$ChallengeStatusEnumMap, json['status']) ??
          ChallengeStatus.pending,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_player_id': instance.fromPlayerId,
      'to_player_id': instance.toPlayerId,
      'deck_id': instance.deckId,
      'status': _$ChallengeStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.pending: 'pending',
  ChallengeStatus.accepted: 'accepted',
  ChallengeStatus.declined: 'declined',
  ChallengeStatus.expired: 'expired',
};
