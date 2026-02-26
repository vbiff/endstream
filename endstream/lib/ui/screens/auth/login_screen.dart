import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/auth/auth_cubit.dart';
import '../../background/static_tree_background.dart';
import 'login_action_buttons.dart';
import 'login_error_banner.dart';
import 'login_form_fields.dart';
import 'login_header.dart';
import 'login_oauth_section.dart';

/// Login screen with email/password and OAuth sign-in.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) return;
    context.read<AuthCubit>().signIn(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TreeColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const StaticTreeBackground(),
          BlocListener<AuthCubit, AuthCubitState>(
            listenWhen: (previous, current) => current is Authenticated,
            listener: (context, state) {
              if (state is Authenticated) {
                context.go('/hub');
              }
            },
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: BlocBuilder<AuthCubit, AuthCubitState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      final errorMessage =
                          state is AuthError ? state.message : null;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const LoginHeader(),
                          const SizedBox(height: 40),
                          if (errorMessage != null) ...[
                            LoginErrorBanner(message: errorMessage),
                            const SizedBox(height: 16),
                          ],
                          LoginFormFields(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 24),
                          LoginActionButtons(
                            onSignIn: _handleSignIn,
                            onCreateAccount: () => context.go('/register'),
                            isLoading: isLoading,
                          ),
                          const SizedBox(height: 24),
                          LoginOAuthSection(
                            onGoogle: () =>
                                context.read<AuthCubit>().signInWithGoogle(),
                            onApple: () =>
                                context.read<AuthCubit>().signInWithApple(),
                            isLoading: isLoading,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
