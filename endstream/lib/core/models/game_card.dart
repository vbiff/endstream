import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'game_card.freezed.dart';
part 'game_card.g.dart';

@freezed
class GameCard with _$GameCard {
  const factory GameCard({
    required String id,
    required String name,
    required CardType type,
    required int cost,
    @Default(Rarity.common) Rarity rarity,
    String? text,
    String? flavorText,
    String? artAssetPath,
    int? hp,
    int? attack,
    @Default([]) List<Ability> abilities,
  }) = _GameCard;

  factory GameCard.fromJson(Map<String, dynamic> json) =>
      _$GameCardFromJson(json);
}

@freezed
class Ability with _$Ability {
  const factory Ability({
    required String id,
    required String cardId,
    required String name,
    String? description,
    @Default(0) int cost,
  }) = _Ability;

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
}
