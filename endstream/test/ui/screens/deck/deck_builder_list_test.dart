import 'package:endstream/core/models/deck.dart';
import 'package:endstream/ui/screens/deck/deck_builder_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../components/helpers.dart';

const _testDecks = [
  Deck(id: 'd1', ownerId: 'u1', name: 'A'),
];

void main() {
  group('DeckBuilderList', () {
    testWidgets('uses ClampingScrollPhysics', (tester) async {
      // Use a wide surface and suppress overflow errors from DeckSlot layout.
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final origOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.toString().contains('overflowed')) return;
        origOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = origOnError);

      await tester.pumpWidget(testApp(DeckBuilderList(
        decks: _testDecks,
        selectedDeckId: null,
        onSelect: (_) {},
      )));
      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.physics, isA<ClampingScrollPhysics>());
    });
  });
}
