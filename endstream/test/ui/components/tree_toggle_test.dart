import 'package:endstream/ui/components/tree_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeToggle', () {
    testWidgets('renders with correct size', (tester) async {
      await tester.pumpWidget(
        testApp(TreeToggle(value: false, onChanged: (_) {})),
      );
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(TreeToggle),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.width, 48);
      expect(sizedBox.height, 24);
    });

    testWidgets('fires onChanged with toggled value', (tester) async {
      bool? newValue;
      await tester.pumpWidget(
        testApp(TreeToggle(value: false, onChanged: (v) => newValue = v)),
      );
      await tester.tap(find.byType(TreeToggle));
      expect(newValue, isTrue);
    });

    testWidgets('fires onChanged with false when currently true',
        (tester) async {
      bool? newValue;
      await tester.pumpWidget(
        testApp(TreeToggle(value: true, onChanged: (v) => newValue = v)),
      );
      await tester.tap(find.byType(TreeToggle));
      expect(newValue, isFalse);
    });

    testWidgets('does not fire when disabled', (tester) async {
      bool? newValue;
      await tester.pumpWidget(
        testApp(TreeToggle(
          value: false,
          onChanged: (v) => newValue = v,
          enabled: false,
        )),
      );
      await tester.tap(find.byType(TreeToggle));
      expect(newValue, isNull);
    });

    testWidgets('animates when value changes', (tester) async {
      await tester.pumpWidget(
        testApp(TreeToggle(value: false, onChanged: (_) {})),
      );
      await tester.pumpWidget(
        testApp(TreeToggle(value: true, onChanged: (_) {})),
      );
      await tester.pump(const Duration(milliseconds: 100));
      // Should still render without error mid-animation
      expect(find.byType(TreeToggle), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 200));
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
        testApp(TreeToggle(value: false, onChanged: (_) {})),
      );
      await tester.tap(find.byType(TreeToggle));
      expect(hapticCalls, contains('HapticFeedbackType.lightImpact'));

      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    testWidgets('announces semantic label', (tester) async {
      await tester.pumpWidget(
        testApp(TreeToggle(
          value: false,
          onChanged: (_) {},
          label: 'Test toggle',
        )),
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == 'Test toggle',
        ),
        findsOneWidget,
      );
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
        testApp(TreeToggle(
          value: false,
          onChanged: (_) {},
          enabled: false,
        )),
      );
      await tester.tap(find.byType(TreeToggle));
      expect(hapticCalls, isEmpty);

      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });
  });
}
