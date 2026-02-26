import 'package:endstream/core/models/operator_instance.dart';
import 'package:endstream/core/models/turnpoint.dart';
import 'package:endstream/ui/components/operator_token.dart';
import 'package:endstream/ui/components/tree_badge.dart';
import 'package:endstream/ui/components/tree_card.dart';
import 'package:endstream/ui/components/tree_divider.dart';
import 'package:endstream/ui/components/turnpoint_cell.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

const _testOperator = OperatorInstance(
  operatorCardId: 'Viper',
  ownerId: 'p1',
  currentHp: 8,
  maxHp: 10,
  attack: 3,
  position: StreamPosition(stream: 0, centuryIndex: 0),
);

const _testEffect = TurnpointEffect(
  id: 'e1',
  name: 'Distortion',
  description: 'Reduces movement',
  sourceCardId: 'c1',
  turnsRemaining: 2,
);

void main() {
  group('TurnpointCell', () {
    testWidgets('renders century label', (tester) async {
      await tester.pumpWidget(testApp(const TurnpointCell(
        century: 2300,
        terrainType: 'standard',
      )));
      expect(find.text('2300'), findsOneWidget);
    });

    testWidgets('renders terrain type', (tester) async {
      await tester.pumpWidget(testApp(const TurnpointCell(
        century: 2100,
        terrainType: 'hazard',
      )));
      expect(find.text('HAZARD'), findsOneWidget);
    });

    testWidgets('renders operators as OperatorTokens', (tester) async {
      await tester.pumpWidget(testApp(const TurnpointCell(
        century: 2200,
        terrainType: 'standard',
        operators: [_testOperator],
      )));
      expect(find.byType(OperatorToken), findsOneWidget);
    });

    testWidgets('renders effect badges', (tester) async {
      await tester.pumpWidget(testApp(const TurnpointCell(
        century: 2200,
        terrainType: 'standard',
        effects: [_testEffect],
      )));
      expect(find.text('Distortion'), findsOneWidget);
      expect(find.byType(TreeBadge), findsOneWidget);
    });

    testWidgets('highlights when selected', (tester) async {
      await tester.pumpWidget(testApp(const TurnpointCell(
        century: 2200,
        terrainType: 'standard',
        isSelected: true,
      )));
      final card = tester.widget<TreeCard>(find.byType(TreeCard));
      expect(card.highlighted, isTrue);
    });

    testWidgets('highlights when valid target', (tester) async {
      await tester.pumpWidget(testApp(const TurnpointCell(
        century: 2200,
        terrainType: 'standard',
        isValidTarget: true,
      )));
      final card = tester.widget<TreeCard>(find.byType(TreeCard));
      expect(card.highlighted, isTrue);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(testApp(TurnpointCell(
        century: 2200,
        terrainType: 'standard',
        onTap: () => tapped = true,
      )));
      await tester.tap(find.byType(TreeCard));
      expect(tapped, isTrue);
    });

    testWidgets('contains TreeDivider', (tester) async {
      await tester.pumpWidget(testApp(const TurnpointCell(
        century: 2200,
        terrainType: 'standard',
      )));
      expect(find.byType(TreeDivider), findsOneWidget);
    });
  });
}
