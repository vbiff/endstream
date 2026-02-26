import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Page 4: Deck building — "YOUR DECK"
class OnboardingDeckPage extends StatelessWidget {
  const OnboardingDeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'YOUR DECK',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              color: TreeColors.activation,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '30 cards. Your strategy. Your timeline.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: TreeColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          const _CardTypeRow(
            type: 'OPERATOR',
            description: 'Units deployed to the board. They fight, move, and die.',
          ),
          const SizedBox(height: 16),
          const _CardTypeRow(
            type: 'TACTIC',
            description: 'One-time effects. Play and discard.',
          ),
          const SizedBox(height: 16),
          const _CardTypeRow(
            type: 'EVENT',
            description: 'Persistent effects that alter the timeline.',
          ),
          const SizedBox(height: 16),
          const _CardTypeRow(
            type: 'EQUIPMENT',
            description: 'Attachments that enhance your operators.',
          ),
        ],
      ),
    );
  }
}

class _CardTypeRow extends StatelessWidget {
  const _CardTypeRow({
    required this.type,
    required this.description,
  });

  final String type;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            type,
            style: textTheme.labelLarge?.copyWith(
              color: TreeColors.highlight,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: TreeColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
