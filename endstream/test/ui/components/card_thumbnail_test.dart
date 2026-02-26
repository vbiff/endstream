import 'package:endstream/core/models/enums.dart';
import 'package:endstream/core/models/game_card.dart';
import 'package:endstream/ui/components/card_thumbnail.dart';
import 'package:endstream/ui/components/tree_badge.dart';
import 'package:endstream/ui/components/tree_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

const _testCard = GameCard(
  id: 'c1',
  name: 'Chrono Blade',
  type: CardType.operatorCard,
  cost: 3,
  rarity: Rarity.rare,
);

const _tacticCard = GameCard(
  id: 'c2',
  name: 'Time Warp',
  type: CardType.tactic,
  cost: 2,
);

void main() {
  group('CardThumbnail', () {
    testWidgets('renders card name', (tester) async {
      await tester.pumpWidget(
        testApp(const CardThumbnail(card: _testCard)),
      );
      expect(find.text('Chrono Blade'), findsOneWidget);
    });

    testWidgets('renders cost badge', (tester) async {
      await tester.pumpWidget(
        testApp(const CardThumbnail(card: _testCard)),
      );
      expect(find.text('3'), findsOneWidget);
      expect(find.byType(TreeBadge), findsOneWidget);
    });

    testWidgets('renders art placeholder with type text', (tester) async {
      await tester.pumpWidget(
        testApp(const CardThumbnail(card: _testCard)),
      );
      expect(find.text('OPERATOR'), findsOneWidget);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        testApp(CardThumbnail(card: _testCard, onTap: () => tapped = true)),
      );
      await tester.tap(find.byType(TreeCard));
      expect(tapped, isTrue);
    });

    testWidgets('renders tactic card type', (tester) async {
      await tester.pumpWidget(
        testApp(const CardThumbnail(card: _tacticCard)),
      );
      expect(find.text('TACTIC'), findsOneWidget);
    });

    testWidgets('has semantics label with card name, type, and cost',
        (tester) async {
      await tester.pumpWidget(
        testApp(const CardThumbnail(card: _testCard)),
      );
      final semantics = tester.widget<Semantics>(find.ancestor(
        of: find.byType(TreeCard),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.label, 'Chrono Blade, operator, cost 3');
    });

    testWidgets('semantics marks as button when tappable', (tester) async {
      await tester.pumpWidget(
        testApp(CardThumbnail(card: _testCard, onTap: () {})),
      );
      final semantics = tester.widget<Semantics>(find.ancestor(
        of: find.byType(TreeCard),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.button, isTrue);
    });

    testWidgets('semantics not marked as button when not tappable',
        (tester) async {
      await tester.pumpWidget(
        testApp(const CardThumbnail(card: _testCard)),
      );
      final semantics = tester.widget<Semantics>(find.ancestor(
        of: find.byType(TreeCard),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.button, isFalse);
    });
  });
}
