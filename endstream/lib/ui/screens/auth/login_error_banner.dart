import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Error banner displayed above login form.
class LoginErrorBanner extends StatelessWidget {
  const LoginErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: TreeColors.error, width: 2),
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: TreeColors.error,
        ),
      ),
    );
  }
}
