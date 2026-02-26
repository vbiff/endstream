import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Friend profile header with avatar node, name, rank, and online indicator.
class FriendProfileHeader extends StatelessWidget {
  const FriendProfileHeader({
    super.key,
    required this.displayName,
    required this.rank,
    required this.isOnline,
  });

  final String displayName;
  final int rank;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TreeNode(
          size: 24,
          color: isOnline ? TreeColors.highlight : TreeColors.dormant,
          shape: TreeNodeShape.diamond,
        ),
        const SizedBox(height: 16),
        Text(
          displayName.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.0,
            color: TreeColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'RANK $rank',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            letterSpacing: 1.0,
            color: TreeColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        TreeBadge(
          text: isOnline ? 'ONLINE' : 'OFFLINE',
          color: isOnline ? TreeColors.highlight : TreeColors.dormant,
        ),
      ],
    );
  }
}
