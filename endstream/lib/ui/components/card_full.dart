import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/models/enums.dart';
import '../../core/models/game_card.dart';
import 'tree_badge.dart';
import 'tree_card.dart';
import 'tree_divider.dart';

/// Full card detail view with stats, abilities, and flavor text.
class CardFull extends StatelessWidget {
  const CardFull({
    super.key,
    required this.card,
  });

  final GameCard card;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TreeCard(
      highlighted: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _CardHeader(card: card),
          const SizedBox(height: 8),
          _CardTypeBadges(card: card),
          const SizedBox(height: 8),
          _CardArtArea(type: card.type),
          const SizedBox(height: 8),
          const TreeDivider(),
          if (card.type == CardType.operatorCard &&
              (card.hp != null || card.attack != null)) ...[
            const SizedBox(height: 8),
            _CardStatsRow(hp: card.hp, attack: card.attack),
            const SizedBox(height: 8),
          ],
          if (card.text != null && card.text!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              card.text!,
              style: textTheme.bodyMedium?.copyWith(
                color: TreeColors.textPrimary,
              ),
            ),
          ],
          if (card.abilities.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...card.abilities.map(
              (ability) => _CardAbilityRow(
                name: ability.name,
                cost: ability.cost,
                description: ability.description,
              ),
            ),
          ],
          if (card.flavorText != null && card.flavorText!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              card.flavorText!,
              style: textTheme.labelSmall?.copyWith(
                color: TreeColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.card});

  final GameCard card;

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
    return Row(
      children: [
        Expanded(
          child: Text(
            card.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: TreeColors.textPrimary,
                ),
          ),
        ),
        TreeBadge(text: '${card.cost}', color: _costColor()),
      ],
    );
  }
}

class _CardTypeBadges extends StatelessWidget {
  const _CardTypeBadges({required this.card});

  final GameCard card;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TreeBadge(
          text: card.type.value.toUpperCase(),
          color: TreeColors.dormant,
        ),
        const SizedBox(width: 6),
        TreeBadge(
          text: card.rarity.value.toUpperCase(),
          color: TreeColors.nodePoint,
        ),
      ],
    );
  }
}

class _CardArtArea extends StatelessWidget {
  const _CardArtArea({required this.type});

  final CardType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: TreeColors.dormant,
            ),
      ),
    );
  }
}

class _CardStatsRow extends StatelessWidget {
  const _CardStatsRow({this.hp, this.attack});

  final int? hp;
  final int? attack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hp != null)
          _CardStatDisplay(label: 'HP', value: hp!, color: TreeColors.highlight),
        if (hp != null && attack != null) const SizedBox(width: 16),
        if (attack != null)
          _CardStatDisplay(
              label: 'ATK', value: attack!, color: TreeColors.error),
      ],
    );
  }
}

class _CardStatDisplay extends StatelessWidget {
  const _CardStatDisplay({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(color: TreeColors.textSecondary),
        ),
        const SizedBox(width: 4),
        Text(
          '$value',
          style: textTheme.titleMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}

class _CardAbilityRow extends StatelessWidget {
  const _CardAbilityRow({
    required this.name,
    required this.cost,
    this.description,
  });

  final String name;
  final int cost;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                name,
                style: textTheme.labelLarge?.copyWith(
                  color: TreeColors.activation,
                ),
              ),
              const SizedBox(width: 6),
              TreeBadge(text: '$cost AP', color: TreeColors.activation),
            ],
          ),
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              description!,
              style: textTheme.bodyMedium?.copyWith(
                color: TreeColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
