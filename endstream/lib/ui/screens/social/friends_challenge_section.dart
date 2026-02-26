import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/models.dart';
import '../../components/components.dart';

/// Section showing incoming challenges with Accept/Decline buttons.
class FriendsChallengeSection extends StatelessWidget {
  const FriendsChallengeSection({
    super.key,
    required this.challenges,
    required this.onAccept,
    required this.onDecline,
  });

  final List<Challenge> challenges;
  final void Function(Challenge challenge) onAccept;
  final void Function(Challenge challenge) onDecline;

  @override
  Widget build(BuildContext context) {
    if (challenges.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'INCOMING CHALLENGES',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
              color: TreeColors.activation,
            ),
          ),
        ),
        ...challenges.map((c) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: _ChallengeItem(
                challenge: c,
                onAccept: () => onAccept(c),
                onDecline: () => onDecline(c),
              ),
            )),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _ChallengeItem extends StatelessWidget {
  const _ChallengeItem({
    required this.challenge,
    required this.onAccept,
    required this.onDecline,
  });

  final Challenge challenge;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CHALLENGE FROM',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TreeColors.textSecondary,
                        letterSpacing: 1.0,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  challenge.fromPlayerId.substring(0, 8).toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: TreeColors.textPrimary,
                        fontFamily: 'monospace',
                      ),
                ),
              ],
            ),
          ),
          TreeButton(
            onPressed: onAccept,
            label: 'ACCEPT',
          ),
          const SizedBox(width: 8),
          TreeButton(
            onPressed: onDecline,
            label: 'DECLINE',
            variant: TreeButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}
