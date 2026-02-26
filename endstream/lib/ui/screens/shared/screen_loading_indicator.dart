import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Centered loading indicator with animated branch and pulsing node.
class ScreenLoadingIndicator extends StatelessWidget {
  const ScreenLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TreeBranch(
            direction: TreeBranchDirection.vertical,
            length: 48,
            animated: true,
            color: TreeColors.branchActive,
          ),
          SizedBox(height: 12),
          TreeNode(
            size: 10,
            color: TreeColors.highlight,
            shape: TreeNodeShape.diamond,
          ),
          SizedBox(height: 12),
          Text(
            'LOADING',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              letterSpacing: 2.0,
              color: TreeColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
