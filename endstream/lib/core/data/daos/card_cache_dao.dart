import 'package:drift/drift.dart';

import '../app_database.dart';

part 'card_cache_dao.g.dart';

@DriftAccessor(tables: [CachedCards, CachedAbilities, CacheMetadata])
class CardCacheDao extends DatabaseAccessor<AppDatabase>
    with _$CardCacheDaoMixin {
  CardCacheDao(super.db);

  static const _cacheKey = 'cards_catalog';
  static const _staleDuration = Duration(hours: 24);

  /// Check if the card catalog cache is still fresh.
  Future<bool> isFresh() async {
    final meta = await (select(cacheMetadata)
          ..where((t) => t.key.equals(_cacheKey)))
        .getSingleOrNull();
    if (meta == null) return false;
    return DateTime.now().difference(meta.lastFetched) < _staleDuration;
  }

  /// Get all cached cards with their abilities.
  Future<List<CachedCardWithAbilities>> getAllCards() async {
    final cards = await select(cachedCards).get();
    final abilities = await select(cachedAbilities).get();

    final abilityMap = <String, List<CachedAbility>>{};
    for (final ability in abilities) {
      abilityMap.putIfAbsent(ability.cardId, () => []).add(ability);
    }

    return cards.map((card) {
      return CachedCardWithAbilities(
        card: card,
        abilities: abilityMap[card.id] ?? [],
      );
    }).toList();
  }

  /// Replace all cached cards and abilities with fresh data.
  Future<void> replaceAll({
    required List<CachedCardsCompanion> cards,
    required List<CachedAbilitiesCompanion> abilities,
  }) async {
    await transaction(() async {
      await delete(cachedAbilities).go();
      await delete(cachedCards).go();

      await batch((b) {
        b.insertAll(cachedCards, cards);
        b.insertAll(cachedAbilities, abilities);
      });

      await into(cacheMetadata).insertOnConflictUpdate(
        CacheMetadataCompanion(
          key: const Value(_cacheKey),
          lastFetched: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Invalidate the card cache.
  Future<void> invalidate() async {
    await (delete(cacheMetadata)
          ..where((t) => t.key.equals(_cacheKey)))
        .go();
  }
}

/// Combines a cached card with its abilities.
class CachedCardWithAbilities {
  const CachedCardWithAbilities({
    required this.card,
    required this.abilities,
  });

  final CachedCard card;
  final List<CachedAbility> abilities;
}
