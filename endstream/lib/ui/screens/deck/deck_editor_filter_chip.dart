import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Small tappable filter chip for card type filtering.
class DeckEditorFilterChip extends StatelessWidget {
  const DeckEditorFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? TreeColors.highlight : TreeColors.branchDefault,
          ),
          color: isSelected
              ? TreeColors.highlight.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            letterSpacing: 0.8,
            color: isSelected
                ? TreeColors.textPrimary
                : TreeColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
