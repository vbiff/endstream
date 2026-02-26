import 'package:freezed_annotation/freezed_annotation.dart';

part 'operator_instance.freezed.dart';
part 'operator_instance.g.dart';

@freezed
class OperatorInstance with _$OperatorInstance {
  const factory OperatorInstance({
    required String operatorCardId,
    required String ownerId,
    required int currentHp,
    required int maxHp,
    required int attack,
    required StreamPosition position,
    @Default([]) List<StatusEffect> statusEffects,
    @Default(false) bool hasActedThisTurn,
    @Default([]) List<String> equipmentCardIds,
  }) = _OperatorInstance;

  factory OperatorInstance.fromJson(Map<String, dynamic> json) =>
      _$OperatorInstanceFromJson(json);
}

@freezed
class StreamPosition with _$StreamPosition {
  const factory StreamPosition({
    required int stream, // 0 or 1
    required int centuryIndex, // 0-5
  }) = _StreamPosition;

  factory StreamPosition.fromJson(Map<String, dynamic> json) =>
      _$StreamPositionFromJson(json);
}

@freezed
class StatusEffect with _$StatusEffect {
  const factory StatusEffect({
    required String id,
    required String name,
    String? description,
    @Default(0) int turnsRemaining,
    int? attackModifier,
    bool? movementBlocked,
  }) = _StatusEffect;

  factory StatusEffect.fromJson(Map<String, dynamic> json) =>
      _$StatusEffectFromJson(json);
}
