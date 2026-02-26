import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/models.dart';
import '../deck_service.dart';

class SupabaseDeckService implements DeckService {
  SupabaseDeckService(this._client);
  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<List<Deck>> getDecks() async {
    final data = await _client
        .from('decks')
        .select()
        .eq('owner_id', _userId)
        .order('updated_at', ascending: false);

    final decks = <Deck>[];
    for (final row in data) {
      final deckId = row['id'] as String;
      final cardsData = await _client
          .from('deck_cards')
          .select()
          .eq('deck_id', deckId);
      final cards = (cardsData as List)
          .map((c) => DeckCard.fromJson(c))
          .toList();

      decks.add(Deck.fromJson(row).copyWith(cards: cards));
    }
    return decks;
  }

  @override
  Future<Deck> getDeck(String deckId) async {
    final row = await _client
        .from('decks')
        .select()
        .eq('id', deckId)
        .single();

    final cardsData = await _client
        .from('deck_cards')
        .select()
        .eq('deck_id', deckId);

    final cards =
        (cardsData as List).map((c) => DeckCard.fromJson(c)).toList();

    return Deck.fromJson(row).copyWith(cards: cards);
  }

  @override
  Future<Deck> createDeck(String name) async {
    final data = await _client.from('decks').insert({
      'owner_id': _userId,
      'name': name,
    }).select().single();
    return Deck.fromJson(data);
  }

  @override
  Future<({Deck deck, List<String> validationErrors})> updateDeck(
      String deckId, List<DeckCard> cards) async {
    await _client.from('deck_cards').delete().eq('deck_id', deckId);

    if (cards.isNotEmpty) {
      final rows = cards
          .map((c) => {
                'deck_id': deckId,
                'card_id': c.cardId,
                'quantity': c.quantity,
              })
          .toList();
      await _client.from('deck_cards').insert(rows);
    }

    final validation = await validateDeck(deckId);

    await _client.from('decks').update({
      'is_valid': validation.valid,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', deckId);

    final deck = await getDeck(deckId);
    return (deck: deck, validationErrors: validation.errors);
  }

  @override
  Future<void> renameDeck(String deckId, String name) async {
    await _client.from('decks').update({
      'name': name,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', deckId);
  }

  @override
  Future<void> deleteDeck(String deckId) async {
    await _client.from('deck_cards').delete().eq('deck_id', deckId);
    await _client.from('decks').delete().eq('id', deckId);
  }

  @override
  Future<({bool valid, List<String> errors})> validateDeck(String deckId) async {
    final response = await _client.functions.invoke(
      'validate-deck',
      body: {'deck_id': deckId},
    );
    final data = response.data;
    if (data is! Map<String, dynamic> || !data.containsKey('valid')) {
      return (valid: false, errors: ['Deck validation failed']);
    }
    return (
      valid: data['valid'] as bool,
      errors: (data['errors'] as List?)?.cast<String>() ?? [],
    );
  }

  @override
  Future<Deck> duplicateDeck(String sourceDeckId, String newName) async {
    final source = await getDeck(sourceDeckId);
    final newDeck = await createDeck(newName);
    final result = await updateDeck(newDeck.id, source.cards);
    return result.deck;
  }
}
