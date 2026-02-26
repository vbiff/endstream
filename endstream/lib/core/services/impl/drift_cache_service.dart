import 'package:drift/drift.dart';

import '../../data/app_database.dart';
import '../../data/daos/card_cache_dao.dart';
import '../../data/daos/deck_cache_dao.dart';
import '../../models/models.dart';
import '../cache_service.dart';

class DriftCacheService implements CacheService {
  DriftCacheService(this._db);

  final AppDatabase _db;

  CardCacheDao get _cardDao => _db.cardCacheDao;
  DeckCacheDao get _deckDao => _db.deckCacheDao;

  @override
  Future<List<GameCard>?> getCachedCards() async {
    if (!await _cardDao.isFresh()) return null;

    final cached = await _cardDao.getAllCards();
    if (cached.isEmpty) return null;

    return cached.map(_toGameCard).toList();
  }

  @override
  Future<void> cacheCards(List<GameCard> cards) async {
    final cardCompanions = <CachedCardsCompanion>[];
    final abilityCompanions = <CachedAbilitiesCompanion>[];

    for (final card in cards) {
      cardCompanions.add(CachedCardsCompanion(
        id: Value(card.id),
        name: Value(card.name),
        type: Value(card.type.value),
        cost: Value(card.cost),
        rarity: Value(card.rarity.value),
        cardText: Value(card.text),
        flavorText: Value(card.flavorText),
        artAssetPath: Value(card.artAssetPath),
        hp: Value(card.hp),
        attack: Value(card.attack),
        cachedAt: Value(DateTime.now()),
      ));

      for (final ability in card.abilities) {
        abilityCompanions.add(CachedAbilitiesCompanion(
          id: Value(ability.id),
          cardId: Value(card.id),
          name: Value(ability.name),
          description: Value(ability.description),
          cost: Value(ability.cost),
        ));
      }
    }

    await _cardDao.replaceAll(
      cards: cardCompanions,
      abilities: abilityCompanions,
    );
  }

  @override
  Future<void> invalidateCards() async {
    await _cardDao.invalidate();
  }

  @override
  Future<List<Deck>?> getCachedDecks() async {
    if (!await _deckDao.isFresh()) return null;

    final cached = await _deckDao.getAllDecks();
    if (cached.isEmpty) return null;

    return cached.map(_toDeck).toList();
  }

  @override
  Future<void> cacheDecks(List<Deck> decks) async {
    final deckCompanions = <CachedDecksCompanion>[];
    final deckCardCompanions = <CachedDeckCardsCompanion>[];

    for (final deck in decks) {
      deckCompanions.add(CachedDecksCompanion(
        id: Value(deck.id),
        ownerId: Value(deck.ownerId),
        name: Value(deck.name),
        isValid: Value(deck.isValid),
        cachedAt: Value(DateTime.now()),
      ));

      for (final card in deck.cards) {
        deckCardCompanions.add(CachedDeckCardsCompanion(
          deckId: Value(deck.id),
          cardId: Value(card.cardId),
          quantity: Value(card.quantity),
        ));
      }
    }

    await _deckDao.replaceAll(
      decks: deckCompanions,
      deckCards: deckCardCompanions,
    );
  }

  @override
  Future<void> invalidateDecks() async {
    await _deckDao.invalidate();
  }

  // ── Mapping helpers ──

  GameCard _toGameCard(CachedCardWithAbilities cached) {
    return GameCard(
      id: cached.card.id,
      name: cached.card.name,
      type: CardType.values.firstWhere(
        (t) => t.value == cached.card.type,
        orElse: () => CardType.tactic,
      ),
      cost: cached.card.cost,
      rarity: Rarity.values.firstWhere(
        (r) => r.value == cached.card.rarity,
        orElse: () => Rarity.common,
      ),
      text: cached.card.cardText,
      flavorText: cached.card.flavorText,
      artAssetPath: cached.card.artAssetPath,
      hp: cached.card.hp,
      attack: cached.card.attack,
      abilities: cached.abilities
          .map((a) => Ability(
                id: a.id,
                cardId: a.cardId,
                name: a.name,
                description: a.description,
                cost: a.cost,
              ))
          .toList(),
    );
  }

  Deck _toDeck(CachedDeckWithCards cached) {
    return Deck(
      id: cached.deck.id,
      ownerId: cached.deck.ownerId,
      name: cached.deck.name,
      isValid: cached.deck.isValid,
      cards: cached.cards
          .map((c) => DeckCard(
                cardId: c.cardId,
                quantity: c.quantity,
              ))
          .toList(),
    );
  }
}
