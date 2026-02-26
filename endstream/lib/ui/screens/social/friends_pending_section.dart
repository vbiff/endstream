import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/models.dart';
import 'friends_pending_request_item.dart';

/// Section showing pending friend requests.
class FriendsPendingSection extends StatelessWidget {
  const FriendsPendingSection({
    super.key,
    required this.requests,
    required this.onAccept,
    required this.onDecline,
  });

  final List<Friendship> requests;
  final ValueChanged<String> onAccept;
  final ValueChanged<String> onDecline;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'PENDING REQUESTS',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
              color: TreeColors.textSecondary,
            ),
          ),
        ),
        ...requests.map((r) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: FriendsPendingRequestItem(
                requesterId: r.playerId,
                onAccept: () => onAccept(r.playerId),
                onDecline: () => onDecline(r.playerId),
              ),
            )),
        const SizedBox(height: 12),
      ],
    );
  }
}
