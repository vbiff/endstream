import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/client_game_state.dart';
import '../../models/enums.dart';
import '../../models/game_card.dart';
import '../../models/operator_instance.dart';
import '../../models/turnpoint.dart';
import 'tutorial_data.dart';

part 'tutorial_event.dart';
part 'tutorial_state.dart';

/// BLoC for the guided tutorial game.
///
/// Manages a scripted 6-step local game that teaches basic mechanics.
/// No backend calls — all state is local.
class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  TutorialBloc() : super(const TutorialInitial()) {
    on<StartTutorial>(_onStart);
    on<TutorialSelectCard>(_onSelectCard);
    on<TutorialSelectOperator>(_onSelectOperator);
    on<TutorialSelectTarget>(_onSelectTarget);
    on<TutorialConfirmAction>(_onConfirm);
    on<TutorialCancelAction>(_onCancel);
    on<TutorialEndTurn>(_onEndTurn);
    on<SkipTutorial>(_onSkip);
  }

  void _onStart(StartTutorial event, Emitter<TutorialState> emit) {
    emit(TutorialInProgress(
      stepIndex: 0,
      gameState: buildInitialTutorialState(),
      selection: const TutorialNoneSelected(),
      hint: kTutorialSteps[0].hint,
      isMyTurn: true,
      isAiThinking: false,
    ));
  }

  void _onSelectCard(TutorialSelectCard event, Emitter<TutorialState> emit) {
    final current = state;
    if (current is! TutorialInProgress) return;

    // Step 0: Select a card from hand
    if (current.stepIndex == 0) {
      // Only accept operator cards for the deploy tutorial
      if (event.card.type != CardType.operatorCard) return;

      emit(current.copyWith(
        stepIndex: 1,
        selection: TutorialCardSelected(event.card),
        hint: kTutorialSteps[1].hint,
      ));
      return;
    }

    // Step 5: Attack — first select operator, not card
    // Ignore card selection at other steps
  }

  void _onSelectOperator(
      TutorialSelectOperator event, Emitter<TutorialState> emit) {
    final current = state;
    if (current is! TutorialInProgress) return;

    // Step 2: Select your deployed operator
    if (current.stepIndex == 2) {
      if (event.operator.ownerId != 'player') return;

      emit(current.copyWith(
        stepIndex: 3,
        selection: TutorialOperatorSelected(event.operator),
        hint: kTutorialSteps[3].hint,
      ));
      return;
    }

    // Step 5: Attack — select your operator first
    if (current.stepIndex == 5) {
      if (event.operator.ownerId != 'player') return;

      emit(current.copyWith(
        selection: TutorialOperatorSelected(event.operator),
      ));
      return;
    }
  }

  void _onSelectTarget(
      TutorialSelectTarget event, Emitter<TutorialState> emit) {
    final current = state;
    if (current is! TutorialInProgress) return;
    final sel = current.selection;

    // Step 1: Deploy — card selected, now pick a turnpoint on own stream
    if (current.stepIndex == 1 && sel is TutorialCardSelected) {
      emit(current.copyWith(
        selection: TutorialTargeting(
          sourceCard: sel.card,
          targetPosition: event.position,
        ),
      ));
      return;
    }

    // Step 3: Move — operator selected, now pick adjacent turnpoint
    if (current.stepIndex == 3 && sel is TutorialOperatorSelected) {
      emit(current.copyWith(
        selection: TutorialTargeting(
          sourceOperator: sel.operator,
          targetPosition: event.position,
        ),
      ));
      return;
    }

    // Step 5: Attack — operator selected, target enemy
    if (current.stepIndex == 5 && sel is TutorialOperatorSelected) {
      emit(current.copyWith(
        selection: TutorialTargeting(
          sourceOperator: sel.operator,
          targetPosition: event.position,
        ),
      ));
      return;
    }
  }

  void _onConfirm(TutorialConfirmAction event, Emitter<TutorialState> emit) {
    final current = state;
    if (current is! TutorialInProgress) return;
    final sel = current.selection;
    if (sel is! TutorialTargeting) return;

    // Step 1: Deploy operator onto turnpoint
    if (current.stepIndex == 1 && sel.sourceCard != null) {
      final target = sel.targetPosition!;
      final op = createOperatorFromCard(
        card: sel.sourceCard!,
        ownerId: 'player',
        position: target,
        instanceId: 'player-op-1',
      );

      final newStream = _addOperatorToStream(
        current.gameState.myStream,
        op,
        target.centuryIndex,
      );
      final newHand = current.gameState.myHand
          .where((c) => c.id != sel.sourceCard!.id)
          .toList();

      emit(current.copyWith(
        stepIndex: 2,
        gameState: current.gameState.copyWith(
          myStream: newStream,
          myHand: newHand,
          actionPoints: current.gameState.actionPoints - sel.sourceCard!.cost,
        ),
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[2].hint,
      ));
      return;
    }

    // Step 3: Move operator to new turnpoint
    if (current.stepIndex == 3 && sel.sourceOperator != null) {
      final target = sel.targetPosition!;
      final movedOp = sel.sourceOperator!.copyWith(position: target);

      // Remove from old position
      var newStream = _removeOperatorFromStream(
        current.gameState.myStream,
        sel.sourceOperator!,
      );
      // Add to new position
      newStream = _addOperatorToStream(newStream, movedOp, target.centuryIndex);

      emit(current.copyWith(
        stepIndex: 4,
        gameState: current.gameState.copyWith(
          myStream: newStream,
          actionPoints: current.gameState.actionPoints - 1,
        ),
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[4].hint,
      ));
      return;
    }

    // Step 5: Attack enemy
    if (current.stepIndex == 5 && sel.sourceOperator != null) {
      final target = sel.targetPosition!;
      // Find enemy operator at target
      final opponentStream = current.gameState.opponentStream;
      if (target.centuryIndex >= opponentStream.length) return;

      final targetTurnpoint = opponentStream[target.centuryIndex];
      if (targetTurnpoint.operators.isEmpty) return;

      final enemyOp = targetTurnpoint.operators.first;
      final damage = sel.sourceOperator!.attack;
      final newHp = enemyOp.currentHp - damage;

      List<Turnpoint> newOpponentStream;
      if (newHp <= 0) {
        // Remove destroyed operator
        newOpponentStream = _removeOperatorFromStream(opponentStream, enemyOp);
      } else {
        // Update HP
        newOpponentStream = _updateOperatorHp(
          opponentStream,
          enemyOp,
          newHp,
        );
      }

      emit(current.copyWith(
        gameState: current.gameState.copyWith(
          opponentStream: newOpponentStream,
          actionPoints: current.gameState.actionPoints - 1,
        ),
        selection: const TutorialNoneSelected(),
      ));

      // Tutorial complete
      emit(const TutorialComplete());
      return;
    }
  }

  void _onCancel(TutorialCancelAction event, Emitter<TutorialState> emit) {
    final current = state;
    if (current is! TutorialInProgress) return;

    // Go back to the appropriate selection state for the current step
    if (current.stepIndex == 1) {
      emit(current.copyWith(
        stepIndex: 0,
        selection: const TutorialNoneSelected(),
        hint: kTutorialSteps[0].hint,
      ));
    } else {
      emit(current.copyWith(
        selection: const TutorialNoneSelected(),
      ));
    }
  }

  Future<void> _onEndTurn(
      TutorialEndTurn event, Emitter<TutorialState> emit) async {
    final current = state;
    if (current is! TutorialInProgress) return;
    if (current.stepIndex != 4) return;

    // Show AI thinking
    emit(current.copyWith(
      isMyTurn: false,
      isAiThinking: true,
    ));

    // Delay for AI "thinking"
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    // AI deploys an operator at century 2 on opponent stream
    final aiCards = buildAiCards();
    final aiOp = createOperatorFromCard(
      card: aiCards.first,
      ownerId: 'ai-opponent',
      position: const StreamPosition(stream: 1, centuryIndex: 2),
      instanceId: 'ai-op-1',
    );

    final newOpponentStream = _addOperatorToStream(
      current.gameState.opponentStream,
      aiOp,
      2,
    );

    emit(TutorialInProgress(
      stepIndex: 5,
      gameState: current.gameState.copyWith(
        opponentStream: newOpponentStream,
        game: current.gameState.game.copyWith(
          currentTurn: 2,
          activePlayerId: 'player',
        ),
        actionPoints: 3,
      ),
      selection: const TutorialNoneSelected(),
      hint: kTutorialSteps[5].hint,
      isMyTurn: true,
      isAiThinking: false,
    ));
  }

  void _onSkip(SkipTutorial event, Emitter<TutorialState> emit) {
    emit(const TutorialComplete());
  }

  // ── Stream manipulation helpers ──

  List<Turnpoint> _addOperatorToStream(
    List<Turnpoint> stream,
    OperatorInstance op,
    int centuryIndex,
  ) {
    return [
      for (int i = 0; i < stream.length; i++)
        if (i == centuryIndex)
          stream[i].copyWith(
            operators: [...stream[i].operators, op],
          )
        else
          stream[i],
    ];
  }

  List<Turnpoint> _removeOperatorFromStream(
    List<Turnpoint> stream,
    OperatorInstance op,
  ) {
    return [
      for (final tp in stream)
        tp.copyWith(
          operators: tp.operators
              .where((o) => o.instanceId != op.instanceId)
              .toList(),
        ),
    ];
  }

  List<Turnpoint> _updateOperatorHp(
    List<Turnpoint> stream,
    OperatorInstance op,
    int newHp,
  ) {
    return [
      for (final tp in stream)
        tp.copyWith(
          operators: [
            for (final o in tp.operators)
              if (o.instanceId == op.instanceId)
                o.copyWith(currentHp: newHp)
              else
                o,
          ],
        ),
    ];
  }
}
