import 'package:freezed_annotation/freezed_annotation.dart';

import 'operator_instance.dart';

part 'turnpoint.freezed.dart';
part 'turnpoint.g.dart';

@freezed
class Turnpoint with _$Turnpoint {
  const factory Turnpoint({
    required int century,
    @Default('standard') String terrainType,
    @Default([]) List<OperatorInstance> operators,
    @Default([]) List<TurnpointEffect> activeEffects,
    @Default(false) bool controllerPresent,
  }) = _Turnpoint;

  factory Turnpoint.fromJson(Map<String, dynamic> json) =>
      _$TurnpointFromJson(json);
}

@freezed
class TurnpointEffect with _$TurnpointEffect {
  const factory TurnpointEffect({
    required String id,
    required String name,
    required String description,
    required String sourceCardId,
    @Default(0) int turnsRemaining,
  }) = _TurnpointEffect;

  factory TurnpointEffect.fromJson(Map<String, dynamic> json) =>
      _$TurnpointEffectFromJson(json);
}
