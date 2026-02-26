import 'package:endstream/core/models/game.dart';
import 'package:endstream/ui/screens/games/active_games_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../components/helpers.dart';

final _testGames = [
  Game(
    id: 'game-001-abc',
    player1Id: 'user1',
    player2Id: 'user2',
    activePlayerId: 'user1',
  ),
];

void main() {
  group('ActiveGamesList', () {
    testWidgets('uses ClampingScrollPhysics', (tester) async {
      await tester.pumpWidget(testApp(ActiveGamesList(
        games: _testGames,
        currentUserId: 'user1',
      )));
      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.physics, isA<ClampingScrollPhysics>());
    });

    testWidgets('renders empty message when no games', (tester) async {
      await tester.pumpWidget(testApp(const ActiveGamesList(
        games: [],
        currentUserId: 'user1',
      )));
      expect(find.text('No games found'), findsOneWidget);
    });
  });
}
