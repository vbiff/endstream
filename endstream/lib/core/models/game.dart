import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  const factory Game({
    required String id,
    @JsonKey(name: 'player_1_id') required String player1Id,
    @JsonKey(name: 'player_2_id') required String player2Id,
    @Default(GameStatus.active) GameStatus status,
    String? winnerId,
    @Default(1) int currentTurn,
    required String activePlayerId,
    @JsonKey(name: 'game_mode') @Default(GameMode.online) GameMode gameMode,
    DateTime? createdAt,
    DateTime? lastActionAt,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
