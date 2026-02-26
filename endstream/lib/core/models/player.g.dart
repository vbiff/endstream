// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
  id: json['id'] as String,
  displayName: json['display_name'] as String,
  rank: (json['rank'] as num?)?.toInt() ?? 1000,
  xp: (json['xp'] as num?)?.toInt() ?? 0,
  avatarId: json['avatar_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'rank': instance.rank,
      'xp': instance.xp,
      'avatar_id': instance.avatarId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
