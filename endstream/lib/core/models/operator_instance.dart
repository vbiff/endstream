import 'package:freezed_annotation/freezed_annotation.dart';

part 'operator_instance.freezed.dart';
part 'operator_instance.g.dart';

@freezed
class OperatorInstance with _$OperatorInstance {
  const factory OperatorInstance({
    @JsonKey(name: 'instanceId') String? instanceId,
    @JsonKey(name: 'operatorCardId') required String operatorCardId,
    @JsonKey(name: 'ownerId') required String ownerId,
    @JsonKey(name: 'currentHp') required int currentHp,
    @JsonKey(name: 'maxHp') required int maxHp,
    required int attack,
    required StreamPosition position,
    @JsonKey(name: 'statusEffects') @Default([]) List<StatusEffect> statusEffects,
    @JsonKey(name: 'hasActedThisTurn') @Default(false) bool hasActedThisTurn,
    @JsonKey(name: 'equipmentCardIds') @Default([]) List<String> equipmentCardIds,
  }) = _OperatorInstance;

  factory OperatorInstance.fromJson(Map<String, dynamic> json) =>
      _$OperatorInstanceFromJson(json);
}

@freezed
class StreamPosition with _$StreamPosition {
  const factory StreamPosition({
    required int stream, // 0 or 1
    @JsonKey(name: 'centuryIndex') required int centuryIndex, // 0-5
  }) = _StreamPosition;

  factory StreamPosition.fromJson(Map<String, dynamic> json) =>
      _$StreamPositionFromJson(json);
}

@freezed
class StatusEffect with _$StatusEffect {
  const factory StatusEffect({
    required String type,
    int? value,
    @JsonKey(name: 'turnsRemaining') @Default(0) int turnsRemaining,
    @JsonKey(name: 'sourcePlayerId') required String sourcePlayerId,
  }) = _StatusEffect;

  factory StatusEffect.fromJson(Map<String, dynamic> json) =>
      _$StatusEffectFromJson(json);
}
