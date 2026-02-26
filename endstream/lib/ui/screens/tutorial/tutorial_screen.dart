import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/tutorial/tutorial_bloc.dart';
import '../board/game_board_loading_view.dart';
import 'tutorial_board_view.dart';
import 'tutorial_complete_view.dart';

/// Root screen for the guided tutorial game.
class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TutorialBloc()..add(const StartTutorial()),
      child: Scaffold(
        backgroundColor: TreeColors.background,
        body: BlocBuilder<TutorialBloc, TutorialState>(
          builder: (context, state) {
            return switch (state) {
              TutorialInitial() => const GameBoardLoadingView(),
              TutorialInProgress() => TutorialBoardView(state: state),
              TutorialComplete() => const TutorialCompleteView(),
            };
          },
        ),
      ),
    );
  }
}
