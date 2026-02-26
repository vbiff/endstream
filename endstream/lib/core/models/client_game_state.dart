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
    required List<Turnpoint> myStream,
    required List<Turnpoint> opponentStream,
    required List<GameCard> myHand,
    @Default(3) int actionPoints,
    @Default(3) int maxActionPoints,
    @Default(GamePhase.actionPhase) GamePhase phase,
    required String myPlayerId,
  }) = _ClientGameState;

  factory ClientGameState.fromJson(Map<String, dynamic> json) =>
      _$ClientGameStateFromJson(json);
}
