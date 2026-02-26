import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/enums.dart';
import '../../../core/models/game_card.dart';
import '../../components/tree_badge.dart';
import '../../components/tree_card.dart';

/// Single card in the hand list — shows name, type, cost, and selection state.
class HandCardItem extends StatelessWidget {
  const HandCardItem({
    super.key,
    required this.card,
    required this.isSelected,
    required this.isPlayable,
    this.onTap,
    this.onLongPress,
  });

  final GameCard card;
  final bool isSelected;
  final bool isPlayable;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  Color _costColor() {
    switch (card.type) {
      case CardType.operatorCard:
        return TreeColors.highlight;
      case CardType.tactic:
        return TreeColors.activation;
      case CardType.event:
        return TreeColors.nodePoint;
      case CardType.equipment:
        return TreeColors.dormant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onLongPress: onLongPress,
      child: TreeCard(
        highlighted: isSelected,
        highlightColor: isSelected ? TreeColors.activation : null,
        onTap: isPlayable ? onTap : null,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            _CardTypeIndicator(type: card.type),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    card.name,
                    style: textTheme.labelLarge?.copyWith(
                      color: isPlayable
                          ? TreeColors.textPrimary
                          : TreeColors.dormant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    card.type.value.toUpperCase(),
                    style: textTheme.labelSmall?.copyWith(
                      color: TreeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            TreeBadge(
              text: '${card.cost}',
              color: _costColor(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small square showing card type via color-coded indicator.
class _CardTypeIndicator extends StatelessWidget {
  const _CardTypeIndicator({required this.type});

  final CardType type;

  Color _color() {
    switch (type) {
      case CardType.operatorCard:
        return TreeColors.highlight;
      case CardType.tactic:
        return TreeColors.activation;
      case CardType.event:
        return TreeColors.nodePoint;
      case CardType.equipment:
        return TreeColors.dormant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: TreeColors.branchDefault,
        border: Border.all(color: _color(), width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        type.value[0].toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _color(),
            ),
      ),
    );
  }
}
