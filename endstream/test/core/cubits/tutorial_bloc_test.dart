import 'package:bloc_test/bloc_test.dart';
import 'package:endstream/core/cubits/tutorial/tutorial_bloc.dart';
import 'package:endstream/core/cubits/tutorial/tutorial_data.dart';
import 'package:endstream/core/models/operator_instance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TutorialBloc', () {
    late TutorialBloc bloc;

    setUp(() {
      bloc = TutorialBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is TutorialInitial', () {
      expect(bloc.state, const TutorialInitial());
    });

    blocTest<TutorialBloc, TutorialState>(
      'emits TutorialInProgress at step 0 on StartTutorial',
      build: () => TutorialBloc(),
      act: (bloc) => bloc.add(const StartTutorial()),
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 0)
            .having((s) => s.isMyTurn, 'isMyTurn', true)
            .having((s) => s.isAiThinking, 'isAiThinking', false)
            .having((s) => s.hint.title, 'hint.title', 'SELECT A CARD'),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'advances to step 1 when operator card selected at step 0',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 0,
        gameState: buildInitialTutorialState(),
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[0].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) {
        final hand = buildPlayerHand();
        // Select the operator card (Chrono Scout)
        bloc.add(TutorialSelectCard(hand[0]));
      },
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 1)
            .having((s) => s.selection, 'selection',
                isA<TutorialCardSelected>())
            .having((s) => s.hint.title, 'hint.title', 'DEPLOY OPERATOR'),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'ignores non-operator card selection at step 0',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 0,
        gameState: buildInitialTutorialState(),
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[0].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) {
        final hand = buildPlayerHand();
        // Select the tactic card (should be ignored)
        bloc.add(TutorialSelectCard(hand[1]));
      },
      expect: () => [],
    );

    blocTest<TutorialBloc, TutorialState>(
      'enters targeting on select target at step 1',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 1,
        gameState: buildInitialTutorialState(),
        selection: TutorialCardSelected(buildPlayerHand()[0]),
        hint: kTutorialSteps[1].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) {
        bloc.add(const TutorialSelectTarget(
          StreamPosition(stream: 0, centuryIndex: 0),
        ));
      },
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.selection, 'selection',
                isA<TutorialTargeting>()),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'deploys operator and advances to step 2 on confirm at step 1',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 1,
        gameState: buildInitialTutorialState(),
        selection: TutorialTargeting(
          sourceCard: buildPlayerHand()[0],
          targetPosition:
              const StreamPosition(stream: 0, centuryIndex: 0),
        ),
        hint: kTutorialSteps[1].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) => bloc.add(const TutorialConfirmAction()),
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 2)
            .having(
              (s) => s.gameState.myStream[0].operators.length,
              'operator deployed',
              1,
            )
            .having(
              (s) => s.gameState.myHand.length,
              'card removed from hand',
              2,
            )
            .having((s) => s.hint.title, 'hint.title', 'SELECT OPERATOR'),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'selects operator and advances to step 3 at step 2',
      build: () => TutorialBloc(),
      seed: () {
        final state = buildInitialTutorialState();
        final op = createOperatorFromCard(
          card: buildPlayerHand()[0],
          ownerId: 'player',
          position: const StreamPosition(stream: 0, centuryIndex: 0),
          instanceId: 'player-op-1',
        );
        return TutorialInProgress(
          stepIndex: 2,
          gameState: state.copyWith(
            myStream: [
              state.myStream[0].copyWith(operators: [op]),
              ...state.myStream.skip(1),
            ],
          ),
          selection: const TutorialNoneSelected(),
          hint: kTutorialSteps[2].hint,
          isMyTurn: true,
          isAiThinking: false,
        );
      },
      act: (bloc) {
        final op = createOperatorFromCard(
          card: buildPlayerHand()[0],
          ownerId: 'player',
          position: const StreamPosition(stream: 0, centuryIndex: 0),
          instanceId: 'player-op-1',
        );
        bloc.add(TutorialSelectOperator(op));
      },
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 3)
            .having((s) => s.selection, 'selection',
                isA<TutorialOperatorSelected>())
            .having((s) => s.hint.title, 'hint.title', 'MOVE OPERATOR'),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'moves operator and advances to step 4 on confirm at step 3',
      build: () => TutorialBloc(),
      seed: () {
        final state = buildInitialTutorialState();
        final op = createOperatorFromCard(
          card: buildPlayerHand()[0],
          ownerId: 'player',
          position: const StreamPosition(stream: 0, centuryIndex: 0),
          instanceId: 'player-op-1',
        );
        return TutorialInProgress(
          stepIndex: 3,
          gameState: state.copyWith(
            myStream: [
              state.myStream[0].copyWith(operators: [op]),
              ...state.myStream.skip(1),
            ],
            actionPoints: 2,
          ),
          selection: TutorialTargeting(
            sourceOperator: op,
            targetPosition:
                const StreamPosition(stream: 0, centuryIndex: 1),
          ),
          hint: kTutorialSteps[3].hint,
          isMyTurn: true,
          isAiThinking: false,
        );
      },
      act: (bloc) => bloc.add(const TutorialConfirmAction()),
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 4)
            .having(
              (s) => s.gameState.myStream[0].operators.length,
              'removed from source',
              0,
            )
            .having(
              (s) => s.gameState.myStream[1].operators.length,
              'added to target',
              1,
            )
            .having(
              (s) => s.gameState.actionPoints,
              'AP decremented',
              1,
            )
            .having((s) => s.hint.title, 'hint.title', 'END TURN'),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'end turn triggers AI thinking then advances to step 5',
      build: () => TutorialBloc(),
      seed: () {
        final state = buildInitialTutorialState();
        return TutorialInProgress(
          stepIndex: 4,
          gameState: state.copyWith(actionPoints: 1),
          selection: const TutorialNoneSelected(),
          hint: kTutorialSteps[4].hint,
          isMyTurn: true,
          isAiThinking: false,
        );
      },
      act: (bloc) => bloc.add(const TutorialEndTurn()),
      wait: const Duration(milliseconds: 2000),
      expect: () => [
        // First: AI thinking state
        isA<TutorialInProgress>()
            .having((s) => s.isMyTurn, 'isMyTurn', false)
            .having((s) => s.isAiThinking, 'isAiThinking', true),
        // Then: AI deploys and it's your turn again
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 5)
            .having((s) => s.isMyTurn, 'isMyTurn', true)
            .having((s) => s.isAiThinking, 'isAiThinking', false)
            .having(
              (s) => s.gameState.opponentStream[2].operators.length,
              'AI deployed operator',
              1,
            )
            .having(
              (s) => s.gameState.actionPoints,
              'AP refreshed',
              3,
            )
            .having((s) => s.hint.title, 'hint.title', 'ATTACK'),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'attack destroys enemy and emits TutorialComplete',
      build: () => TutorialBloc(),
      seed: () {
        final state = buildInitialTutorialState();
        final playerOp = createOperatorFromCard(
          card: buildPlayerHand()[0],
          ownerId: 'player',
          position: const StreamPosition(stream: 0, centuryIndex: 1),
          instanceId: 'player-op-1',
        );
        final aiOp = createOperatorFromCard(
          card: buildAiCards()[0],
          ownerId: 'ai-opponent',
          position: const StreamPosition(stream: 1, centuryIndex: 2),
          instanceId: 'ai-op-1',
        );
        return TutorialInProgress(
          stepIndex: 5,
          gameState: state.copyWith(
            myStream: [
              state.myStream[0],
              state.myStream[1].copyWith(operators: [playerOp]),
              ...state.myStream.skip(2),
            ],
            opponentStream: [
              state.opponentStream[0],
              state.opponentStream[1],
              state.opponentStream[2].copyWith(operators: [aiOp]),
              ...state.opponentStream.skip(3),
            ],
            actionPoints: 3,
          ),
          selection: TutorialTargeting(
            sourceOperator: playerOp,
            targetPosition:
                const StreamPosition(stream: 1, centuryIndex: 2),
          ),
          hint: kTutorialSteps[5].hint,
          isMyTurn: true,
          isAiThinking: false,
        );
      },
      act: (bloc) => bloc.add(const TutorialConfirmAction()),
      expect: () => [
        // Intermediate state: damage applied
        isA<TutorialInProgress>(),
        // Final state: tutorial complete
        const TutorialComplete(),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'cancel at step 1 resets to step 0',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 1,
        gameState: buildInitialTutorialState(),
        selection: TutorialCardSelected(buildPlayerHand()[0]),
        hint: kTutorialSteps[1].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) => bloc.add(const TutorialCancelAction()),
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 0)
            .having((s) => s.selection, 'selection',
                isA<TutorialNoneSelected>())
            .having((s) => s.hint.title, 'hint.title', 'SELECT A CARD'),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'cancel at other steps resets selection only',
      build: () => TutorialBloc(),
      seed: () {
        final op = createOperatorFromCard(
          card: buildPlayerHand()[0],
          ownerId: 'player',
          position: const StreamPosition(stream: 0, centuryIndex: 0),
          instanceId: 'player-op-1',
        );
        return TutorialInProgress(
          stepIndex: 3,
          gameState: buildInitialTutorialState(),
          selection: TutorialOperatorSelected(op),
          hint: kTutorialSteps[3].hint,
          isMyTurn: true,
          isAiThinking: false,
        );
      },
      act: (bloc) => bloc.add(const TutorialCancelAction()),
      expect: () => [
        isA<TutorialInProgress>()
            .having((s) => s.stepIndex, 'stepIndex', 3)
            .having((s) => s.selection, 'selection',
                isA<TutorialNoneSelected>()),
      ],
    );

    blocTest<TutorialBloc, TutorialState>(
      'emits TutorialComplete on SkipTutorial',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 2,
        gameState: buildInitialTutorialState(),
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[2].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) => bloc.add(const SkipTutorial()),
      expect: () => [const TutorialComplete()],
    );

    blocTest<TutorialBloc, TutorialState>(
      'ignores enemy operator selection at step 2',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 2,
        gameState: buildInitialTutorialState(),
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[2].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) {
        final enemyOp = createOperatorFromCard(
          card: buildAiCards()[0],
          ownerId: 'ai-opponent',
          position: const StreamPosition(stream: 1, centuryIndex: 2),
          instanceId: 'ai-op-1',
        );
        bloc.add(TutorialSelectOperator(enemyOp));
      },
      expect: () => [],
    );

    blocTest<TutorialBloc, TutorialState>(
      'ignores end turn at wrong step',
      build: () => TutorialBloc(),
      seed: () => TutorialInProgress(
        stepIndex: 2,
        gameState: buildInitialTutorialState(),
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[2].hint,
        isMyTurn: true,
        isAiThinking: false,
      ),
      act: (bloc) => bloc.add(const TutorialEndTurn()),
      expect: () => [],
    );
  });
}
