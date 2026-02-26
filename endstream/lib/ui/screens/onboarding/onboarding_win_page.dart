import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Page 3: Victory conditions — "VICTORY CONDITIONS"
class OnboardingWinPage extends StatelessWidget {
  const OnboardingWinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'VICTORY CONDITIONS',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              color: TreeColors.activation,
            ),
          ),
          const SizedBox(height: 32),
          const _WinConditionItem(
            number: '01',
            title: 'ELIMINATION',
            description: 'Destroy all enemy operators on the board.',
          ),
          const SizedBox(height: 24),
          const _WinConditionItem(
            number: '02',
            title: 'DECAPITATION',
            description: 'Destroy the enemy AI Controller to collapse '
                'their entire timeline.',
          ),
          const SizedBox(height: 32),
          Text(
            'Protect your Controller. Eliminate the threat.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: TreeColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _WinConditionItem extends StatelessWidget {
  const _WinConditionItem({
    required this.number,
    required this.title,
    required this.description,
  });

  final String number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: textTheme.headlineLarge?.copyWith(
            color: TreeColors.highlight,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: TreeColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: textTheme.bodyMedium?.copyWith(
                  color: TreeColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
