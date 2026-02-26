import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Banner displayed at the top of the game board when an action fails.
class ActionErrorBanner extends StatelessWidget {
  const ActionErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: TreeColors.error.withValues(alpha: 0.15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: TreeColors.error,
                letterSpacing: 0.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
