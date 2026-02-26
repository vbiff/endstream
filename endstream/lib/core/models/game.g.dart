// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
  id: json['id'] as String,
  player1Id: json['player_1_id'] as String,
  player2Id: json['player_2_id'] as String,
  status:
      $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
      GameStatus.active,
  winnerId: json['winner_id'] as String?,
  currentTurn: (json['current_turn'] as num?)?.toInt() ?? 1,
  activePlayerId: json['active_player_id'] as String,
  gameMode:
      $enumDecodeNullable(_$GameModeEnumMap, json['game_mode']) ??
      GameMode.online,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  lastActionAt: json['last_action_at'] == null
      ? null
      : DateTime.parse(json['last_action_at'] as String),
);

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'player_1_id': instance.player1Id,
      'player_2_id': instance.player2Id,
      'status': _$GameStatusEnumMap[instance.status]!,
      'winner_id': instance.winnerId,
      'current_turn': instance.currentTurn,
      'active_player_id': instance.activePlayerId,
      'game_mode': _$GameModeEnumMap[instance.gameMode]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_action_at': instance.lastActionAt?.toIso8601String(),
    };

const _$GameStatusEnumMap = {
  GameStatus.active: 'active',
  GameStatus.completed: 'completed',
  GameStatus.abandoned: 'abandoned',
};

const _$GameModeEnumMap = {GameMode.online: 'online', GameMode.local: 'local'};
