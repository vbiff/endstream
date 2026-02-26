import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/tree_button.dart';
import '../../components/tree_card.dart';

/// Game over overlay — shows win/loss result and exit action.
class GameOverView extends StatelessWidget {
  const GameOverView({
    super.key,
    required this.isWinner,
    required this.onExit,
  });

  final bool isWinner;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xB3000000),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TreeCard(
            highlighted: true,
            highlightColor:
                isWinner ? TreeColors.activation : TreeColors.error,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _GameOverTitle(isWinner: isWinner),
                const SizedBox(height: 8),
                _GameOverSubtitle(isWinner: isWinner),
                const SizedBox(height: 24),
                TreeButton(
                  onPressed: onExit,
                  label: 'EXIT',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GameOverTitle extends StatelessWidget {
  const _GameOverTitle({required this.isWinner});

  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Text(
      isWinner ? 'VICTORY' : 'DEFEAT',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: isWinner ? TreeColors.activation : TreeColors.error,
          ),
    );
  }
}

class _GameOverSubtitle extends StatelessWidget {
  const _GameOverSubtitle({required this.isWinner});

  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Text(
      isWinner
          ? 'The timeline is restored.'
          : 'The timeline has collapsed.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: TreeColors.textSecondary,
          ),
    );
  }
}
