import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/action_point_bar.dart';
import '../../components/tree_badge.dart';
import 'turn_indicator_badge.dart';

/// Top bar displaying turn number, action points, and turn indicator.
class GameBoardTopBar extends StatelessWidget {
  const GameBoardTopBar({
    super.key,
    required this.turnNumber,
    required this.actionPoints,
    required this.maxActionPoints,
    required this.isMyTurn,
  });

  final int turnNumber;
  final int actionPoints;
  final int maxActionPoints;
  final bool isMyTurn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: TreeColors.surface,
        border: Border(
          bottom: BorderSide(color: TreeColors.branchDefault, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            TreeBadge(
              text: 'TURN $turnNumber',
              color: TreeColors.nodePoint,
            ),
            const SizedBox(width: 12),
            ActionPointBar(
              total: maxActionPoints,
              spent: maxActionPoints - actionPoints,
            ),
            const Spacer(),
            TurnIndicatorBadge(isMyTurn: isMyTurn),
          ],
        ),
      ),
    );
  }
}
