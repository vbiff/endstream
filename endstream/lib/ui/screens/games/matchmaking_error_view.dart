import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Error view with message and retry/cancel buttons.
class MatchmakingErrorView extends StatelessWidget {
  const MatchmakingErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    required this.onCancel,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TreeNode(
          size: 10,
          color: TreeColors.error,
          shape: TreeNodeShape.square,
        ),
        const SizedBox(height: 24),
        const Text(
          'MATCHMAKING ERROR',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 2.0,
            color: TreeColors.error,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: TreeColors.dormant,
            ),
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
