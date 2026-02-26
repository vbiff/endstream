import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Error display with message and retry button.
class ScreenErrorDisplay extends StatelessWidget {
  const ScreenErrorDisplay({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TreeNode(
              size: 12,
              color: TreeColors.error,
              shape: TreeNodeShape.diamond,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: TreeColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              TreeButton(
                onPressed: onRetry,
                label: 'RETRY',
                variant: TreeButtonVariant.danger,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
