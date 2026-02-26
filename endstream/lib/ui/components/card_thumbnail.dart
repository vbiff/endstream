import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/models/enums.dart';
import '../../core/models/game_card.dart';
import 'tree_badge.dart';
import 'tree_card.dart';

/// Mini card preview showing art placeholder, name, and cost badge.
class CardThumbnail extends StatelessWidget {
  const CardThumbnail({
    super.key,
    required this.card,
    this.onTap,
  });

  final GameCard card;
  final VoidCallback? onTap;

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
    return TreeCard(
      onTap: onTap,
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _CardArtPlaceholder(type: card.type),
              const SizedBox(height: 6),
              Text(
                card.name,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: TreeColors.textPrimary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: TreeBadge(
              text: '${card.cost}',
              color: _costColor(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardArtPlaceholder extends StatelessWidget {
  const _CardArtPlaceholder({required this.type});

  final CardType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: TreeColors.branchDefault,
        border: Border.all(
          color: TreeColors.dormant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        type.value.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: TreeColors.dormant,
            ),
      ),
    );
  }
}
