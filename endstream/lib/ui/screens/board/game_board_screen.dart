import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/games/game_board_bloc.dart';
import 'animated_game_over_view.dart';
import 'game_board_body.dart';
import 'game_board_error_view.dart';
import 'game_board_loading_view.dart';

/// Root screen for the game board — dispatches to sub-views based on BLoC state.
class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key, required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TreeColors.background,
      body: BlocBuilder<GameBoardBloc, GameBoardState>(
        builder: (context, state) {
          return switch (state) {
            GameBoardInitial() || GameBoardLoading() =>
              const GameBoardLoadingView(),
            GameBoardError(:final message) => GameBoardErrorView(
                message: message,
                onRetry: () =>
                    context.read<GameBoardBloc>().add(LoadGame(gameId)),
              ),
            GameBoardLoaded(
              :final gameState,
              :final selection,
              :final isMyTurn,
              :final isSubmitting,
              :final actionError,
            ) =>
              GameBoardBody(
                gameState: gameState,
                selection: selection,
                isMyTurn: isMyTurn,
                isSubmitting: isSubmitting,
                actionError: actionError,
              ),
            GameBoardGameOver(:final gameState, :final winnerId) => Stack(
                children: [
                  GameBoardBody(
                    gameState: gameState,
                    selection: const NoneSelected(),
                    isMyTurn: false,
                  ),
                  AnimatedGameOverView(
                    isWinner: winnerId == gameState.myPlayerId,
                    gameState: gameState,
                    onRematch: gameState.opponentPlayerId.isNotEmpty
                        ? () => context.go(
                            '/games/new?friendId=${gameState.opponentPlayerId}')
                        : null,
                    onExit: () => context.go('/games'),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
