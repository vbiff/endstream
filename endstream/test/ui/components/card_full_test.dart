import 'package:endstream/core/models/enums.dart';
import 'package:endstream/core/models/game_card.dart';
import 'package:endstream/ui/components/card_full.dart';
import 'package:endstream/ui/components/tree_badge.dart';
import 'package:endstream/ui/components/tree_card.dart';
import 'package:endstream/ui/components/tree_divider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

const _operatorCard = GameCard(
  id: 'op1',
  name: 'Chrono Blade',
  type: CardType.operatorCard,
  cost: 3,
  rarity: Rarity.rare,
  text: 'Strikes across timelines.',
  flavorText: 'Time is a weapon.',
  hp: 10,
  attack: 4,
  abilities: [
    Ability(
      id: 'a1',
      cardId: 'op1',
      name: 'Temporal Slash',
      description: 'Deal 3 damage to adjacent operator.',
      cost: 2,
    ),
  ],
);

const _tacticCard = GameCard(
  id: 't1',
  name: 'Rewind',
  type: CardType.tactic,
  cost: 1,
  text: 'Return operator to previous position.',
);

void main() {
  group('CardFull', () {
    testWidgets('renders card name', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.text('Chrono Blade'), findsOneWidget);
    });

    testWidgets('renders cost badge', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('renders type and rarity badges', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.text('OPERATOR'), findsWidgets);
      expect(find.text('RARE'), findsOneWidget);
    });

    testWidgets('renders HP and ATK stats for operator', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.text('HP'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('ATK'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('renders card text', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.text('Strikes across timelines.'), findsOneWidget);
    });

    testWidgets('renders flavor text', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.text('Time is a weapon.'), findsOneWidget);
    });

    testWidgets('renders ability name and cost', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.text('Temporal Slash'), findsOneWidget);
      expect(find.text('2 AP'), findsOneWidget);
    });

    testWidgets('renders ability description', (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(
        find.text('Deal 3 damage to adjacent operator.'),
        findsOneWidget,
      );
    });

    testWidgets('does not show HP/ATK for non-operator cards',
        (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _tacticCard)));
      expect(find.text('HP'), findsNothing);
      expect(find.text('ATK'), findsNothing);
    });

    testWidgets('contains TreeCard, TreeDivider, and TreeBadge',
        (tester) async {
      await tester.pumpWidget(testApp(const CardFull(card: _operatorCard)));
      expect(find.byType(TreeCard), findsOneWidget);
      expect(find.byType(TreeDivider), findsOneWidget);
      expect(find.byType(TreeBadge), findsWidgets);
    });
  });
}
