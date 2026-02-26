// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameActionImpl _$$GameActionImplFromJson(Map<String, dynamic> json) =>
    _$GameActionImpl(
      id: json['id'] as String?,
      gameId: json['game_id'] as String,
      turn: (json['turn'] as num).toInt(),
      playerId: json['player_id'] as String,
      type: $enumDecode(_$ActionTypeEnumMap, json['type']),
      source: json['source'] == null
          ? null
          : ActionSource.fromJson(json['source'] as Map<String, dynamic>),
      target: json['target'] == null
          ? null
          : ActionTarget.fromJson(json['target'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : ActionResult.fromJson(json['result'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$GameActionImplToJson(_$GameActionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'game_id': instance.gameId,
      'turn': instance.turn,
      'player_id': instance.playerId,
      'type': _$ActionTypeEnumMap[instance.type]!,
      'source': instance.source?.toJson(),
      'target': instance.target?.toJson(),
      'result': instance.result?.toJson(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$ActionTypeEnumMap = {
  ActionType.playCard: 'play_card',
  ActionType.move: 'move',
  ActionType.attack: 'attack',
  ActionType.ability: 'ability',
  ActionType.endTurn: 'end_turn',
};

_$ActionSourceImpl _$$ActionSourceImplFromJson(Map<String, dynamic> json) =>
    _$ActionSourceImpl(
      type: json['type'] as String,
      id: json['id'] as String,
      position: json['position'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ActionSourceImplToJson(_$ActionSourceImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'position': instance.position,
    };

_$ActionTargetImpl _$$ActionTargetImplFromJson(Map<String, dynamic> json) =>
    _$ActionTargetImpl(
      type: json['type'] as String,
      id: json['id'] as String,
      position: json['position'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ActionTargetImplToJson(_$ActionTargetImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'position': instance.position,
    };

_$ActionResultImpl _$$ActionResultImplFromJson(Map<String, dynamic> json) =>
    _$ActionResultImpl(
      damage: (json['damage'] as num?)?.toInt(),
      healed: (json['healed'] as num?)?.toInt(),
      statusApplied: json['status_applied'] as String?,
      eliminated: json['eliminated'] as bool?,
      gameOver: json['game_over'] as bool?,
      winnerId: json['winner_id'] as String?,
    );

Map<String, dynamic> _$$ActionResultImplToJson(_$ActionResultImpl instance) =>
    <String, dynamic>{
      'damage': instance.damage,
      'healed': instance.healed,
      'status_applied': instance.statusApplied,
      'eliminated': instance.eliminated,
      'game_over': instance.gameOver,
      'winner_id': instance.winnerId,
    };
