import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Sign in and create account buttons.
class LoginActionButtons extends StatelessWidget {
  const LoginActionButtons({
    super.key,
    required this.onSignIn,
    required this.onCreateAccount,
    required this.isLoading,
  });

  final VoidCallback onSignIn;
  final VoidCallback onCreateAccount;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TreeButton(
          onPressed: isLoading ? null : onSignIn,
          label: 'SIGN IN',
        ),
        const SizedBox(height: 12),
        TreeButton(
          onPressed: isLoading ? null : onCreateAccount,
          label: 'CREATE ACCOUNT',
          variant: TreeButtonVariant.secondary,
        ),
      ],
    );
  }
}
