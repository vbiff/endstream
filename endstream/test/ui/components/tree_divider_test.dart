import 'package:endstream/app/theme.dart';
import 'package:endstream/ui/components/tree_divider.dart';
import 'package:endstream/ui/components/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeDivider', () {
    testWidgets('renders a TreeNode diamond in the center', (tester) async {
      await tester.pumpWidget(testApp(const TreeDivider()));
      expect(find.byType(TreeNode), findsOneWidget);
    });

    testWidgets('renders two line segments', (tester) async {
      await tester.pumpWidget(testApp(const TreeDivider()));
      // Two Expanded widgets for the line segments
      expect(find.byType(Expanded), findsNWidgets(2));
    });

    testWidgets('excludes semantics (decorative)', (tester) async {
      await tester.pumpWidget(testApp(const TreeDivider()));
      // TreeDivider wraps its Row in ExcludeSemantics; TreeNode inside
      // also has its own ExcludeSemantics — both are expected.
      expect(
        find.descendant(
          of: find.byType(TreeDivider),
          matching: find.byType(ExcludeSemantics),
        ),
        findsWidgets,
      );
    });

    testWidgets('uses custom color', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeDivider(color: TreeColors.highlight)),
      );
      final node = tester.widget<TreeNode>(find.byType(TreeNode));
      expect(node.color, TreeColors.highlight);
    });
  });
}
