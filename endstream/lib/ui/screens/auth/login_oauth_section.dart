import 'package:flutter/material.dart';

import '../../components/components.dart';

/// OAuth sign-in buttons (Google, Apple) with divider.
class LoginOAuthSection extends StatelessWidget {
  const LoginOAuthSection({
    super.key,
    required this.onGoogle,
    required this.onApple,
    required this.isLoading,
  });

  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TreeDivider(),
        const SizedBox(height: 16),
        TreeButton(
          onPressed: isLoading ? null : onGoogle,
          label: 'GOOGLE',
          variant: TreeButtonVariant.secondary,
        ),
        const SizedBox(height: 12),
        TreeButton(
          onPressed: isLoading ? null : onApple,
          label: 'APPLE',
          variant: TreeButtonVariant.secondary,
        ),
      ],
    );
  }
}
