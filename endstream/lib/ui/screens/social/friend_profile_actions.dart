import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Action buttons for friend profile: challenge and remove.
class FriendProfileActions extends StatelessWidget {
  const FriendProfileActions({
    super.key,
    required this.onChallenge,
    required this.onRemove,
  });

  final VoidCallback onChallenge;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TreeButton(
            onPressed: onChallenge,
            label: 'CHALLENGE',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TreeButton(
            onPressed: onRemove,
            label: 'REMOVE',
            variant: TreeButtonVariant.danger,
          ),
        ),
      ],
    );
  }
}
