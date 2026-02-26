import 'package:endstream/app/theme.dart';
import 'package:endstream/ui/components/action_point_bar.dart';
import 'package:endstream/ui/components/animated_action_point_bar.dart';
import 'package:endstream/ui/components/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('ActionPointBar', () {
    testWidgets('renders correct number of nodes', (tester) async {
      await tester.pumpWidget(
        testApp(const ActionPointBar(total: 5, spent: 2)),
      );
      expect(find.byType(TreeNode), findsNWidgets(5));
    });

    testWidgets('available nodes use activation color', (tester) async {
      await tester.pumpWidget(
        testApp(const ActionPointBar(total: 3, spent: 1)),
      );
      final nodes = tester.widgetList<TreeNode>(find.byType(TreeNode)).toList();
      // 2 available (activation), 1 spent (dormant)
      expect(nodes[0].color, TreeColors.activation);
      expect(nodes[1].color, TreeColors.activation);
      expect(nodes[2].color, TreeColors.dormant);
    });

    testWidgets('all spent shows all dormant', (tester) async {
      await tester.pumpWidget(
        testApp(const ActionPointBar(total: 3, spent: 3)),
      );
      final nodes = tester.widgetList<TreeNode>(find.byType(TreeNode)).toList();
      for (final node in nodes) {
        expect(node.color, TreeColors.dormant);
      }
    });

    testWidgets('zero spent shows all activation', (tester) async {
      await tester.pumpWidget(
        testApp(const ActionPointBar(total: 3, spent: 0)),
      );
      final nodes = tester.widgetList<TreeNode>(find.byType(TreeNode)).toList();
      for (final node in nodes) {
        expect(node.color, TreeColors.activation);
      }
    });

    testWidgets('has semantics label with available and total', (tester) async {
      await tester.pumpWidget(
        testApp(const ActionPointBar(total: 6, spent: 2)),
      );
      final semantics = tester.widget<Semantics>(find.ancestor(
        of: find.byType(Row),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.label, '4 of 6 action points');
    });

    testWidgets('semantics label reflects all spent', (tester) async {
      await tester.pumpWidget(
        testApp(const ActionPointBar(total: 5, spent: 5)),
      );
      final semantics = tester.widget<Semantics>(find.ancestor(
        of: find.byType(Row),
        matching: find.byType(Semantics),
      ).first);
      expect(semantics.properties.label, '0 of 5 action points');
    });
  });

  group('AnimatedActionPointBar', () {
    testWidgets('announces AP to screen reader', (tester) async {
      await tester.pumpWidget(
        testApp(const AnimatedActionPointBar(
          total: 6,
          spent: 2,
          isMyTurn: true,
        )),
      );
      expect(
        find.byWidgetPredicate(
          (w) =>
              w is Semantics &&
              w.properties.label == '4 of 6 action points',
        ),
        findsOneWidget,
      );
    });
  });
}
