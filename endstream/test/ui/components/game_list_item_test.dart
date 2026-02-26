import 'package:endstream/ui/components/component_enums.dart';
import 'package:endstream/ui/components/game_list_item.dart';
import 'package:endstream/ui/components/tree_badge.dart';
import 'package:endstream/ui/components/tree_card.dart';
import 'package:endstream/ui/components/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('GameListItem', () {
    testWidgets('renders game name', (tester) async {
      await tester.pumpWidget(testApp(const GameListItem(
        gameName: 'Battle Alpha',
        opponentName: 'Rival',
        status: GameItemStatus.waiting,
        turnNumber: 5,
      )));
      expect(find.text('Battle Alpha'), findsOneWidget);
    });

    testWidgets('renders opponent name', (tester) async {
      await tester.pumpWidget(testApp(const GameListItem(
        gameName: 'G',
        opponentName: 'Nemesis',
        status: GameItemStatus.waiting,
        turnNumber: 1,
      )));
      expect(find.text('Nemesis'), findsOneWidget);
    });

    testWidgets('renders turn number badge', (tester) async {
      await tester.pumpWidget(testApp(const GameListItem(
        gameName: 'G',
        opponentName: 'O',
        status: GameItemStatus.waiting,
        turnNumber: 12,
      )));
      expect(find.text('T12'), findsOneWidget);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(testApp(GameListItem(
        gameName: 'G',
        opponentName: 'O',
        status: GameItemStatus.waiting,
        turnNumber: 1,
        onTap: () => tapped = true,
      )));
      await tester.tap(find.byType(TreeCard));
      expect(tapped, isTrue);
    });

    testWidgets('yourTurn status starts pulse animation', (tester) async {
      await tester.pumpWidget(testApp(const GameListItem(
        gameName: 'G',
        opponentName: 'O',
        status: GameItemStatus.yourTurn,
        turnNumber: 1,
      )));
      // Pump to verify animation runs without error
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(GameListItem), findsOneWidget);
    });

    testWidgets('contains TreeNode, TreeBadge, and TreeCard', (tester) async {
      await tester.pumpWidget(testApp(const GameListItem(
        gameName: 'G',
        opponentName: 'O',
        status: GameItemStatus.won,
        turnNumber: 8,
      )));
      expect(find.byType(TreeNode), findsOneWidget);
      expect(find.byType(TreeBadge), findsOneWidget);
      expect(find.byType(TreeCard), findsOneWidget);
    });

    testWidgets('all statuses render without error', (tester) async {
      for (final status in GameItemStatus.values) {
        await tester.pumpWidget(testApp(GameListItem(
          gameName: 'G',
          opponentName: 'O',
          status: status,
          turnNumber: 1,
        )));
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.byType(GameListItem), findsOneWidget);
      }
    });

    testWidgets('skips pulse animation when reduce motion is enabled',
        (tester) async {
      await tester.pumpWidget(testAppWithReducedMotion(const GameListItem(
        gameName: 'G',
        opponentName: 'O',
        status: GameItemStatus.yourTurn,
        turnNumber: 1,
      )));
      await tester.pump(const Duration(milliseconds: 500));
      // With reduced motion the AnimatedBuilder wrapping the pulse is absent;
      // the widget should still render a static node without Opacity wrapper.
      expect(find.byType(GameListItem), findsOneWidget);
      // Verify no Opacity widget from pulse animation
      final opacityWidgets = tester.widgetList<Opacity>(
        find.descendant(
          of: find.byType(GameListItem),
          matching: find.byType(Opacity),
        ),
      );
      expect(opacityWidgets, isEmpty);
    });
  });
}
