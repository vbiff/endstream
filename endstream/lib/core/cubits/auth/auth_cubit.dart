import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthApiException, AuthState, AuthChangeEvent;

import '../../models/player.dart';
import '../../services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(this._authService) : super(const AuthInitial()) {
    _authSubscription = _authService.onAuthStateChange.listen(_onAuthEvent);
  }

  final AuthService _authService;
  StreamSubscription<AuthState>? _authSubscription;
  bool _loadingProfile = false;

  void _onAuthEvent(AuthState authState) {
    if (isClosed) return;
    switch (authState.event) {
      case AuthChangeEvent.signedIn:
      case AuthChangeEvent.tokenRefreshed:
        _loadProfile();
      case AuthChangeEvent.signedOut:
        emit(const Unauthenticated());
      default:
        break;
    }
  }

  /// Check existing session on app start.
  Future<void> checkSession() async {
    if (_authService.isAuthenticated) {
      await _loadProfile();
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _loadProfile() async {
    if (_loadingProfile) return;
    _loadingProfile = true;
    try {
      final player = await _authService.getPlayerProfile();
      if (!isClosed) emit(Authenticated(player));
    } catch (e) {
      if (!isClosed) emit(AuthError(_friendlyError(e)));
    } finally {
      _loadingProfile = false;
    }
  }

  /// Sign in with email and password.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final player = await _authService.signIn(
        email: email,
        password: password,
      );
      emit(Authenticated(player));
    } catch (e) {
      emit(AuthError(_friendlyError(e)));
    }
  }

  /// Sign up with email, password, and display name.
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    emit(const AuthLoading());
    try {
      final player = await _authService.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      emit(Authenticated(player));
    } catch (e) {
      emit(AuthError(_friendlyError(e)));
    }
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      emit(AuthError(_friendlyError(e)));
    }
  }

  /// Sign in with Apple.
  Future<void> signInWithApple() async {
    emit(const AuthLoading());
    try {
      await _authService.signInWithApple();
    } catch (e) {
      emit(AuthError(_friendlyError(e)));
    }
  }

  /// Sign out.
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(_friendlyError(e)));
    }
  }

  String _friendlyError(Object e) {
    if (e is AuthApiException) {
      return switch (e.code) {
        'over_email_send_rate_limit' => 'Too many attempts. Please wait a moment and try again.',
        'user_already_exists' => 'An account with this email already exists.',
        'invalid_credentials' => 'Invalid email or password.',
        'email_not_confirmed' => 'Please confirm your email address first.',
        'user_not_found' => 'No account found with this email.',
        'weak_password' => 'Password is too weak. Use at least 6 characters.',
        _ => e.message,
      };
    }
    return 'Something went wrong. Please try again.';
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
