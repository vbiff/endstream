import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Single pending friend request with accept/decline buttons.
class FriendsPendingRequestItem extends StatelessWidget {
  const FriendsPendingRequestItem({
    super.key,
    required this.requesterId,
    required this.onAccept,
    required this.onDecline,
  });

  final String requesterId;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const TreeNode(size: 8, color: TreeColors.activation),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              requesterId.substring(0, 8).toUpperCase(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: TreeColors.textPrimary,
              ),
            ),
          ),
          TreeButton(
            onPressed: onAccept,
            label: 'ACCEPT',
          ),
          const SizedBox(width: 6),
          TreeButton(
            onPressed: onDecline,
            label: 'DECLINE',
            variant: TreeButtonVariant.danger,
          ),
        ],
      ),
    );
  }
}
