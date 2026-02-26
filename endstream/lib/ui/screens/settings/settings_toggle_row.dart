import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// A row with a label and a TreeToggle.
class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: TreeColors.textPrimary,
                  ),
            ),
            TreeToggle(value: value, onChanged: onChanged, label: label),
          ],
        ),
      ),
    );
  }
}
