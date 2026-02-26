import 'package:endstream/ui/components/component_enums.dart';
import 'package:endstream/ui/components/tree_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    testWidgets('triggers haptic feedback on tap', (tester) async {
      final hapticCalls = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          if (methodCall.method == 'HapticFeedback.vibrate') {
            hapticCalls.add(methodCall.arguments as String);
          }
          return null;
        },
      );

      await tester.pumpWidget(
        testApp(TreeButton(onPressed: () {}, label: 'HAPTIC')),
      );
      await tester.tap(find.text('HAPTIC'));
      expect(hapticCalls, contains('HapticFeedbackType.lightImpact'));

      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    testWidgets('has accessible button semantics', (tester) async {
      await tester.pumpWidget(
        testApp(TreeButton(onPressed: () {}, label: 'SUBMIT')),
      );
      final semantics = tester.widget<Semantics>(find.descendant(
        of: find.byType(TreeButton),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.button, isTrue);
      expect(semantics.properties.label, 'SUBMIT');
    });

    testWidgets('does not trigger haptic when disabled', (tester) async {
      final hapticCalls = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          if (methodCall.method == 'HapticFeedback.vibrate') {
            hapticCalls.add(methodCall.arguments as String);
          }
          return null;
        },
      );

      await tester.pumpWidget(
        testApp(TreeButton(
          onPressed: () {},
          label: 'DISABLED',
          enabled: false,
        )),
      );
      await tester.tap(find.text('DISABLED'));
      expect(hapticCalls, isEmpty);

      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });
  });
}
