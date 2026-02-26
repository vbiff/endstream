import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/player.dart';
import '../auth_service.dart';

class SupabaseAuthService implements AuthService {
  SupabaseAuthService(this._client);
  final SupabaseClient _client;

  @override
  String? get currentUserId => _client.auth.currentUser?.id;

  @override
  Stream<AuthState> get onAuthStateChange =>
      _client.auth.onAuthStateChange;

  @override
  bool get isAuthenticated => _client.auth.currentSession != null;

  @override
  Future<Player> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) {
      throw StateError('Sign-up failed: no user returned');
    }
    final userId = user.id;

    // Update player profile created by the on_auth_user_created trigger
    await _client.from('players').upsert({
      'id': userId,
      'display_name': displayName,
    });

    // Create starter deck for the player
    final deckResponse = await _client.from('decks').insert({
      'owner_id': userId,
      'name': 'Starter Deck',
      'is_valid': true,
    }).select('id').single();

    final deckId = deckResponse['id'] as String;

    // Copy starter deck template
    final template = await _client
        .from('starter_deck_template')
        .select('card_id, quantity');

    if ((template as List).isNotEmpty) {
      final deckCards = template.map((row) => {
            'deck_id': deckId,
            'card_id': row['card_id'],
            'quantity': row['quantity'],
          }).toList();

      await _client.from('deck_cards').insert(deckCards);
    }

    return Player(
      id: userId,
      displayName: displayName,
    );
  }

  @override
  Future<Player> signIn({
    required String email,
    required String password,
  }) async {
    await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return getPlayerProfile();
  }

  @override
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.endstream://login-callback/',
    );
  }

  @override
  Future<void> signInWithApple() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'io.supabase.endstream://login-callback/',
    );
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<Player> getPlayerProfile() async {
    final userId = currentUserId;
    if (userId == null) throw StateError('Not authenticated');

    final data = await _client
        .from('players')
        .select()
        .eq('id', userId)
        .single();
    return Player.fromJson(data);
  }
}
