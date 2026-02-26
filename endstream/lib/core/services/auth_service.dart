import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/player.dart';

/// Abstract interface for authentication operations.
abstract class AuthService {
  /// Current auth user ID, or null if not signed in.
  String? get currentUserId;

  /// Stream of auth state changes.
  Stream<AuthState> get onAuthStateChange;

  /// Check if we have a valid session.
  bool get isAuthenticated;

  /// Sign up with email and password. Creates a player row.
  Future<Player> signUp({
    required String email,
    required String password,
    required String displayName,
  });

  /// Sign in with email and password.
  Future<Player> signIn({
    required String email,
    required String password,
  });

  /// Sign in with Google OAuth.
  Future<void> signInWithGoogle();

  /// Sign in with Apple.
  Future<void> signInWithApple();

  /// Sign out.
  Future<void> signOut();

  /// Get the current player profile from the database.
  Future<Player> getPlayerProfile();
}
