import 'package:endstream/app/theme.dart';
import 'package:endstream/ui/components/friend_entry.dart';
import 'package:endstream/ui/components/tree_node.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('FriendEntry', () {
    testWidgets('renders display name', (tester) async {
      await tester.pumpWidget(
        testApp(const FriendEntry(displayName: 'Alice', isOnline: true)),
      );
      expect(find.text('Alice'), findsOneWidget);
    });

    testWidgets('renders rank', (tester) async {
      await tester.pumpWidget(
        testApp(const FriendEntry(
          displayName: 'Bob',
          isOnline: false,
          rank: 1500,
        )),
      );
      expect(find.text('Rank 1500'), findsOneWidget);
    });

    testWidgets('online status shows highlight color', (tester) async {
      await tester.pumpWidget(
        testApp(const FriendEntry(displayName: 'C', isOnline: true)),
      );
      final nodes =
          tester.widgetList<TreeNode>(find.byType(TreeNode)).toList();
      // First node is the status indicator
      expect(nodes[0].color, TreeColors.highlight);
    });

    testWidgets('offline status shows dormant color', (tester) async {
      await tester.pumpWidget(
        testApp(const FriendEntry(displayName: 'D', isOnline: false)),
      );
      final nodes =
          tester.widgetList<TreeNode>(find.byType(TreeNode)).toList();
      expect(nodes[0].color, TreeColors.dormant);
    });

    testWidgets('fires onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        testApp(FriendEntry(
          displayName: 'E',
          isOnline: true,
          onTap: () => tapped = true,
        )),
      );
      await tester.tap(find.text('E'));
      expect(tapped, isTrue);
    });
  });
}
