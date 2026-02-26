part of 'tutorial_bloc.dart';

sealed class TutorialEvent extends Equatable {
  const TutorialEvent();

  @override
  List<Object?> get props => [];
}

final class StartTutorial extends TutorialEvent {
  const StartTutorial();
}

final class TutorialSelectCard extends TutorialEvent {
  const TutorialSelectCard(this.card);
  final GameCard card;

  @override
  List<Object?> get props => [card.id];
}

final class TutorialSelectOperator extends TutorialEvent {
  const TutorialSelectOperator(this.operator);
  final OperatorInstance operator;

  @override
  List<Object?> get props => [operator.instanceId];
}

final class TutorialSelectTarget extends TutorialEvent {
  const TutorialSelectTarget(this.position);
  final StreamPosition position;

  @override
  List<Object?> get props => [position];
}

final class TutorialConfirmAction extends TutorialEvent {
  const TutorialConfirmAction();
}

final class TutorialCancelAction extends TutorialEvent {
  const TutorialCancelAction();
}

final class TutorialEndTurn extends TutorialEvent {
  const TutorialEndTurn();
}

final class SkipTutorial extends TutorialEvent {
  const SkipTutorial();
}
