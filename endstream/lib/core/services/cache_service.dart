import '../models/models.dart';

/// Abstract interface for local caching of card catalog and decks.
abstract class CacheService {
  // ── Card Catalog ──

  /// Returns cached cards if fresh, otherwise null.
  Future<List<GameCard>?> getCachedCards();

  /// Store cards in the local cache.
  Future<void> cacheCards(List<GameCard> cards);

  /// Invalidate card cache.
  Future<void> invalidateCards();

  // ── Decks ──

  /// Returns cached decks if fresh, otherwise null.
  Future<List<Deck>?> getCachedDecks();

  /// Store decks in the local cache.
  Future<void> cacheDecks(List<Deck> decks);

  /// Invalidate deck cache (call after save/create/delete).
  Future<void> invalidateDecks();
}
