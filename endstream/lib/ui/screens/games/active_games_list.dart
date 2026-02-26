import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/models.dart';
import '../../components/components.dart';
import '../shared/shared.dart';

/// List of game items with proper status mapping.
class ActiveGamesList extends StatelessWidget {
  const ActiveGamesList({
    super.key,
    required this.games,
    required this.currentUserId,
  });

  final List<Game> games;
  final String currentUserId;

  GameItemStatus _mapStatus(Game game) {
    if (game.status == GameStatus.completed) {
      return game.winnerId == currentUserId
          ? GameItemStatus.won
          : GameItemStatus.lost;
    }
    if (game.status == GameStatus.abandoned) {
      return GameItemStatus.abandoned;
    }
    return game.activePlayerId == currentUserId
        ? GameItemStatus.yourTurn
        : GameItemStatus.waiting;
  }

  String _opponentName(Game game) {
    return game.player1Id == currentUserId
        ? 'Player 2'
        : 'Player 1';
  }

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return const ScreenEmptyDisplay(message: 'No games found');
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: games.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final game = games[index];
        return GameListItem(
          gameName: 'Game ${game.id.substring(0, 6).toUpperCase()}',
          opponentName: _opponentName(game),
          status: _mapStatus(game),
          turnNumber: game.currentTurn,
          onTap: () => context.push('/games/${game.id}'),
        );
      },
    );
  }
}
