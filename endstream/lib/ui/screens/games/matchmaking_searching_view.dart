import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';
import 'matchmaking_elapsed_time.dart';
import 'matchmaking_search_indicator.dart';

/// Main searching view: top bar, indicator, label, timer, cancel button.
class MatchmakingSearchingView extends StatelessWidget {
  const MatchmakingSearchingView({
    super.key,
    required this.elapsedSeconds,
    required this.onCancel,
  });

  final int elapsedSeconds;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MatchmakingTopBar(),
        const Spacer(),
        const MatchmakingSearchIndicator(),
        const SizedBox(height: 32),
        const _SearchingLabel(),
        const SizedBox(height: 16),
        MatchmakingElapsedTime(elapsedSeconds: elapsedSeconds),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
          child: SizedBox(
            width: double.infinity,
            child: TreeButton(
              label: 'CANCEL',
              variant: TreeButtonVariant.secondary,
              onPressed: onCancel,
            ),
          ),
        ),
      ],
    );
  }
}

class _MatchmakingTopBar extends StatelessWidget {
  const _MatchmakingTopBar();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'MATCHMAKING',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 2.0,
            color: TreeColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _SearchingLabel extends StatelessWidget {
  const _SearchingLabel();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'SEARCHING FOR OPPONENT',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 2.0,
        color: TreeColors.textSecondary,
      ),
    );
  }
}
