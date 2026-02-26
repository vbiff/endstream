import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/tree_button.dart';

/// Error state with message and retry action.
class GameBoardErrorView extends StatelessWidget {
  const GameBoardErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CONNECTION LOST',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: TreeColors.error,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: TreeColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
            TreeButton(
              onPressed: onRetry,
              label: 'RETRY',
            ),
          ],
        ),
      ),
    );
  }
}
