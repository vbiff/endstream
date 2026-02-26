import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Timeout view with retry and cancel buttons.
class MatchmakingTimeoutView extends StatelessWidget {
  const MatchmakingTimeoutView({
    super.key,
    required this.onRetry,
    required this.onCancel,
  });

  final VoidCallback onRetry;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TreeNode(
          size: 10,
          color: TreeColors.dormant,
          shape: TreeNodeShape.diamond,
        ),
        const SizedBox(height: 24),
        const Text(
          'NO OPPONENT FOUND',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 2.0,
            color: TreeColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Search timed out after 2 minutes',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: TreeColors.dormant,
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: TreeButton(
                  label: 'RETRY',
                  onPressed: onRetry,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TreeButton(
                  label: 'CANCEL',
                  variant: TreeButtonVariant.secondary,
                  onPressed: onCancel,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
