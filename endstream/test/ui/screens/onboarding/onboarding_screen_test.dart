import 'package:bloc_test/bloc_test.dart';
import 'package:endstream/app/theme.dart';
import 'package:endstream/core/cubits/settings/settings_cubit.dart';
import 'package:endstream/ui/screens/onboarding/onboarding_lore_page.dart';
import 'package:endstream/ui/screens/onboarding/onboarding_mechanics_page.dart';
import 'package:endstream/ui/screens/onboarding/onboarding_navigation_bar.dart';
import 'package:endstream/ui/screens/onboarding/onboarding_page_indicator.dart';
import 'package:endstream/ui/screens/onboarding/onboarding_screen.dart';
import 'package:endstream/ui/screens/onboarding/onboarding_win_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() {
  late MockSettingsCubit settingsCubit;

  setUp(() {
    settingsCubit = MockSettingsCubit();
    when(() => settingsCubit.state).thenReturn(const SettingsState());
    when(() => settingsCubit.completeOnboarding()).thenAnswer((_) async {});
  });

  /// Simple wrapper without GoRouter — for rendering tests only.
  Widget buildSubject() {
    return MaterialApp(
      theme: EndStreamTheme.data,
      home: BlocProvider<SettingsCubit>.value(
        value: settingsCubit,
        child: const OnboardingScreen(),
      ),
    );
  }

  /// Wrapper with GoRouter — for tests that trigger navigation.
  Widget buildRoutedSubject() {
    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (_, __) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/hub',
          builder: (_, __) => const Scaffold(body: Text('HUB')),
        ),
        GoRoute(
          path: '/tutorial',
          builder: (_, __) => const Scaffold(body: Text('TUTORIAL')),
        ),
      ],
    );
    return BlocProvider<SettingsCubit>.value(
      value: settingsCubit,
      child: MaterialApp.router(
        theme: EndStreamTheme.data,
        routerConfig: router,
      ),
    );
  }

  group('OnboardingScreen', () {
    testWidgets('renders first page (lore) on initial load', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(OnboardingLorePage), findsOneWidget);
      expect(find.text('THE TIMELINE IS FRACTURED'), findsOneWidget);
    });

    testWidgets('renders page indicator with 4 dots', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(OnboardingPageIndicator), findsOneWidget);
      // 4 indicator dots inside the page indicator
      expect(
        find.descendant(
          of: find.byType(OnboardingPageIndicator),
          matching: find.byType(AnimatedContainer),
        ),
        findsNWidgets(4),
      );
    });

    testWidgets('renders navigation bar with SKIP and NEXT', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(OnboardingNavigationBar), findsOneWidget);
      expect(find.text('SKIP'), findsOneWidget);
      expect(find.text('NEXT'), findsOneWidget);
    });

    testWidgets('first page visible, others off-screen', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(OnboardingLorePage), findsOneWidget);
      expect(find.byType(OnboardingMechanicsPage), findsNothing);
    });

    testWidgets('NEXT button advances to second page', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingMechanicsPage), findsOneWidget);
      expect(find.text('THE BOARD'), findsOneWidget);
    });

    testWidgets('swipe advances to next page', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingMechanicsPage), findsOneWidget);
    });

    testWidgets('shows START button on last page', (tester) async {
      await tester.pumpWidget(buildSubject());

      for (var i = 0; i < 3; i++) {
        await tester.tap(find.text('NEXT'));
        await tester.pumpAndSettle();
      }

      expect(find.text('START'), findsOneWidget);
      expect(find.text('NEXT'), findsNothing);
    });

    testWidgets('third page shows victory conditions', (tester) async {
      await tester.pumpWidget(buildSubject());

      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingWinPage), findsOneWidget);
      expect(find.text('VICTORY CONDITIONS'), findsOneWidget);
    });
  });

  group('OnboardingNavigationBar', () {
    testWidgets('SKIP calls completeOnboarding and navigates to hub',
        (tester) async {
      await tester.pumpWidget(buildRoutedSubject());
      await tester.pumpAndSettle();

      await tester.tap(find.text('SKIP'));
      await tester.pumpAndSettle();

      verify(() => settingsCubit.completeOnboarding()).called(1);
      expect(find.text('HUB'), findsOneWidget);
    });

    testWidgets('START on last page calls completeOnboarding and navigates',
        (tester) async {
      await tester.pumpWidget(buildRoutedSubject());
      await tester.pumpAndSettle();

      for (var i = 0; i < 3; i++) {
        await tester.tap(find.text('NEXT'));
        await tester.pumpAndSettle();
      }

      await tester.tap(find.text('START'));
      await tester.pumpAndSettle();

      verify(() => settingsCubit.completeOnboarding()).called(1);
      expect(find.text('TUTORIAL'), findsOneWidget);
    });
  });
}
