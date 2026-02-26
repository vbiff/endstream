import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Text field styled as a branch segment.
class TreeInput extends StatelessWidget {
  const TreeInput({
    super.key,
    this.controller,
    this.hint,
    this.onSubmitted,
    this.onChanged,
    this.obscureText = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: enabled,
      cursorColor: TreeColors.highlight,
      cursorWidth: 1.0,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: TreeColors.textPrimary,
          ),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: TreeColors.surface,
      ),
    );
  }
}
