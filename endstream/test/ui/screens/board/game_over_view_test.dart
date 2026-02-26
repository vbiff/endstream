import 'package:bloc_test/bloc_test.dart';
import 'package:endstream/app/theme.dart';
import 'package:endstream/core/cubits/settings/settings_cubit.dart';
import 'package:endstream/ui/components/tree_card.dart';
import 'package:endstream/ui/screens/board/game_over_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() {
  late MockSettingsCubit settingsCubit;

  setUp(() {
    settingsCubit = MockSettingsCubit();
    when(() => settingsCubit.state).thenReturn(const SettingsState());
  });

  Widget buildSubject({
    bool isWinner = true,
    VoidCallback? onExit,
    VoidCallback? onRematch,
  }) {
    return MaterialApp(
      theme: EndStreamTheme.data,
      home: Scaffold(
        body: BlocProvider<SettingsCubit>.value(
          value: settingsCubit,
          child: GameOverView(
            isWinner: isWinner,
            onExit: onExit ?? () {},
            onRematch: onRematch,
          ),
        ),
      ),
    );
  }

  group('GameOverView', () {
    group('victory', () {
      testWidgets('renders VICTORY title and subtitle', (tester) async {
        await tester.pumpWidget(buildSubject(isWinner: true));
        await tester.pumpAndSettle();

        expect(find.text('VICTORY'), findsOneWidget);
        expect(find.text('The timeline is restored.'), findsOneWidget);
      });

      testWidgets('does not render defeat text', (tester) async {
        await tester.pumpWidget(buildSubject(isWinner: true));
        await tester.pumpAndSettle();

        expect(find.text('DEFEAT'), findsNothing);
        expect(find.text('The timeline has collapsed.'), findsNothing);
      });

      testWidgets('uses activation highlight color on card', (tester) async {
        await tester.pumpWidget(buildSubject(isWinner: true));
        await tester.pumpAndSettle();

        final card = tester.widget<TreeCard>(find.byType(TreeCard));
        expect(card.highlighted, isTrue);
        // Highlight color should be activation-based at full opacity
        expect(card.highlightColor?.toARGB32(), TreeColors.activation.toARGB32());
      });
    });

    group('defeat', () {
      testWidgets('renders DEFEAT title and subtitle', (tester) async {
        await tester.pumpWidget(buildSubject(isWinner: false));
        await tester.pumpAndSettle();

        expect(find.text('DEFEAT'), findsOneWidget);
        expect(find.text('The timeline has collapsed.'), findsOneWidget);
      });

      testWidgets('does not render victory text', (tester) async {
        await tester.pumpWidget(buildSubject(isWinner: false));
        await tester.pumpAndSettle();

        expect(find.text('VICTORY'), findsNothing);
        expect(find.text('The timeline is restored.'), findsNothing);
      });

      testWidgets('uses error highlight color on card', (tester) async {
        await tester.pumpWidget(buildSubject(isWinner: false));
        await tester.pumpAndSettle();

        final card = tester.widget<TreeCard>(find.byType(TreeCard));
        expect(card.highlighted, isTrue);
        // Highlight color should be error-based at full opacity
        expect(card.highlightColor?.toARGB32(), TreeColors.error.toARGB32());
      });
    });

    group('buttons', () {
      testWidgets('EXIT button triggers onExit callback', (tester) async {
        var exitCalled = false;
        await tester.pumpWidget(
          buildSubject(onExit: () => exitCalled = true),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('EXIT'));
        expect(exitCalled, isTrue);
      });

      testWidgets('REMATCH button appears and triggers callback',
          (tester) async {
        var rematchCalled = false;
        await tester.pumpWidget(
          buildSubject(onRematch: () => rematchCalled = true),
        );
        await tester.pumpAndSettle();

        expect(find.text('REMATCH'), findsOneWidget);
        await tester.tap(find.text('REMATCH'));
        expect(rematchCalled, isTrue);
      });

      testWidgets('REMATCH button hidden when onRematch is null',
          (tester) async {
        await tester.pumpWidget(buildSubject());
        await tester.pumpAndSettle();

        expect(find.text('REMATCH'), findsNothing);
      });
    });

    group('reduce motion', () {
      testWidgets('animations complete instantly when enabled',
          (tester) async {
        when(() => settingsCubit.state).thenReturn(
          const SettingsState(reduceMotion: true),
        );
        await tester.pumpWidget(buildSubject());
        // Single pump — Duration.zero controller completes immediately
        await tester.pump();

        expect(find.text('VICTORY'), findsOneWidget);
        expect(find.text('The timeline is restored.'), findsOneWidget);
        expect(find.text('EXIT'), findsOneWidget);
      });
    });

    group('animation lifecycle', () {
      testWidgets('staggered animation starts all elements hidden',
          (tester) async {
        await tester.pumpWidget(buildSubject());
        // Initial frame — controller at 0.0
        await tester.pump();

        // Elements exist in the tree but card shell is at opacity 0
        final opacity = tester.widget<Opacity>(find.byType(Opacity).first);
        expect(opacity.opacity, 0.0);
      });

      testWidgets('all elements visible after animation completes',
          (tester) async {
        await tester.pumpWidget(buildSubject());
        await tester.pumpAndSettle();

        expect(find.text('VICTORY'), findsOneWidget);
        expect(find.text('EXIT'), findsOneWidget);
      });

      testWidgets('disposes without error', (tester) async {
        await tester.pumpWidget(buildSubject());
        await tester.pumpAndSettle();

        // Replace widget to trigger dispose
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: SizedBox())),
        );
        await tester.pumpAndSettle();
        // No error thrown = pass
      });
    });
  });
}
