// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turnpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TurnpointImpl _$$TurnpointImplFromJson(Map<String, dynamic> json) =>
    _$TurnpointImpl(
      century: (json['century'] as num).toInt(),
      terrainType: json['terrain_type'] as String? ?? 'standard',
      operators:
          (json['operators'] as List<dynamic>?)
              ?.map((e) => OperatorInstance.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      activeEffects:
          (json['active_effects'] as List<dynamic>?)
              ?.map((e) => TurnpointEffect.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      controllerPresent: json['controller_present'] as bool? ?? false,
    );

Map<String, dynamic> _$$TurnpointImplToJson(_$TurnpointImpl instance) =>
    <String, dynamic>{
      'century': instance.century,
      'terrain_type': instance.terrainType,
      'operators': instance.operators.map((e) => e.toJson()).toList(),
      'active_effects': instance.activeEffects.map((e) => e.toJson()).toList(),
      'controller_present': instance.controllerPresent,
    };

_$TurnpointEffectImpl _$$TurnpointEffectImplFromJson(
  Map<String, dynamic> json,
) => _$TurnpointEffectImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  sourceCardId: json['source_card_id'] as String,
  turnsRemaining: (json['turns_remaining'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$TurnpointEffectImplToJson(
  _$TurnpointEffectImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'source_card_id': instance.sourceCardId,
  'turns_remaining': instance.turnsRemaining,
};
