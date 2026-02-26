import 'package:endstream/ui/components/component_enums.dart';
import 'package:endstream/ui/components/tree_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeButton', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        testApp(TreeButton(onPressed: () {}, label: 'SUBMIT')),
      );
      expect(find.text('SUBMIT'), findsOneWidget);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        testApp(TreeButton(onPressed: () => pressed = true, label: 'TAP')),
      );
      await tester.tap(find.text('TAP'));
      expect(pressed, isTrue);
    });

    testWidgets('does not fire when disabled', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        testApp(TreeButton(
          onPressed: () => pressed = true,
          label: 'DISABLED',
          enabled: false,
        )),
      );
      await tester.tap(find.text('DISABLED'));
      expect(pressed, isFalse);
    });

    testWidgets('renders all three variants without error', (tester) async {
      for (final variant in TreeButtonVariant.values) {
        await tester.pumpWidget(
          testApp(TreeButton(
            onPressed: () {},
            label: variant.name,
            variant: variant,
          )),
        );
        expect(find.text(variant.name), findsOneWidget);
      }
    });

    testWidgets('uses GestureDetector instead of InkWell', (tester) async {
      await tester.pumpWidget(
        testApp(TreeButton(onPressed: () {}, label: 'TEST')),
      );
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(InkWell), findsNothing);
    });
  });
}
