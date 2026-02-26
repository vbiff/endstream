import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck.freezed.dart';
part 'deck.g.dart';

@freezed
class Deck with _$Deck {
  const factory Deck({
    required String id,
    required String ownerId,
    required String name,
    @Default([]) List<DeckCard> cards,
    @Default(false) bool isValid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Deck;

  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);
}

@freezed
class DeckCard with _$DeckCard {
  const factory DeckCard({
    required String cardId,
    @Default(1) int quantity,
  }) = _DeckCard;

  factory DeckCard.fromJson(Map<String, dynamic> json) =>
      _$DeckCardFromJson(json);
}
