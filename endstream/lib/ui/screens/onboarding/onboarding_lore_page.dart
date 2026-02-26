import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Page 1: Lore introduction — "THE TIMELINE IS FRACTURED"
class OnboardingLorePage extends StatelessWidget {
  const OnboardingLorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'THE TIMELINE IS FRACTURED',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              color: TreeColors.activation,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'In the year 2600, temporal warfare has shattered '
            'the continuum. Rogue operators — time-traveling '
            'outlaws seeking redemption — fight across six '
            'centuries to restore what was broken.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: TreeColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'You are one of them.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: TreeColors.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
