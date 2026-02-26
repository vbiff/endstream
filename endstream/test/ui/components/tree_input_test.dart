import 'package:endstream/ui/components/tree_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeInput', () {
    testWidgets('renders a TextField', (tester) async {
      await tester.pumpWidget(testApp(const TreeInput()));
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('shows hint text', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeInput(hint: 'Enter name')),
      );
      expect(find.text('Enter name'), findsOneWidget);
    });

    testWidgets('fires onChanged callback', (tester) async {
      String? changedValue;
      await tester.pumpWidget(
        testApp(TreeInput(onChanged: (v) => changedValue = v)),
      );
      await tester.enterText(find.byType(TextField), 'hello');
      expect(changedValue, 'hello');
    });

    testWidgets('fires onSubmitted callback', (tester) async {
      String? submittedValue;
      await tester.pumpWidget(
        testApp(TreeInput(onSubmitted: (v) => submittedValue = v)),
      );
      await tester.enterText(find.byType(TextField), 'test');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submittedValue, 'test');
    });

    testWidgets('obscures text when obscureText is true', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeInput(obscureText: true)),
      );
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('has semantic label', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeInput(semanticLabel: 'Username')),
      );
      final semantics = tester.widget<Semantics>(find.descendant(
        of: find.byType(TreeInput),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.label, 'Username');
    });

    testWidgets('falls back to hint for semantic label', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeInput(hint: 'Enter name')),
      );
      final semantics = tester.widget<Semantics>(find.descendant(
        of: find.byType(TreeInput),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.label, 'Enter name');
    });

    testWidgets('disables input when enabled is false', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeInput(enabled: false)),
      );
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });
  });
}
