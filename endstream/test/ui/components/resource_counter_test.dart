import 'package:endstream/ui/components/resource_counter.dart';
import 'package:endstream/ui/components/tree_node.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('ResourceCounter', () {
    testWidgets('renders value text', (tester) async {
      await tester.pumpWidget(
        testApp(const ResourceCounter(value: 7, label: 'HP')),
      );
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        testApp(const ResourceCounter(value: 3, label: 'AP')),
      );
      expect(find.text('AP'), findsOneWidget);
    });

    testWidgets('contains a TreeNode', (tester) async {
      await tester.pumpWidget(
        testApp(const ResourceCounter(value: 1, label: 'X')),
      );
      final node = tester.widget<TreeNode>(find.byType(TreeNode));
      expect(node.size, 28);
    });
  });
}
