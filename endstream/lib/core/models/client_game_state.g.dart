// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientGameStateImpl _$$ClientGameStateImplFromJson(
  Map<String, dynamic> json,
) => _$ClientGameStateImpl(
  game: Game.fromJson(json['game'] as Map<String, dynamic>),
  myStream: (json['my_stream'] as List<dynamic>)
      .map((e) => Turnpoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  opponentStream: (json['opponent_stream'] as List<dynamic>)
      .map((e) => Turnpoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  myHand: (json['my_hand'] as List<dynamic>)
      .map((e) => GameCard.fromJson(e as Map<String, dynamic>))
      .toList(),
  actionPoints: (json['action_points'] as num?)?.toInt() ?? 3,
  maxActionPoints: (json['max_action_points'] as num?)?.toInt() ?? 3,
  phase:
      $enumDecodeNullable(_$GamePhaseEnumMap, json['phase']) ??
      GamePhase.actionPhase,
  myPlayerId: json['my_player_id'] as String,
);

Map<String, dynamic> _$$ClientGameStateImplToJson(
  _$ClientGameStateImpl instance,
) => <String, dynamic>{
  'game': instance.game.toJson(),
  'my_stream': instance.myStream.map((e) => e.toJson()).toList(),
  'opponent_stream': instance.opponentStream.map((e) => e.toJson()).toList(),
  'my_hand': instance.myHand.map((e) => e.toJson()).toList(),
  'action_points': instance.actionPoints,
  'max_action_points': instance.maxActionPoints,
  'phase': _$GamePhaseEnumMap[instance.phase]!,
  'my_player_id': instance.myPlayerId,
};

const _$GamePhaseEnumMap = {
  GamePhase.gameInit: 'gameInit',
  GamePhase.turnStart: 'turnStart',
  GamePhase.actionPhase: 'actionPhase',
  GamePhase.turnEnd: 'turnEnd',
  GamePhase.gameOver: 'gameOver',
};
