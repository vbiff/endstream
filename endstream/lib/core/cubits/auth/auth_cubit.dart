import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthState, AuthChangeEvent;

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
      if (!isClosed) emit(AuthError(e.toString()));
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
      emit(AuthError(e.toString()));
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
      emit(AuthError(e.toString()));
    }
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Sign in with Apple.
  Future<void> signInWithApple() async {
    emit(const AuthLoading());
    try {
      await _authService.signInWithApple();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Sign out.
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
