import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Selectable opponent type card.
class NewGameOpponentCard extends StatelessWidget {
  const NewGameOpponentCard({
    super.key,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      onTap: onTap,
      highlighted: isSelected,
      highlightColor: TreeColors.activation,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          TreeNode(
            size: 8,
            color: isSelected ? TreeColors.activation : TreeColors.dormant,
            shape: isSelected ? TreeNodeShape.diamond : TreeNodeShape.square,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    letterSpacing: 1.0,
                    color: isSelected
                        ? TreeColors.textPrimary
                        : TreeColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: TreeColors.dormant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
