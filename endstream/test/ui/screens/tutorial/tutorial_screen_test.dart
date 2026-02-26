import 'package:bloc_test/bloc_test.dart';
import 'package:endstream/app/theme.dart';
import 'package:endstream/core/cubits/settings/settings_cubit.dart';
import 'package:endstream/core/cubits/tutorial/tutorial_data.dart';
import 'package:endstream/ui/screens/tutorial/tutorial_complete_view.dart';
import 'package:endstream/ui/screens/tutorial/tutorial_hint_overlay.dart';
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
    when(() => settingsCubit.completeTutorial()).thenAnswer((_) async {});
  });

  group('TutorialCompleteView', () {
    testWidgets('renders TRAINING COMPLETE text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: EndStreamTheme.data,
          home: BlocProvider<SettingsCubit>.value(
            value: settingsCubit,
            child: const Scaffold(body: TutorialCompleteView()),
          ),
        ),
      );

      expect(find.text('TRAINING COMPLETE'), findsOneWidget);
      expect(
          find.text('You are ready to enter the stream.'), findsOneWidget);
    });

    testWidgets('renders BEGIN button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: EndStreamTheme.data,
          home: BlocProvider<SettingsCubit>.value(
            value: settingsCubit,
            child: const Scaffold(body: TutorialCompleteView()),
          ),
        ),
      );

      expect(find.text('BEGIN'), findsOneWidget);
    });

    testWidgets('BEGIN button calls completeTutorial and navigates to hub',
        (tester) async {
      final router = GoRouter(
        initialLocation: '/tutorial-complete',
        routes: [
          GoRoute(
            path: '/tutorial-complete',
            builder: (_, __) => const Scaffold(body: TutorialCompleteView()),
          ),
          GoRoute(
            path: '/hub',
            builder: (_, __) => const Scaffold(body: Text('HUB')),
          ),
        ],
      );

      await tester.pumpWidget(
        BlocProvider<SettingsCubit>.value(
          value: settingsCubit,
          child: MaterialApp.router(
            theme: EndStreamTheme.data,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('BEGIN'));
      await tester.pumpAndSettle();

      verify(() => settingsCubit.completeTutorial()).called(1);
      expect(find.text('HUB'), findsOneWidget);
    });
  });

  group('TutorialHintOverlay', () {
    testWidgets('renders hint title and body', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: EndStreamTheme.data,
          home: Scaffold(
            body: Stack(
              children: [
                TutorialHintOverlay(
                  hint: const TutorialHint(
                    title: 'TEST HINT',
                    body: 'This is a test hint body.',
                  ),
                  onSkip: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('TEST HINT'), findsOneWidget);
      expect(find.text('This is a test hint body.'), findsOneWidget);
    });

    testWidgets('renders SKIP TUTORIAL link', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: EndStreamTheme.data,
          home: Scaffold(
            body: Stack(
              children: [
                TutorialHintOverlay(
                  hint: const TutorialHint(
                    title: 'TEST',
                    body: 'Body text.',
                  ),
                  onSkip: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('SKIP TUTORIAL'), findsOneWidget);
    });

    testWidgets('SKIP TUTORIAL fires onSkip callback', (tester) async {
      var skipped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: EndStreamTheme.data,
          home: Scaffold(
            body: Stack(
              children: [
                TutorialHintOverlay(
                  hint: const TutorialHint(
                    title: 'TEST',
                    body: 'Body text.',
                  ),
                  onSkip: () => skipped = true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('SKIP TUTORIAL'));
      expect(skipped, isTrue);
    });
  });
}
