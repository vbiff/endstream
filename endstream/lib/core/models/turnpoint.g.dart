// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turnpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TurnpointImpl _$$TurnpointImplFromJson(Map<String, dynamic> json) =>
    _$TurnpointImpl(
      century: (json['centuryIndex'] as num).toInt(),
      terrainType: json['terrain_type'] as String? ?? 'standard',
      operators:
          (json['operators'] as List<dynamic>?)
              ?.map((e) => OperatorInstance.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      activeEffects:
          (json['activeEffects'] as List<dynamic>?)
              ?.map((e) => TurnpointEffect.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      controllerPresent: json['controllerPresent'] as bool? ?? false,
    );

Map<String, dynamic> _$$TurnpointImplToJson(_$TurnpointImpl instance) =>
    <String, dynamic>{
      'centuryIndex': instance.century,
      'terrain_type': instance.terrainType,
      'operators': instance.operators.map((e) => e.toJson()).toList(),
      'activeEffects': instance.activeEffects.map((e) => e.toJson()).toList(),
      'controllerPresent': instance.controllerPresent,
    };

_$TurnpointEffectImpl _$$TurnpointEffectImplFromJson(
  Map<String, dynamic> json,
) => _$TurnpointEffectImpl(
  type: json['type'] as String,
  sourceCardId: json['sourceCardId'] as String,
  sourcePlayerId: json['sourcePlayerId'] as String,
  turnsRemaining: (json['turnsRemaining'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$TurnpointEffectImplToJson(
  _$TurnpointEffectImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'sourceCardId': instance.sourceCardId,
  'sourcePlayerId': instance.sourcePlayerId,
  'turnsRemaining': instance.turnsRemaining,
};
