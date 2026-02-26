import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Formatted MM:SS timer display for matchmaking.
class MatchmakingElapsedTime extends StatelessWidget {
  const MatchmakingElapsedTime({
    super.key,
    required this.elapsedSeconds,
  });

  final int elapsedSeconds;

  String get _formatted {
    final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatted,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 28,
        fontWeight: FontWeight.w300,
        letterSpacing: 4.0,
        color: TreeColors.textSecondary,
      ),
    );
  }
}
