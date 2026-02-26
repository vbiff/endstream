import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/models.dart';
import '../cache_service.dart';
import '../card_service.dart';

class SupabaseCardService implements CardService {
  SupabaseCardService(this._client, {this.cacheService});
  final SupabaseClient _client;
  final CacheService? cacheService;

  @override
  Future<List<GameCard>> getAllCards() async {
    // Try cache first
    if (cacheService != null) {
      final cached = await cacheService!.getCachedCards();
      if (cached != null) return cached;
    }

    // Fetch from Supabase
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .order('type')
        .order('cost');
    final cards =
        (data as List).map((row) => GameCard.fromJson(row)).toList();

    // Update cache
    if (cacheService != null) {
      await cacheService!.cacheCards(cards);
    }

    return cards;
  }

  @override
  Future<GameCard> getCard(String cardId) async {
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .eq('id', cardId)
        .single();
    return GameCard.fromJson(data);
  }

  @override
  Future<List<GameCard>> getCardsByType(CardType type) async {
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .eq('type', type.value)
        .order('cost');
    return (data as List).map((row) => GameCard.fromJson(row)).toList();
  }

  @override
  Future<List<GameCard>> getCardsByIds(List<String> cardIds) async {
    if (cardIds.isEmpty) return [];
    final data = await _client
        .from('cards')
        .select('*, abilities(*)')
        .inFilter('id', cardIds);
    return (data as List).map((row) => GameCard.fromJson(row)).toList();
  }
}
