import 'dart:math' as math;

import 'package:endstream/app/theme.dart';
import 'package:endstream/ui/components/component_enums.dart';
import 'package:endstream/ui/components/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeNode', () {
    testWidgets('renders with default props', (tester) async {
      await tester.pumpWidget(testApp(const TreeNode()));
      expect(find.byType(TreeNode), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(testApp(const TreeNode(size: 16)));
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(TreeNode),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.width, 16);
      expect(sizedBox.height, 16);
    });

    testWidgets('renders with custom color', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeNode(color: TreeColors.activation)),
      );
      final decoratedBox = tester.widget<DecoratedBox>(
        find.byType(DecoratedBox),
      );
      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.color, TreeColors.activation);
    });

    testWidgets('square shape has no rotation within TreeNode', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeNode(shape: TreeNodeShape.square)),
      );
      expect(
        find.descendant(
          of: find.byType(TreeNode),
          matching: find.byType(Transform),
        ),
        findsNothing,
      );
    });

    testWidgets('excludes semantics (decorative)', (tester) async {
      await tester.pumpWidget(testApp(const TreeNode()));
      expect(
        find.descendant(
          of: find.byType(TreeNode),
          matching: find.byType(ExcludeSemantics),
        ),
        findsOneWidget,
      );
    });

    testWidgets('diamond shape applies rotation', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeNode(shape: TreeNodeShape.diamond)),
      );
      final transform = tester.widget<Transform>(
        find.descendant(
          of: find.byType(TreeNode),
          matching: find.byType(Transform),
        ),
      );
      expect(transform.transform, Matrix4.rotationZ(math.pi / 4));
    });
  });
}
