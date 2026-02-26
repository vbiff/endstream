import '../../models/client_game_state.dart';
import '../../models/enums.dart';
import '../../models/game.dart';
import '../../models/game_card.dart';
import '../../models/operator_instance.dart';
import '../../models/turnpoint.dart';

/// A hint displayed during a tutorial step.
class TutorialHint {
  const TutorialHint({required this.title, required this.body});

  final String title;
  final String body;
}

/// Definition for a single tutorial step.
class TutorialStepDef {
  const TutorialStepDef({
    required this.stepIndex,
    required this.hint,
  });

  final int stepIndex;
  final TutorialHint hint;
}

/// The 6 guided tutorial steps.
const kTutorialSteps = [
  TutorialStepDef(
    stepIndex: 0,
    hint: TutorialHint(
      title: 'SELECT A CARD',
      body: 'Tap any card in your hand to select it.',
    ),
  ),
  TutorialStepDef(
    stepIndex: 1,
    hint: TutorialHint(
      title: 'DEPLOY OPERATOR',
      body: 'Tap a turnpoint on your stream to deploy your operator.',
    ),
  ),
  TutorialStepDef(
    stepIndex: 2,
    hint: TutorialHint(
      title: 'SELECT OPERATOR',
      body: 'Tap your deployed operator on the board.',
    ),
  ),
  TutorialStepDef(
    stepIndex: 3,
    hint: TutorialHint(
      title: 'MOVE OPERATOR',
      body: 'Tap an adjacent turnpoint to move your operator.',
    ),
  ),
  TutorialStepDef(
    stepIndex: 4,
    hint: TutorialHint(
      title: 'END TURN',
      body: 'Tap END TURN to pass to your opponent.',
    ),
  ),
  TutorialStepDef(
    stepIndex: 5,
    hint: TutorialHint(
      title: 'ATTACK',
      body: 'Select your operator, then tap the enemy to attack.',
    ),
  ),
];

/// Player's starter hand for the tutorial.
List<GameCard> buildPlayerHand() {
  return const [
    GameCard(
      id: 'tut-op-1',
      name: 'Chrono Scout',
      type: CardType.operatorCard,
      cost: 1,
      hp: 3,
      attack: 2,
    ),
    GameCard(
      id: 'tut-tac-1',
      name: 'Temporal Shift',
      type: CardType.tactic,
      cost: 1,
    ),
    GameCard(
      id: 'tut-evt-1',
      name: 'Anomaly Pulse',
      type: CardType.event,
      cost: 2,
    ),
  ];
}

/// Cards used by the AI opponent in scripted moves.
List<GameCard> buildAiCards() {
  return const [
    GameCard(
      id: 'ai-op-1',
      name: 'Temporal Sentry',
      type: CardType.operatorCard,
      cost: 1,
      hp: 2,
      attack: 1,
    ),
  ];
}

/// Build the initial game state for the tutorial.
ClientGameState buildInitialTutorialState() {
  return ClientGameState(
    game: const Game(
      id: 'tutorial',
      player1Id: 'player',
      player2Id: 'ai-opponent',
      status: GameStatus.active,
      currentTurn: 1,
      activePlayerId: 'player',
    ),
    myStream: List.generate(
      6,
      (i) => Turnpoint(century: i),
    ),
    opponentStream: List.generate(
      6,
      (i) => Turnpoint(century: i),
    ),
    myHand: buildPlayerHand(),
    actionPoints: 3,
    maxActionPoints: 3,
    myPlayerId: 'player',
    opponentPlayerId: 'ai-opponent',
    myControllerHp: 10,
    opponentControllerHp: 10,
  );
}

/// Create an operator instance for deploying onto the board.
OperatorInstance createOperatorFromCard({
  required GameCard card,
  required String ownerId,
  required StreamPosition position,
  required String instanceId,
}) {
  return OperatorInstance(
    instanceId: instanceId,
    operatorCardId: card.id,
    ownerId: ownerId,
    currentHp: card.hp ?? 1,
    maxHp: card.hp ?? 1,
    attack: card.attack ?? 0,
    position: position,
  );
}
