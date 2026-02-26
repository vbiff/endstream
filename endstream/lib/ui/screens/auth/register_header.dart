import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Register screen header.
class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'ENDSTREAM',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 28,
            fontWeight: FontWeight.w300,
            letterSpacing: 4.0,
            color: TreeColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Create Account',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            letterSpacing: 1.0,
            color: TreeColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
