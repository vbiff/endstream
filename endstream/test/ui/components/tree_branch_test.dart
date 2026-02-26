import 'package:endstream/ui/components/component_enums.dart';
import 'package:endstream/ui/components/tree_branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeBranch', () {
    testWidgets('renders static horizontal branch', (tester) async {
      await tester.pumpWidget(testApp(const TreeBranch()));
      expect(find.byType(TreeBranch), findsOneWidget);
      expect(find.byType(DecoratedBox), findsWidgets);
    });

    testWidgets('renders with custom length', (tester) async {
      await tester.pumpWidget(testApp(const TreeBranch(length: 50)));
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(TreeBranch),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.width, 50);
    });

    testWidgets('vertical direction uses height for length', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeBranch(
          direction: TreeBranchDirection.vertical,
          length: 80,
        )),
      );
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(TreeBranch),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.height, 80);
    });

    testWidgets('animated branch uses CustomPaint', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeBranch(animated: true, length: 100)),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(
        find.descendant(
          of: find.byType(TreeBranch),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets('animated branch runs without error over time',
        (tester) async {
      await tester.pumpWidget(
        testApp(const TreeBranch(animated: true, length: 100)),
      );
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(TreeBranch), findsOneWidget);
    });

    testWidgets('animated branch renders static when reduce motion is enabled',
        (tester) async {
      await tester.pumpWidget(
        testAppWithReducedMotion(
          const TreeBranch(animated: true, length: 100),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      // With reduced motion, animated branch should fall back to static
      // DecoratedBox instead of CustomPaint wave.
      expect(
        find.descendant(
          of: find.byType(TreeBranch),
          matching: find.byType(DecoratedBox),
        ),
        findsWidgets,
      );
      expect(
        find.descendant(
          of: find.byType(TreeBranch),
          matching: find.byType(CustomPaint),
        ),
        findsNothing,
      );
    });
  });
}
