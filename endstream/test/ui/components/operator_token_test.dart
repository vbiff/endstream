import 'package:endstream/app/theme.dart';
import 'package:endstream/ui/components/operator_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('OperatorToken', () {
    testWidgets('renders initial letter', (tester) async {
      await tester.pumpWidget(testApp(const OperatorToken(
        name: 'Viper',
        currentHp: 10,
        maxHp: 10,
        attack: 3,
        isOwn: true,
      )));
      expect(find.text('V'), findsOneWidget);
    });

    testWidgets('renders attack value', (tester) async {
      await tester.pumpWidget(testApp(const OperatorToken(
        name: 'Viper',
        currentHp: 10,
        maxHp: 10,
        attack: 5,
        isOwn: true,
      )));
      expect(find.text('ATK 5'), findsOneWidget);
    });

    testWidgets('own operator has highlight border', (tester) async {
      await tester.pumpWidget(testApp(const OperatorToken(
        name: 'A',
        currentHp: 5,
        maxHp: 10,
        attack: 2,
        isOwn: true,
      )));
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(OperatorToken),
          matching: find.byWidgetPredicate(
            (w) =>
                w is Container &&
                w.decoration is BoxDecoration &&
                (w.decoration as BoxDecoration).border != null,
          ),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, TreeColors.highlight);
    });

    testWidgets('enemy operator has error border', (tester) async {
      await tester.pumpWidget(testApp(const OperatorToken(
        name: 'B',
        currentHp: 5,
        maxHp: 10,
        attack: 2,
        isOwn: false,
      )));
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(OperatorToken),
          matching: find.byWidgetPredicate(
            (w) =>
                w is Container &&
                w.decoration is BoxDecoration &&
                (w.decoration as BoxDecoration).border != null,
          ),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, TreeColors.error);
    });

    testWidgets('selected operator has activation border', (tester) async {
      await tester.pumpWidget(testApp(const OperatorToken(
        name: 'C',
        currentHp: 5,
        maxHp: 10,
        attack: 2,
        isOwn: true,
        isSelected: true,
      )));
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(OperatorToken),
          matching: find.byWidgetPredicate(
            (w) =>
                w is Container &&
                w.decoration is BoxDecoration &&
                (w.decoration as BoxDecoration).border != null,
          ),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, TreeColors.activation);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(testApp(OperatorToken(
        name: 'D',
        currentHp: 5,
        maxHp: 10,
        attack: 2,
        isOwn: true,
        onTap: () => tapped = true,
      )));
      await tester.tap(find.byType(OperatorToken));
      expect(tapped, isTrue);
    });
  });
}
