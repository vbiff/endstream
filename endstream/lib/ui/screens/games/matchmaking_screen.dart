import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/cubits/games/matchmaking_cubit.dart';
import 'matchmaking_error_view.dart';
import 'matchmaking_matched_view.dart';
import 'matchmaking_searching_view.dart';
import 'matchmaking_timeout_view.dart';

/// Main matchmaking screen — dispatches to subviews based on state.
class MatchmakingScreen extends StatelessWidget {
  const MatchmakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MatchmakingCubit, MatchmakingState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is MatchmakingMatched) {
              context.go('/games/${state.gameId}');
            } else if (state is MatchmakingCancelled) {
              context.pop();
            }
          },
          builder: (context, state) {
            return switch (state) {
              MatchmakingSearching(:final elapsedSeconds) =>
                MatchmakingSearchingView(
                  elapsedSeconds: elapsedSeconds,
                  onCancel: () =>
                      context.read<MatchmakingCubit>().cancelSearch(),
                ),
              MatchmakingMatched() => const MatchmakingMatchedView(),
              MatchmakingTimeout() => MatchmakingTimeoutView(
                  onRetry: () =>
                      context.read<MatchmakingCubit>().retrySearch(),
                  onCancel: () =>
                      context.read<MatchmakingCubit>().cancelSearch(),
                ),
              MatchmakingError(:final message) => MatchmakingErrorView(
                  message: message,
                  onRetry: () =>
                      context.read<MatchmakingCubit>().retrySearch(),
                  onCancel: () =>
                      context.read<MatchmakingCubit>().cancelSearch(),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
