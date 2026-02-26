import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Page 2: Board mechanics — "THE BOARD"
class OnboardingMechanicsPage extends StatelessWidget {
  const OnboardingMechanicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'THE BOARD',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              color: TreeColors.activation,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Two parallel timelines. Six centuries each. '
            'A 2x6 grid where every position matters.',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: TreeColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          const _BoardDiagram(),
          const SizedBox(height: 24),
          Text(
            'Deploy your operators across the streams. '
            'Move them through time. Control the centuries.',
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

class _BoardDiagram extends StatelessWidget {
  const _BoardDiagram();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StreamRow(label: 'STREAM A'),
        const SizedBox(height: 4),
        _StreamRow(label: 'STREAM B'),
        const SizedBox(height: 8),
        _CenturyLabels(),
      ],
    );
  }
}

class _StreamRow extends StatelessWidget {
  const _StreamRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: TreeColors.dormant,
                ),
          ),
        ),
        ...List.generate(6, (index) {
          return Expanded(
            child: Container(
              height: 28,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                border: Border.all(
                  color: TreeColors.branchDefault,
                  width: 1,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _CenturyLabels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final centuries = ['2100', '2200', '2300', '2400', '2500', '2600'];

    return Row(
      children: [
        const SizedBox(width: 72),
        ...centuries.map((c) {
          return Expanded(
            child: Text(
              c,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: TreeColors.dormant,
                    fontSize: 9,
                  ),
            ),
          );
        }),
      ],
    );
  }
}
