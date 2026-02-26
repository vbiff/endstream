import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/auth/auth_cubit.dart';
import '../../../core/cubits/games/game_list_cubit.dart';
import '../../../core/models/models.dart';
import '../shared/shared.dart';
import 'active_games_filter_tabs.dart';
import 'active_games_list.dart';
import 'active_games_new_game_button.dart';

/// Active games list screen with filter tabs.
class ActiveGamesScreen extends StatefulWidget {
  const ActiveGamesScreen({super.key});

  @override
  State<ActiveGamesScreen> createState() => _ActiveGamesScreenState();
}

class _ActiveGamesScreenState extends State<ActiveGamesScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _ActiveGamesTopBar(),
            const SizedBox(height: 8),
            BlocBuilder<GameListCubit, GameListState>(
              builder: (context, state) {
                if (state is GameListLoading || state is GameListInitial) {
                  return const Expanded(child: ScreenLoadingIndicator());
                }
                if (state is GameListError) {
                  return Expanded(
                    child: ScreenErrorDisplay(
                      message: state.message,
                      onRetry: () =>
                          context.read<GameListCubit>().loadGames(),
                    ),
                  );
                }
                if (state is GameListLoaded) {
                  return _ActiveGamesContent(
                    games: state.games,
                    selectedTab: _selectedTab,
                    onTabSelected: (i) => setState(() => _selectedTab = i),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            ActiveGamesNewGameButton(
              onPressed: () => context.push('/games/new'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveGamesTopBar extends StatelessWidget {
  const _ActiveGamesTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            child: const Text(
              '<',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 18,
                color: TreeColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'ACTIVE GAMES',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.0,
              color: TreeColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveGamesContent extends StatelessWidget {
  const _ActiveGamesContent({
    required this.games,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final List<Game> games;
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    final currentUserId =
        authState is Authenticated ? authState.player.id : '';

    final yourTurn = games
        .where((g) =>
            g.status == GameStatus.active &&
            g.activePlayerId == currentUserId)
        .toList();
    final waiting = games
        .where((g) =>
            g.status == GameStatus.active &&
            g.activePlayerId != currentUserId)
        .toList();
    final completed =
        games.where((g) => g.status != GameStatus.active).toList();

    final filtered = switch (selectedTab) {
      0 => yourTurn,
      1 => waiting,
      2 => completed,
      _ => yourTurn,
    };

    return Expanded(
      child: Column(
        children: [
          ActiveGamesFilterTabs(
            selectedIndex: selectedTab,
            onSelected: onTabSelected,
            yourTurnCount: yourTurn.length,
            waitingCount: waiting.length,
            completedCount: completed.length,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ActiveGamesList(
              games: filtered,
              currentUserId: currentUserId,
            ),
          ),
        ],
      ),
    );
  }
}
