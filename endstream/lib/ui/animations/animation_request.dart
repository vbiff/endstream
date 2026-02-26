import '../../core/models/operator_instance.dart';

/// Sealed class representing animation requests triggered by state diffs.
sealed class AnimationRequest {
  const AnimationRequest();
}

/// Combat: attacker hits defender, HP decreases, possible elimination.
class CombatAnimationRequest extends AnimationRequest {
  const CombatAnimationRequest({
    required this.attackerInstanceId,
    required this.defenderInstanceId,
    required this.attackerPosition,
    required this.defenderPosition,
    required this.damage,
    this.isElimination = false,
  });

  final String attackerInstanceId;
  final String defenderInstanceId;
  final StreamPosition attackerPosition;
  final StreamPosition defenderPosition;
  final int damage;
  final bool isElimination;
}

/// Card play: card leaves hand and arrives at target cell.
class CardPlayAnimationRequest extends AnimationRequest {
  const CardPlayAnimationRequest({
    required this.cardId,
    required this.targetPosition,
  });

  final String cardId;
  final StreamPosition targetPosition;
}

/// Movement: operator slides from one cell to another.
class MoveAnimationRequest extends AnimationRequest {
  const MoveAnimationRequest({
    required this.operatorInstanceId,
    required this.fromPosition,
    required this.toPosition,
  });

  final String operatorInstanceId;
  final StreamPosition fromPosition;
  final StreamPosition toPosition;
}
