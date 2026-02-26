import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Brief "OPPONENT FOUND" confirmation view with activation-yellow diamond.
class MatchmakingMatchedView extends StatelessWidget {
  const MatchmakingMatchedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TreeNode(
          size: 14,
          color: TreeColors.activation,
          shape: TreeNodeShape.diamond,
        ),
        SizedBox(height: 24),
        Text(
          'OPPONENT FOUND',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 2.0,
            color: TreeColors.activation,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'CONNECTING...',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
            color: TreeColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
