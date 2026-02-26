import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Register and sign-in link buttons.
class RegisterActionButtons extends StatelessWidget {
  const RegisterActionButtons({
    super.key,
    required this.onRegister,
    required this.onSignIn,
    required this.isLoading,
  });

  final VoidCallback onRegister;
  final VoidCallback onSignIn;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TreeButton(
          onPressed: isLoading ? null : onRegister,
          label: 'REGISTER',
        ),
        const SizedBox(height: 12),
        TreeButton(
          onPressed: isLoading ? null : onSignIn,
          label: 'SIGN IN',
          variant: TreeButtonVariant.secondary,
        ),
      ],
    );
  }
}
