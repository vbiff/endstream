// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperatorInstanceImpl _$$OperatorInstanceImplFromJson(
  Map<String, dynamic> json,
) => _$OperatorInstanceImpl(
  instanceId: json['instanceId'] as String?,
  operatorCardId: json['operatorCardId'] as String,
  ownerId: json['ownerId'] as String,
  currentHp: (json['currentHp'] as num).toInt(),
  maxHp: (json['maxHp'] as num).toInt(),
  attack: (json['attack'] as num).toInt(),
  position: StreamPosition.fromJson(json['position'] as Map<String, dynamic>),
  statusEffects:
      (json['statusEffects'] as List<dynamic>?)
          ?.map((e) => StatusEffect.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  hasActedThisTurn: json['hasActedThisTurn'] as bool? ?? false,
  equipmentCardIds:
      (json['equipmentCardIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$OperatorInstanceImplToJson(
  _$OperatorInstanceImpl instance,
) => <String, dynamic>{
  'instanceId': instance.instanceId,
  'operatorCardId': instance.operatorCardId,
  'ownerId': instance.ownerId,
  'currentHp': instance.currentHp,
  'maxHp': instance.maxHp,
  'attack': instance.attack,
  'position': instance.position.toJson(),
  'statusEffects': instance.statusEffects.map((e) => e.toJson()).toList(),
  'hasActedThisTurn': instance.hasActedThisTurn,
  'equipmentCardIds': instance.equipmentCardIds,
};

_$StreamPositionImpl _$$StreamPositionImplFromJson(Map<String, dynamic> json) =>
    _$StreamPositionImpl(
      stream: (json['stream'] as num).toInt(),
      centuryIndex: (json['centuryIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$StreamPositionImplToJson(
  _$StreamPositionImpl instance,
) => <String, dynamic>{
  'stream': instance.stream,
  'centuryIndex': instance.centuryIndex,
};

_$StatusEffectImpl _$$StatusEffectImplFromJson(Map<String, dynamic> json) =>
    _$StatusEffectImpl(
      type: json['type'] as String,
      value: (json['value'] as num?)?.toInt(),
      turnsRemaining: (json['turnsRemaining'] as num?)?.toInt() ?? 0,
      sourcePlayerId: json['sourcePlayerId'] as String,
    );

Map<String, dynamic> _$$StatusEffectImplToJson(_$StatusEffectImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'turnsRemaining': instance.turnsRemaining,
      'sourcePlayerId': instance.sourcePlayerId,
    };
