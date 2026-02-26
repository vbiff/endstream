import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

class CardService {
  CardService(this._client);
  final SupabaseClient _client;

  /// Fetch all cards in the catalog with their abilities.
  Future<List<GameCard>> getAllCards() async {
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .order('type')
        .order('cost');
    return (data as List).map((row) => GameCard.fromJson(row)).toList();
  }

  /// Fetch a single card by ID with abilities.
  Future<GameCard> getCard(String cardId) async {
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .eq('id', cardId)
        .single();
    return GameCard.fromJson(data);
  }

  /// Fetch cards filtered by type.
  Future<List<GameCard>> getCardsByType(CardType type) async {
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .eq('type', type.value)
        .order('cost');
    return (data as List).map((row) => GameCard.fromJson(row)).toList();
  }

  /// Fetch cards by a list of IDs.
  Future<List<GameCard>> getCardsByIds(List<String> cardIds) async {
    if (cardIds.isEmpty) return [];
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .inFilter('id', cardIds);
    return (data as List).map((row) => GameCard.fromJson(row)).toList();
  }
}
