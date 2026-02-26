import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'game_action.freezed.dart';
part 'game_action.g.dart';

@freezed
class GameAction with _$GameAction {
  const factory GameAction({
    String? id,
    required String gameId,
    required int turn,
    required String playerId,
    required ActionType type,
    ActionSource? source,
    ActionTarget? target,
    ActionResult? result,
    DateTime? createdAt,
  }) = _GameAction;

  factory GameAction.fromJson(Map<String, dynamic> json) =>
      _$GameActionFromJson(json);
}

@freezed
class ActionSource with _$ActionSource {
  const factory ActionSource({
    required String type, // 'card', 'operator'
    required String id,
    Map<String, dynamic>? position,
  }) = _ActionSource;

  factory ActionSource.fromJson(Map<String, dynamic> json) =>
      _$ActionSourceFromJson(json);
}

@freezed
class ActionTarget with _$ActionTarget {
  const factory ActionTarget({
    required String type, // 'operator', 'turnpoint', 'controller'
    required String id,
    Map<String, dynamic>? position,
  }) = _ActionTarget;

  factory ActionTarget.fromJson(Map<String, dynamic> json) =>
      _$ActionTargetFromJson(json);
}

@freezed
class ActionResult with _$ActionResult {
  const factory ActionResult({
    int? damage,
    int? healed,
    String? statusApplied,
    bool? eliminated,
    bool? gameOver,
    String? winnerId,
  }) = _ActionResult;

  factory ActionResult.fromJson(Map<String, dynamic> json) =>
      _$ActionResultFromJson(json);
}
