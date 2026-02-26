import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/models/operator_instance.dart';
import '../../core/models/turnpoint.dart';
import 'operator_token.dart';
import 'tree_badge.dart';
import 'tree_card.dart';
import 'tree_divider.dart';

/// Board cell representing a single century on a timeline stream.
class TurnpointCell extends StatelessWidget {
  const TurnpointCell({
    super.key,
    required this.century,
    required this.terrainType,
    this.operators = const [],
    this.effects = const [],
    this.isSelected = false,
    this.isValidTarget = false,
    this.onTap,
    this.onOperatorTap,
    this.isOpponent = false,
    this.selectedOperatorId,
  });

  final int century;
  final String terrainType;
  final List<OperatorInstance> operators;
  final List<TurnpointEffect> effects;
  final bool isSelected;
  final bool isValidTarget;
  final VoidCallback? onTap;
  final void Function(OperatorInstance)? onOperatorTap;
  final bool isOpponent;
  final String? selectedOperatorId;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      highlighted: isSelected || isValidTarget,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _CellHeader(
            century: century,
            terrainType: terrainType,
          ),
          const SizedBox(height: 6),
          const TreeDivider(),
          if (operators.isNotEmpty) ...[
            const SizedBox(height: 6),
            _OperatorList(
              operators: operators,
              onOperatorTap: onOperatorTap,
              isOpponent: isOpponent,
              selectedOperatorId: selectedOperatorId,
            ),
          ],
          if (effects.isNotEmpty) ...[
            const SizedBox(height: 6),
            _EffectBadges(effects: effects),
          ],
        ],
      ),
    );
  }
}

class _CellHeader extends StatelessWidget {
  const _CellHeader({
    required this.century,
    required this.terrainType,
  });

  final int century;
  final String terrainType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$century',
          style: textTheme.labelLarge?.copyWith(
            color: TreeColors.textPrimary,
          ),
        ),
        Text(
          terrainType.toUpperCase(),
          style: textTheme.labelSmall?.copyWith(
            color: TreeColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _OperatorList extends StatelessWidget {
  const _OperatorList({
    required this.operators,
    this.onOperatorTap,
    this.isOpponent = false,
    this.selectedOperatorId,
  });

  final List<OperatorInstance> operators;
  final void Function(OperatorInstance)? onOperatorTap;
  final bool isOpponent;
  final String? selectedOperatorId;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: operators.map((op) {
        return OperatorToken(
          name: op.operatorCardId,
          currentHp: op.currentHp,
          maxHp: op.maxHp,
          attack: op.attack,
          isOwn: !isOpponent,
          isSelected: op.operatorCardId == selectedOperatorId,
          onTap: onOperatorTap != null ? () => onOperatorTap!(op) : null,
        );
      }).toList(),
    );
  }
}

class _EffectBadges extends StatelessWidget {
  const _EffectBadges({required this.effects});

  final List<TurnpointEffect> effects;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: effects.map((effect) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: TreeBadge(
            text: effect.name,
            color: TreeColors.activation,
          ),
        );
      }).toList(),
    );
  }
}
