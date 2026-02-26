import 'package:flutter/material.dart';

import '../components/component_enums.dart';
import '../components/tree_button.dart';

/// Confirm and Cancel buttons shown during targeting state.
class TargetingActionButtons extends StatelessWidget {
  const TargetingActionButtons({
    super.key,
    required this.canConfirm,
    required this.onConfirm,
    required this.onCancel,
  });

  final bool canConfirm;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TreeButton(
              onPressed: canConfirm ? onConfirm : null,
              label: 'CONFIRM',
              variant: TreeButtonVariant.secondary,
              enabled: canConfirm,
            ),
          ),
          const SizedBox(width: 12),
          TreeButton(
            onPressed: onCancel,
            label: 'CANCEL',
            variant: TreeButtonVariant.danger,
          ),
        ],
      ),
    );
  }
}
