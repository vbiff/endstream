import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/auth/auth_cubit.dart';
import '../../background/static_tree_background.dart';
import 'login_error_banner.dart';
import 'register_action_buttons.dart';
import 'register_form_fields.dart';
import 'register_header.dart';

/// Registration screen with email, display name, and password fields.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _localError;

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final email = _emailController.text.trim();
    final displayName = _displayNameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty ||
        displayName.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() => _localError = 'All fields are required');
      return;
    }
    if (password != confirmPassword) {
      setState(() => _localError = 'Passwords do not match');
      return;
    }
    if (password.length < 6) {
      setState(() => _localError = 'Password must be at least 6 characters');
      return;
    }

    setState(() => _localError = null);
    context.read<AuthCubit>().signUp(
          email: email,
          password: password,
          displayName: displayName,
        );
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
                      final serverError =
                          state is AuthError ? state.message : null;
                      final errorMessage = _localError ?? serverError;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const RegisterHeader(),
                          const SizedBox(height: 40),
                          if (errorMessage != null) ...[
                            LoginErrorBanner(message: errorMessage),
                            const SizedBox(height: 16),
                          ],
                          RegisterFormFields(
                            emailController: _emailController,
                            displayNameController: _displayNameController,
                            passwordController: _passwordController,
                            confirmPasswordController:
                                _confirmPasswordController,
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 24),
                          RegisterActionButtons(
                            onRegister: _handleRegister,
                            onSignIn: () => context.go('/login'),
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
