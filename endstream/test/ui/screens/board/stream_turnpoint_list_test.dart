import 'package:endstream/core/models/turnpoint.dart';
import 'package:endstream/ui/screens/board/stream_turnpoint_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../components/helpers.dart';

const _turnpoints = [
  Turnpoint(century: 2100),
  Turnpoint(century: 2200),
  Turnpoint(century: 2300),
];

void main() {
  group('StreamTurnpointList', () {
    testWidgets('uses ClampingScrollPhysics', (tester) async {
      await tester.pumpWidget(testApp(const StreamTurnpointList(
        turnpoints: _turnpoints,
        isOpponent: false,
      )));
      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.physics, isA<ClampingScrollPhysics>());
    });
  });
}
