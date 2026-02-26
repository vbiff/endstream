import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

class DeckService {
  DeckService(this._client);
  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  /// Fetch all decks for the current player.
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

      decks.add(Deck.fromJson({...row, 'cards': cardsData}).copyWith(cards: cards));
    }
    return decks;
  }

  /// Fetch a single deck with its cards.
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

  /// Create a new empty deck.
  Future<Deck> createDeck(String name) async {
    final data = await _client.from('decks').insert({
      'owner_id': _userId,
      'name': name,
    }).select().single();
    return Deck.fromJson(data);
  }

  /// Update a deck's card list. Replaces all deck_cards rows.
  Future<Deck> updateDeck(String deckId, List<DeckCard> cards) async {
    // Delete existing cards
    await _client.from('deck_cards').delete().eq('deck_id', deckId);

    // Insert new cards
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

    // Validate deck via Edge Function
    final isValid = await validateDeck(deckId);

    // Update deck metadata
    await _client.from('decks').update({
      'is_valid': isValid,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', deckId);

    return getDeck(deckId);
  }

  /// Rename a deck.
  Future<void> renameDeck(String deckId, String name) async {
    await _client.from('decks').update({
      'name': name,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', deckId);
  }

  /// Delete a deck.
  Future<void> deleteDeck(String deckId) async {
    await _client.from('deck_cards').delete().eq('deck_id', deckId);
    await _client.from('decks').delete().eq('id', deckId);
  }

  /// Validate a deck via Edge Function.
  Future<bool> validateDeck(String deckId) async {
    final response = await _client.functions.invoke(
      'validate-deck',
      body: {'deck_id': deckId},
    );
    final result = response.data as Map<String, dynamic>;
    return result['valid'] as bool;
  }

  /// Duplicate a deck.
  Future<Deck> duplicateDeck(String sourceDeckId, String newName) async {
    final source = await getDeck(sourceDeckId);
    final newDeck = await createDeck(newName);
    return updateDeck(newDeck.id, source.cards);
  }
}
