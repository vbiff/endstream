import 'package:endstream/app/theme.dart';
import 'package:endstream/ui/components/tree_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeCard', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeCard(child: Text('Hello'))),
      );
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('default border is branchDefault', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeCard(child: SizedBox())),
      );
      final container = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, TreeColors.branchDefault);
    });

    testWidgets('highlighted border is highlight', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeCard(highlighted: true, child: SizedBox())),
      );
      final container = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, TreeColors.highlight);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        testApp(TreeCard(onTap: () => tapped = true, child: const Text('Tap'))),
      );
      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });

    testWidgets('fill color is surface', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeCard(child: SizedBox())),
      );
      final container = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, TreeColors.surface);
    });
  });
}
