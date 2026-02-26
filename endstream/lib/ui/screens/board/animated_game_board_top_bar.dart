import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/animated_action_point_bar.dart';
import '../../components/tree_badge.dart';
import 'turn_indicator_badge.dart';

/// Top bar using [AnimatedActionPointBar] for staggered AP pulse on turn start.
class AnimatedGameBoardTopBar extends StatelessWidget {
  const AnimatedGameBoardTopBar({
    super.key,
    required this.turnNumber,
    required this.actionPoints,
    required this.maxActionPoints,
    required this.isMyTurn,
    this.onBack,
  });

  final int turnNumber;
  final int actionPoints;
  final int maxActionPoints;
  final bool isMyTurn;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Turn $turnNumber, $actionPoints of $maxActionPoints action points, ${isMyTurn ? "your turn" : "opponent turn"}',
      child: Container(
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
            if (onBack != null) ...[
              GestureDetector(
                onTap: onBack,
                child: const Text(
                  '<',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 18,
                    color: TreeColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            TreeBadge(
              text: 'TURN $turnNumber',
              color: TreeColors.nodePoint,
            ),
            const SizedBox(width: 12),
            AnimatedActionPointBar(
              total: maxActionPoints,
              spent: maxActionPoints - actionPoints,
              isMyTurn: isMyTurn,
            ),
            const Spacer(),
            TurnIndicatorBadge(isMyTurn: isMyTurn),
          ],
        ),
      ),
      ),
    );
  }
}
