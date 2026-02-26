// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperatorInstanceImpl _$$OperatorInstanceImplFromJson(
  Map<String, dynamic> json,
) => _$OperatorInstanceImpl(
  operatorCardId: json['operator_card_id'] as String,
  ownerId: json['owner_id'] as String,
  currentHp: (json['current_hp'] as num).toInt(),
  maxHp: (json['max_hp'] as num).toInt(),
  attack: (json['attack'] as num).toInt(),
  position: StreamPosition.fromJson(json['position'] as Map<String, dynamic>),
  statusEffects:
      (json['status_effects'] as List<dynamic>?)
          ?.map((e) => StatusEffect.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  hasActedThisTurn: json['has_acted_this_turn'] as bool? ?? false,
  equipmentCardIds:
      (json['equipment_card_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$OperatorInstanceImplToJson(
  _$OperatorInstanceImpl instance,
) => <String, dynamic>{
  'operator_card_id': instance.operatorCardId,
  'owner_id': instance.ownerId,
  'current_hp': instance.currentHp,
  'max_hp': instance.maxHp,
  'attack': instance.attack,
  'position': instance.position.toJson(),
  'status_effects': instance.statusEffects.map((e) => e.toJson()).toList(),
  'has_acted_this_turn': instance.hasActedThisTurn,
  'equipment_card_ids': instance.equipmentCardIds,
};

_$StreamPositionImpl _$$StreamPositionImplFromJson(Map<String, dynamic> json) =>
    _$StreamPositionImpl(
      stream: (json['stream'] as num).toInt(),
      centuryIndex: (json['century_index'] as num).toInt(),
    );

Map<String, dynamic> _$$StreamPositionImplToJson(
  _$StreamPositionImpl instance,
) => <String, dynamic>{
  'stream': instance.stream,
  'century_index': instance.centuryIndex,
};

_$StatusEffectImpl _$$StatusEffectImplFromJson(Map<String, dynamic> json) =>
    _$StatusEffectImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      turnsRemaining: (json['turns_remaining'] as num?)?.toInt() ?? 0,
      attackModifier: (json['attack_modifier'] as num?)?.toInt(),
      movementBlocked: json['movement_blocked'] as bool?,
    );

Map<String, dynamic> _$$StatusEffectImplToJson(_$StatusEffectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'turns_remaining': instance.turnsRemaining,
      'attack_modifier': instance.attackModifier,
      'movement_blocked': instance.movementBlocked,
    };
