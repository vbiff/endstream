import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Email and password input fields for login.
class LoginFormFields extends StatelessWidget {
  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.enabled,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TreeInput(
          controller: emailController,
          hint: 'EMAIL',
          enabled: enabled,
        ),
        const SizedBox(height: 12),
        TreeInput(
          controller: passwordController,
          hint: 'PASSWORD',
          obscureText: true,
          enabled: enabled,
        ),
      ],
    );
  }
}
