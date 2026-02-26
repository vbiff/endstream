import '../models/models.dart';

/// Abstract interface for card catalog operations.
abstract class CardService {
  /// Fetch all cards — may use cache if available.
  Future<List<GameCard>> getAllCards();

  /// Fetch a single card by ID with abilities.
  Future<GameCard> getCard(String cardId);

  /// Fetch cards filtered by type.
  Future<List<GameCard>> getCardsByType(CardType type);

  /// Fetch cards by a list of IDs.
  Future<List<GameCard>> getCardsByIds(List<String> cardIds);
}
