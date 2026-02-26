import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';
import 'game.dart';
import 'game_card.dart';
import 'turnpoint.dart';

part 'client_game_state.freezed.dart';
part 'client_game_state.g.dart';

/// Full game state as seen by the local player.
/// Assembled from game + game_streams + game_hands tables.
@freezed
class ClientGameState with _$ClientGameState {
  const factory ClientGameState({
    required Game game,
    @JsonKey(name: 'myStream') required List<Turnpoint> myStream,
    @JsonKey(name: 'opponentStream') required List<Turnpoint> opponentStream,
    @JsonKey(name: 'myHand') required List<GameCard> myHand,
    @JsonKey(name: 'actionPoints') @Default(3) int actionPoints,
    @JsonKey(name: 'maxActionPoints') @Default(3) int maxActionPoints,
    @Default(GamePhase.actionPhase) GamePhase phase,
    @JsonKey(name: 'myPlayerId') required String myPlayerId,
    @JsonKey(name: 'handSize') @Default(0) int handSize,
    @JsonKey(name: 'opponentHandSize') @Default(0) int opponentHandSize,
    @JsonKey(name: 'myControllerHp') @Default(10) int myControllerHp,
    @JsonKey(name: 'opponentControllerHp') @Default(10) int opponentControllerHp,
    @JsonKey(name: 'opponentPlayerId') @Default('') String opponentPlayerId,
    @JsonKey(name: 'myControllerId') String? myControllerId,
  }) = _ClientGameState;

  factory ClientGameState.fromJson(Map<String, dynamic> json) =>
      _$ClientGameStateFromJson(json);
}
