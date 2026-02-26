import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required String fromPlayerId,
    required String toPlayerId,
    required String deckId,
    @Default(ChallengeStatus.pending) ChallengeStatus status,
    DateTime? createdAt,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);
}
