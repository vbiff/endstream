import '../models/models.dart';

/// Abstract interface for deck operations.
abstract class DeckService {
  /// Fetch all decks for the current player.
  Future<List<Deck>> getDecks();

  /// Fetch a single deck with its cards.
  Future<Deck> getDeck(String deckId);

  /// Create a new empty deck.
  Future<Deck> createDeck(String name);

  /// Update a deck's card list. Returns the updated deck and validation errors.
  Future<({Deck deck, List<String> validationErrors})> updateDeck(
      String deckId, List<DeckCard> cards);

  /// Rename a deck.
  Future<void> renameDeck(String deckId, String name);

  /// Delete a deck.
  Future<void> deleteDeck(String deckId);

  /// Validate a deck via Edge Function.
  Future<({bool valid, List<String> errors})> validateDeck(String deckId);

  /// Duplicate a deck.
  Future<Deck> duplicateDeck(String sourceDeckId, String newName);
}
