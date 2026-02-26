import 'package:endstream/core/models/enums.dart';
import 'package:endstream/core/models/game_card.dart';
import 'package:endstream/ui/screens/deck/deck_editor_collection_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../components/helpers.dart';

const _testCards = [
  GameCard(id: 'c1', name: 'Card One', type: CardType.tactic, cost: 2),
  GameCard(id: 'c2', name: 'Card Two', type: CardType.operatorCard, cost: 3),
];

void main() {
  group('DeckEditorCollectionGrid', () {
    testWidgets('uses ClampingScrollPhysics', (tester) async {
      await tester.pumpWidget(testApp(DeckEditorCollectionGrid(
        cards: _testCards,
        onAdd: (_) {},
        onCardTap: (_) {},
      )));
      final gridView = tester.widget<GridView>(find.byType(GridView));
      expect(gridView.physics, isA<ClampingScrollPhysics>());
    });
  });
}
