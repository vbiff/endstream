import 'package:endstream/ui/components/tree_card.dart';
import 'package:endstream/ui/components/tree_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('TreeModal', () {
    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeModal(child: Text('Modal Content'))),
      );
      expect(find.text('Modal Content'), findsOneWidget);
    });

    testWidgets('contains a TreeCard with highlighted border', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeModal(child: SizedBox())),
      );
      final card = tester.widget<TreeCard>(find.byType(TreeCard));
      expect(card.highlighted, isTrue);
    });

    testWidgets('backdrop tap fires onClose', (tester) async {
      var closed = false;
      await tester.pumpWidget(
        testApp(TreeModal(
          onClose: () => closed = true,
          child: const SizedBox(width: 50, height: 50),
        )),
      );
      // Tap on the backdrop area (top-left corner, outside the modal)
      await tester.tapAt(const Offset(5, 5));
      expect(closed, isTrue);
    });

    testWidgets('has max width and height constraints', (tester) async {
      await tester.pumpWidget(
        testApp(const TreeModal(child: SizedBox())),
      );
      final constrained = tester.widget<ConstrainedBox>(
        find.descendant(
          of: find.byType(TreeModal),
          matching: find.byType(ConstrainedBox),
        ),
      );
      expect(constrained.constraints.maxWidth, 320);
      expect(constrained.constraints.maxHeight, 500);
    });
  });
}
