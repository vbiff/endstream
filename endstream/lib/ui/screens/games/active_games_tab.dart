import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Single filter tab with selection state and count badge.
class ActiveGamesTab extends StatelessWidget {
  const ActiveGamesTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.count,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? TreeColors.highlight : TreeColors.branchDefault,
              width: isSelected ? 2 : 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                letterSpacing: 1.0,
                color: isSelected
                    ? TreeColors.textPrimary
                    : TreeColors.textSecondary,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 4),
              TreeBadge(
                text: '$count',
                color: isSelected
                    ? TreeColors.activation
                    : TreeColors.dormant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
