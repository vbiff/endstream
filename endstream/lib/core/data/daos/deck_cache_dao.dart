import 'package:drift/drift.dart';

import '../app_database.dart';

part 'deck_cache_dao.g.dart';

@DriftAccessor(tables: [CachedDecks, CachedDeckCards, CacheMetadata])
class DeckCacheDao extends DatabaseAccessor<AppDatabase>
    with _$DeckCacheDaoMixin {
  DeckCacheDao(super.db);

  static const _cacheKeyPrefix = 'decks';
  static const _staleDuration = Duration(minutes: 30);

  /// Check if the decks cache is still fresh.
  Future<bool> isFresh() async {
    final meta = await (select(cacheMetadata)
          ..where((t) => t.key.equals(_cacheKeyPrefix)))
        .getSingleOrNull();
    if (meta == null) return false;
    return DateTime.now().difference(meta.lastFetched) < _staleDuration;
  }

  /// Get all cached decks with their cards.
  Future<List<CachedDeckWithCards>> getAllDecks() async {
    final decks = await select(cachedDecks).get();
    final deckCards = await select(cachedDeckCards).get();

    final cardsMap = <String, List<CachedDeckCard>>{};
    for (final dc in deckCards) {
      cardsMap.putIfAbsent(dc.deckId, () => []).add(dc);
    }

    return decks.map((deck) {
      return CachedDeckWithCards(
        deck: deck,
        cards: cardsMap[deck.id] ?? [],
      );
    }).toList();
  }

  /// Replace all cached decks and deck_cards with fresh data.
  Future<void> replaceAll({
    required List<CachedDecksCompanion> decks,
    required List<CachedDeckCardsCompanion> deckCards,
  }) async {
    await transaction(() async {
      await delete(cachedDeckCards).go();
      await delete(cachedDecks).go();

      await batch((b) {
        b.insertAll(cachedDecks, decks);
        b.insertAll(cachedDeckCards, deckCards);
      });

      await into(cacheMetadata).insertOnConflictUpdate(
        CacheMetadataCompanion(
          key: const Value(_cacheKeyPrefix),
          lastFetched: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Invalidate the decks cache (called after save/create/delete).
  Future<void> invalidate() async {
    await (delete(cacheMetadata)
          ..where((t) => t.key.equals(_cacheKeyPrefix)))
        .go();
  }
}

/// Combines a cached deck with its cards.
class CachedDeckWithCards {
  const CachedDeckWithCards({
    required this.deck,
    required this.cards,
  });

  final CachedDeck deck;
  final List<CachedDeckCard> cards;
}
