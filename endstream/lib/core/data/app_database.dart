import 'package:drift/drift.dart';

import 'daos/card_cache_dao.dart';
import 'daos/deck_cache_dao.dart';

part 'app_database.g.dart';

/// Cached cards table — mirrors the Supabase `cards` table.
class CachedCards extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get cost => integer().withDefault(const Constant(0))();
  TextColumn get rarity => text().withDefault(const Constant('common'))();
  TextColumn get cardText => text().nullable()();
  TextColumn get flavorText => text().nullable()();
  TextColumn get artAssetPath => text().nullable()();
  IntColumn get hp => integer().nullable()();
  IntColumn get attack => integer().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cached abilities table — mirrors the Supabase `abilities` table.
class CachedAbilities extends Table {
  TextColumn get id => text()();
  TextColumn get cardId => text().references(CachedCards, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get cost => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cached decks table — mirrors the Supabase `decks` table.
class CachedDecks extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text()();
  TextColumn get name => text()();
  BoolColumn get isValid => boolean().withDefault(const Constant(false))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cached deck_cards table — mirrors the Supabase `deck_cards` table.
class CachedDeckCards extends Table {
  TextColumn get deckId => text().references(CachedDecks, #id)();
  TextColumn get cardId => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {deckId, cardId};
}

/// Cache metadata table — tracks staleness per data type.
class CacheMetadata extends Table {
  TextColumn get key => text()();
  DateTimeColumn get lastFetched => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    CachedCards,
    CachedAbilities,
    CachedDecks,
    CachedDeckCards,
    CacheMetadata,
  ],
  daos: [CardCacheDao, DeckCacheDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
