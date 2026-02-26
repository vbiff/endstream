import 'package:endstream/app/theme.dart';
import 'package:endstream/ui/components/tree_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeBadge', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(testApp(const TreeBadge(text: 'VALID')));
      expect(find.text('VALID'), findsOneWidget);
    });

    testWidgets('uses default highlight color', (tester) async {
      await tester.pumpWidget(testApp(const TreeBadge(text: 'X')));
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
      final border = decoration.border as Border;
      expect(border.top.color, TreeColors.highlight);
    });

    testWidgets('uses custom color', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeBadge(text: 'ERR', color: TreeColors.error)),
      );
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, TreeColors.error);
    });

    testWidgets('has semantic label matching text', (tester) async {
      await tester.pumpWidget(testApp(const TreeBadge(text: 'VALID')));
      final semantics = tester.widget<Semantics>(find.descendant(
        of: find.byType(TreeBadge),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.label, 'VALID');
    });

    testWidgets('has zero border radius', (tester) async {
      await tester.pumpWidget(testApp(const TreeBadge(text: 'T')));
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNull);
    });
  });
}
