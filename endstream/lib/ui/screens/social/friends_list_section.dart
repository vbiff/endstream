import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/models.dart';
import '../../components/components.dart';

/// Section showing a list of friends with a header label.
class FriendsListSection extends StatelessWidget {
  const FriendsListSection({
    super.key,
    required this.label,
    required this.friends,
    required this.isOnline,
    required this.onTap,
  });

  final String label;
  final List<Player> friends;
  final bool isOnline;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    if (friends.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
              color: TreeColors.textSecondary,
            ),
          ),
        ),
        ...friends.map((f) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: FriendEntry(
                displayName: f.displayName,
                isOnline: isOnline,
                rank: f.rank,
                onTap: () => onTap(f.id),
              ),
            )),
      ],
    );
  }
}
