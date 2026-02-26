part of 'auth_cubit.dart';

sealed class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthCubitState {
  const AuthInitial();
}

final class AuthLoading extends AuthCubitState {
  const AuthLoading();
}

final class Authenticated extends AuthCubitState {
  const Authenticated(this.player);
  final Player player;

  @override
  List<Object?> get props => [player.id];
}

final class Unauthenticated extends AuthCubitState {
  const Unauthenticated();
}

final class AuthError extends AuthCubitState {
  const AuthError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
