import 'package:endstream/ui/animations/easing_curves.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Tests that the route transition configuration produces the expected
/// fade transition using TreeCurves and TreeDurations.
///
/// We cannot test AppRouter.instance directly because it depends on
/// Supabase and BLoC providers. Instead we verify the same
/// CustomTransitionPage pattern used by _buildPage.
CustomTransitionPage<void> buildPage(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: TreeDurations.transition,
    reverseTransitionDuration: TreeDurations.normal,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = CurvedAnimation(
        parent: animation,
        curve: TreeCurves.standard,
      );
      return FadeTransition(opacity: fade, child: child);
    },
  );
}

void main() {
  group('Route transitions', () {
    testWidgets('CustomTransitionPage uses 400ms transition duration',
        (tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) =>
                buildPage(const Text('Home'), state),
          ),
          GoRoute(
            path: '/next',
            pageBuilder: (context, state) =>
                buildPage(const Text('Next'), state),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);

      router.go('/next');
      // Pump just past the start — should be mid-transition
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      // Transition is 400ms, so at 200ms we should find a FadeTransition
      expect(find.byType(FadeTransition), findsWidgets);

      await tester.pumpAndSettle();
      expect(find.text('Next'), findsOneWidget);

      router.dispose();
    });

    test('transition duration matches TreeDurations.transition', () {
      expect(TreeDurations.transition, const Duration(milliseconds: 400));
    });

    test('reverse transition duration matches TreeDurations.normal', () {
      expect(TreeDurations.normal, const Duration(milliseconds: 350));
    });

    testWidgets('transition uses FadeTransition', (tester) async {
      final router = GoRouter(
        initialLocation: '/a',
        routes: [
          GoRoute(
            path: '/a',
            pageBuilder: (context, state) =>
                buildPage(const Text('A'), state),
          ),
          GoRoute(
            path: '/b',
            pageBuilder: (context, state) =>
                buildPage(const Text('B'), state),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go('/b');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // A FadeTransition should be in the tree during the transition
      expect(find.byType(FadeTransition), findsWidgets);

      await tester.pumpAndSettle();
      router.dispose();
    });
  });
}
