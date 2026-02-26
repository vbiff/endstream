import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// Loading indicator shown while game state is being fetched.
class GameBoardLoadingView extends StatelessWidget {
  const GameBoardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 1,
          color: TreeColors.highlight,
        ),
      ),
    );
  }
}
