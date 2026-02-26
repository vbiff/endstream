import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';

/// Placeholder stats card for friend profile.
class FriendProfileStats extends StatelessWidget {
  const FriendProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const TreeCard(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATS',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
              color: TreeColors.textSecondary,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Stats coming soon',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: TreeColors.dormant,
            ),
          ),
        ],
      ),
    );
  }
}
