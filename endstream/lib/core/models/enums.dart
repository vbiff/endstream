import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum CardType {
  @JsonValue('operator')
  operatorCard('operator'),
  @JsonValue('tactic')
  tactic('tactic'),
  @JsonValue('event')
  event('event'),
  @JsonValue('equipment')
  equipment('equipment');

  const CardType(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum Rarity {
  @JsonValue('common')
  common('common'),
  @JsonValue('rare')
  rare('rare'),
  @JsonValue('epic')
  epic('epic'),
  @JsonValue('legendary')
  legendary('legendary');

  const Rarity(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum GameStatus {
  @JsonValue('active')
  active('active'),
  @JsonValue('completed')
  completed('completed'),
  @JsonValue('abandoned')
  abandoned('abandoned');

  const GameStatus(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum ActionType {
  @JsonValue('play_card')
  playCard('play_card'),
  @JsonValue('move')
  move('move'),
  @JsonValue('attack')
  attack('attack'),
  @JsonValue('ability')
  ability('ability'),
  @JsonValue('end_turn')
  endTurn('end_turn');

  const ActionType(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum FriendshipStatus {
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('accepted')
  accepted('accepted');

  const FriendshipStatus(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum ChallengeStatus {
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('accepted')
  accepted('accepted'),
  @JsonValue('declined')
  declined('declined'),
  @JsonValue('expired')
  expired('expired');

  const ChallengeStatus(this.value);
  final String value;
}

enum GamePhase {
  gameInit,
  turnStart,
  actionPhase,
  turnEnd,
  gameOver,
}

enum OpponentType {
  random,
  friend,
  local,
}
