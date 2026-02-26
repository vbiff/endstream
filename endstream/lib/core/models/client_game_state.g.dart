// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientGameStateImpl _$$ClientGameStateImplFromJson(
  Map<String, dynamic> json,
) => _$ClientGameStateImpl(
  game: Game.fromJson(json['game'] as Map<String, dynamic>),
  myStream: (json['myStream'] as List<dynamic>)
      .map((e) => Turnpoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  opponentStream: (json['opponentStream'] as List<dynamic>)
      .map((e) => Turnpoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  myHand: (json['myHand'] as List<dynamic>)
      .map((e) => GameCard.fromJson(e as Map<String, dynamic>))
      .toList(),
  actionPoints: (json['actionPoints'] as num?)?.toInt() ?? 3,
  maxActionPoints: (json['maxActionPoints'] as num?)?.toInt() ?? 3,
  phase:
      $enumDecodeNullable(_$GamePhaseEnumMap, json['phase']) ??
      GamePhase.actionPhase,
  myPlayerId: json['myPlayerId'] as String,
  handSize: (json['handSize'] as num?)?.toInt() ?? 0,
  opponentHandSize: (json['opponentHandSize'] as num?)?.toInt() ?? 0,
  myControllerHp: (json['myControllerHp'] as num?)?.toInt() ?? 10,
  opponentControllerHp: (json['opponentControllerHp'] as num?)?.toInt() ?? 10,
  opponentPlayerId: json['opponentPlayerId'] as String? ?? '',
  myControllerId: json['myControllerId'] as String?,
);

Map<String, dynamic> _$$ClientGameStateImplToJson(
  _$ClientGameStateImpl instance,
) => <String, dynamic>{
  'game': instance.game.toJson(),
  'myStream': instance.myStream.map((e) => e.toJson()).toList(),
  'opponentStream': instance.opponentStream.map((e) => e.toJson()).toList(),
  'myHand': instance.myHand.map((e) => e.toJson()).toList(),
  'actionPoints': instance.actionPoints,
  'maxActionPoints': instance.maxActionPoints,
  'phase': _$GamePhaseEnumMap[instance.phase]!,
  'myPlayerId': instance.myPlayerId,
  'handSize': instance.handSize,
  'opponentHandSize': instance.opponentHandSize,
  'myControllerHp': instance.myControllerHp,
  'opponentControllerHp': instance.opponentControllerHp,
  'opponentPlayerId': instance.opponentPlayerId,
  'myControllerId': instance.myControllerId,
};

const _$GamePhaseEnumMap = {
  GamePhase.gameInit: 'gameInit',
  GamePhase.turnStart: 'turnStart',
  GamePhase.actionPhase: 'actionPhase',
  GamePhase.turnEnd: 'turnEnd',
  GamePhase.gameOver: 'gameOver',
};
