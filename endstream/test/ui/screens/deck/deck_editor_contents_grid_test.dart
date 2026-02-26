import 'package:endstream/core/models/deck.dart';
import 'package:endstream/core/models/enums.dart';
import 'package:endstream/core/models/game_card.dart';
import 'package:endstream/ui/screens/deck/deck_editor_contents_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../components/helpers.dart';

const _testCards = [
  GameCard(id: 'c1', name: 'Card One', type: CardType.tactic, cost: 2),
];

const _testDeckCards = [
  DeckCard(cardId: 'c1', quantity: 2),
];

void main() {
  group('DeckEditorContentsGrid', () {
    testWidgets('uses ClampingScrollPhysics', (tester) async {
      await tester.pumpWidget(testApp(DeckEditorContentsGrid(
        deckCards: _testDeckCards,
        allCards: _testCards,
        onRemove: (_) {},
        onCardTap: (_) {},
      )));
      final gridView = tester.widget<GridView>(find.byType(GridView));
      expect(gridView.physics, isA<ClampingScrollPhysics>());
    });

    testWidgets('shows empty message when deck is empty', (tester) async {
      await tester.pumpWidget(testApp(DeckEditorContentsGrid(
        deckCards: const [],
        allCards: _testCards,
        onRemove: (_) {},
        onCardTap: (_) {},
      )));
      expect(find.text('Deck is empty'), findsOneWidget);
    });
  });
}
