import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Start game and cancel buttons.
class NewGameActionButtons extends StatelessWidget {
  const NewGameActionButtons({
    super.key,
    required this.canStart,
    required this.onStart,
    required this.onCancel,
  });

  final bool canStart;
  final VoidCallback onStart;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TreeButton(
            onPressed: canStart ? onStart : null,
            label: 'START GAME',
            enabled: canStart,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TreeButton(
            onPressed: onCancel,
            label: 'CANCEL',
            variant: TreeButtonVariant.secondary,
          ),
        ),
      ],
    );
  }
}
