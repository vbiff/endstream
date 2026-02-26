import 'package:endstream/core/models/enums.dart';
import 'package:endstream/core/models/game_card.dart';
import 'package:endstream/ui/screens/board/hand_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../components/helpers.dart';

const _testCard = GameCard(
  id: 'c1',
  name: 'Test Card',
  type: CardType.tactic,
  cost: 2,
);

void main() {
  group('HandCardList', () {
    testWidgets('uses ClampingScrollPhysics', (tester) async {
      await tester.pumpWidget(testApp(const HandCardList(
        hand: [_testCard],
        actionPoints: 5,
        isMyTurn: true,
      )));
      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.physics, isA<ClampingScrollPhysics>());
    });

    testWidgets('renders empty message when hand is empty', (tester) async {
      await tester.pumpWidget(testApp(const HandCardList(
        hand: [],
        actionPoints: 5,
        isMyTurn: true,
      )));
      expect(find.text('NO CARDS IN HAND'), findsOneWidget);
    });
  });
}
