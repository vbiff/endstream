import 'package:flutter/material.dart';

import '../../../core/models/enums.dart';
import 'new_game_opponent_card.dart';

/// Opponent type selector: RANDOM, CHALLENGE FRIEND, PASS & PLAY.
class NewGameOpponentSelector extends StatelessWidget {
  const NewGameOpponentSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final OpponentType? selected;
  final ValueChanged<OpponentType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewGameOpponentCard(
          label: 'RANDOM',
          description: 'Match with a random opponent',
          isSelected: selected == OpponentType.random,
          onTap: () => onSelected(OpponentType.random),
        ),
        const SizedBox(height: 8),
        NewGameOpponentCard(
          label: 'CHALLENGE FRIEND',
          description: 'Send a challenge to a friend',
          isSelected: selected == OpponentType.friend,
          onTap: () => onSelected(OpponentType.friend),
        ),
        const SizedBox(height: 8),
        NewGameOpponentCard(
          label: 'PASS & PLAY',
          description: 'Local two-player on one device',
          isSelected: selected == OpponentType.local,
          onTap: () => onSelected(OpponentType.local),
        ),
      ],
    );
  }
}
