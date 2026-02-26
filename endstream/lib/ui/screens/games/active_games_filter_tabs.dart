import 'package:flutter/material.dart';

import 'active_games_tab.dart';

/// Filter tabs for game list: YOUR TURN, WAITING, COMPLETED.
class ActiveGamesFilterTabs extends StatelessWidget {
  const ActiveGamesFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.yourTurnCount,
    required this.waitingCount,
    required this.completedCount,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final int yourTurnCount;
  final int waitingCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ActiveGamesTab(
              label: 'YOUR TURN',
              isSelected: selectedIndex == 0,
              count: yourTurnCount,
              onTap: () => onSelected(0),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ActiveGamesTab(
              label: 'WAITING',
              isSelected: selectedIndex == 1,
              count: waitingCount,
              onTap: () => onSelected(1),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ActiveGamesTab(
              label: 'COMPLETED',
              isSelected: selectedIndex == 2,
              count: completedCount,
              onTap: () => onSelected(2),
            ),
          ),
        ],
      ),
    );
  }
}
