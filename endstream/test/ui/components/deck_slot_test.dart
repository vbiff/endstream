import 'package:endstream/ui/components/deck_slot.dart';
import 'package:endstream/ui/components/tree_badge.dart';
import 'package:endstream/ui/components/tree_card.dart';
import 'package:endstream/ui/components/tree_node.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('DeckSlot', () {
    testWidgets('renders deck name', (tester) async {
      await tester.pumpWidget(
        testApp(const DeckSlot(name: 'Rush Deck', cardCount: 20, isValid: true)),
      );
      expect(find.text('Rush Deck'), findsOneWidget);
    });

    testWidgets('renders card count', (tester) async {
      await tester.pumpWidget(
        testApp(const DeckSlot(name: 'D', cardCount: 15, isValid: true)),
      );
      expect(find.text('15 cards'), findsOneWidget);
    });

    testWidgets('shows VALID badge when valid', (tester) async {
      await tester.pumpWidget(
        testApp(const DeckSlot(name: 'D', cardCount: 20, isValid: true)),
      );
      expect(find.text('VALID'), findsOneWidget);
    });

    testWidgets('shows INVALID badge when invalid', (tester) async {
      await tester.pumpWidget(
        testApp(const DeckSlot(name: 'D', cardCount: 5, isValid: false)),
      );
      expect(find.text('INVALID'), findsOneWidget);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        testApp(DeckSlot(
          name: 'D',
          cardCount: 10,
          isValid: true,
          onTap: () => tapped = true,
        )),
      );
      await tester.tap(find.byType(TreeCard));
      expect(tapped, isTrue);
    });

    testWidgets('contains TreeNode, TreeBadge, and TreeCard', (tester) async {
      await tester.pumpWidget(
        testApp(const DeckSlot(name: 'D', cardCount: 10, isValid: true)),
      );
      expect(find.byType(TreeNode), findsOneWidget);
      expect(find.byType(TreeBadge), findsOneWidget);
      expect(find.byType(TreeCard), findsOneWidget);
    });
  });
}
