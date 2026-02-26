import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/player.dart';

class AuthService {
  AuthService(this._client);
  final SupabaseClient _client;

  /// Current auth user ID, or null if not signed in.
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Stream of auth state changes.
  Stream<AuthState> get onAuthStateChange =>
      _client.auth.onAuthStateChange;

  /// Sign up with email and password. Creates a player row.
  Future<Player> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    final userId = response.user!.id;

    // Create player profile
    await _client.from('players').insert({
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

    final deckCards = (template as List).map((row) => {
          'deck_id': deckId,
          'card_id': row['card_id'],
          'quantity': row['quantity'],
        }).toList();

    await _client.from('deck_cards').insert(deckCards);

    return Player(
      id: userId,
      displayName: displayName,
    );
  }

  /// Sign in with email and password.
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

  /// Sign in with Google OAuth.
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.endstream://login-callback/',
    );
  }

  /// Sign in with Apple.
  Future<void> signInWithApple() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'io.supabase.endstream://login-callback/',
    );
  }

  /// Sign out.
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Get the current player profile from the database.
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

  /// Check if we have a valid session.
  bool get isAuthenticated => _client.auth.currentSession != null;
}
