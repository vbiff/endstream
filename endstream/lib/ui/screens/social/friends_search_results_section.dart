import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/models.dart';
import '../../components/components.dart';

/// Section showing player search results with "ADD FRIEND" buttons.
class FriendsSearchResultsSection extends StatelessWidget {
  const FriendsSearchResultsSection({
    super.key,
    required this.results,
    required this.onAddFriend,
  });

  final List<Player> results;
  final ValueChanged<String> onAddFriend;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'SEARCH RESULTS',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
              color: TreeColors.textSecondary,
            ),
          ),
        ),
        ...results.map((player) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: _SearchResultItem(
                player: player,
                onAdd: () => onAddFriend(player.id),
              ),
            )),
        const SizedBox(height: 12),
        const TreeDivider(),
      ],
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({
    required this.player,
    required this.onAdd,
  });

  final Player player;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.displayName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: TreeColors.textPrimary,
                        fontFamily: 'monospace',
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'RANK ${player.rank}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TreeColors.textSecondary,
                        letterSpacing: 1.0,
                      ),
                ),
              ],
            ),
          ),
          TreeButton(
            onPressed: onAdd,
            label: 'ADD',
          ),
        ],
      ),
    );
  }
}
