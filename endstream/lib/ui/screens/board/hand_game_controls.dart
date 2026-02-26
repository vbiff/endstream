import 'package:flutter/material.dart';

import '../../components/component_enums.dart';
import '../../components/tree_button.dart';

/// Bottom controls — End Turn and Concede buttons.
class HandGameControls extends StatelessWidget {
  const HandGameControls({
    super.key,
    required this.isMyTurn,
    required this.onEndTurn,
    required this.onConcede,
  });

  final bool isMyTurn;
  final VoidCallback onEndTurn;
  final VoidCallback onConcede;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: TreeButton(
              onPressed: isMyTurn ? onEndTurn : null,
              label: 'END TURN',
              enabled: isMyTurn,
            ),
          ),
          const SizedBox(width: 12),
          TreeButton(
            onPressed: onConcede,
            label: 'CONCEDE',
            variant: TreeButtonVariant.danger,
          ),
        ],
      ),
    );
  }
}
