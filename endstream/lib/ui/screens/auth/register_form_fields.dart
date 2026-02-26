import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Registration form fields.
class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({
    super.key,
    required this.emailController,
    required this.displayNameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.enabled,
  });

  final TextEditingController emailController;
  final TextEditingController displayNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
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
          controller: displayNameController,
          hint: 'DISPLAY NAME',
          enabled: enabled,
        ),
        const SizedBox(height: 12),
        TreeInput(
          controller: passwordController,
          hint: 'PASSWORD',
          obscureText: true,
          enabled: enabled,
        ),
        const SizedBox(height: 12),
        TreeInput(
          controller: confirmPasswordController,
          hint: 'CONFIRM PASSWORD',
          obscureText: true,
          enabled: enabled,
        ),
      ],
    );
  }
}
