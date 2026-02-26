import 'package:freezed_annotation/freezed_annotation.dart';

import 'operator_instance.dart';

part 'turnpoint.freezed.dart';
part 'turnpoint.g.dart';

@freezed
class Turnpoint with _$Turnpoint {
  const factory Turnpoint({
    @JsonKey(name: 'centuryIndex') required int century,
    @Default('standard') String terrainType,
    @Default([]) List<OperatorInstance> operators,
    @JsonKey(name: 'activeEffects') @Default([]) List<TurnpointEffect> activeEffects,
    @JsonKey(name: 'controllerPresent') @Default(false) bool controllerPresent,
  }) = _Turnpoint;

  factory Turnpoint.fromJson(Map<String, dynamic> json) =>
      _$TurnpointFromJson(json);
}

@freezed
class TurnpointEffect with _$TurnpointEffect {
  const factory TurnpointEffect({
    required String type,
    @JsonKey(name: 'sourceCardId') required String sourceCardId,
    @JsonKey(name: 'sourcePlayerId') required String sourcePlayerId,
    @JsonKey(name: 'turnsRemaining') @Default(0) int turnsRemaining,
  }) = _TurnpointEffect;

  factory TurnpointEffect.fromJson(Map<String, dynamic> json) =>
      _$TurnpointEffectFromJson(json);
}
