// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return _Challenge.fromJson(json);
}

/// @nodoc
mixin _$Challenge {
  String get id => throw _privateConstructorUsedError;
  String get fromPlayerId => throw _privateConstructorUsedError;
  String get toPlayerId => throw _privateConstructorUsedError;
  String get deckId => throw _privateConstructorUsedError;
  ChallengeStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Challenge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeCopyWith<Challenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCopyWith<$Res> {
  factory $ChallengeCopyWith(Challenge value, $Res Function(Challenge) then) =
      _$ChallengeCopyWithImpl<$Res, Challenge>;
  @useResult
  $Res call({
    String id,
    String fromPlayerId,
    String toPlayerId,
    String deckId,
    ChallengeStatus status,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$ChallengeCopyWithImpl<$Res, $Val extends Challenge>
    implements $ChallengeCopyWith<$Res> {
  _$ChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromPlayerId = null,
    Object? toPlayerId = null,
    Object? deckId = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fromPlayerId: null == fromPlayerId
                ? _value.fromPlayerId
                : fromPlayerId // ignore: cast_nullable_to_non_nullable
                      as String,
            toPlayerId: null == toPlayerId
                ? _value.toPlayerId
                : toPlayerId // ignore: cast_nullable_to_non_nullable
                      as String,
            deckId: null == deckId
                ? _value.deckId
                : deckId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ChallengeStatus,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
    _$ChallengeImpl value,
    $Res Function(_$ChallengeImpl) then,
  ) = __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fromPlayerId,
    String toPlayerId,
    String deckId,
    ChallengeStatus status,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
    _$ChallengeImpl _value,
    $Res Function(_$ChallengeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromPlayerId = null,
    Object? toPlayerId = null,
    Object? deckId = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ChallengeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fromPlayerId: null == fromPlayerId
            ? _value.fromPlayerId
            : fromPlayerId // ignore: cast_nullable_to_non_nullable
                  as String,
        toPlayerId: null == toPlayerId
            ? _value.toPlayerId
            : toPlayerId // ignore: cast_nullable_to_non_nullable
                  as String,
        deckId: null == deckId
            ? _value.deckId
            : deckId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ChallengeStatus,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl({
    required this.id,
    required this.fromPlayerId,
    required this.toPlayerId,
    required this.deckId,
    this.status = ChallengeStatus.pending,
    this.createdAt,
  });

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final String id;
  @override
  final String fromPlayerId;
  @override
  final String toPlayerId;
  @override
  final String deckId;
  @override
  @JsonKey()
  final ChallengeStatus status;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Challenge(id: $id, fromPlayerId: $fromPlayerId, toPlayerId: $toPlayerId, deckId: $deckId, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromPlayerId, fromPlayerId) ||
                other.fromPlayerId == fromPlayerId) &&
            (identical(other.toPlayerId, toPlayerId) ||
                other.toPlayerId == toPlayerId) &&
            (identical(other.deckId, deckId) || other.deckId == deckId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fromPlayerId,
    toPlayerId,
    deckId,
    status,
    createdAt,
  );

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeImplToJson(this);
  }
}

abstract class _Challenge implements Challenge {
  const factory _Challenge({
    required final String id,
    required final String fromPlayerId,
    required final String toPlayerId,
    required final String deckId,
    final ChallengeStatus status,
    final DateTime? createdAt,
  }) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  String get id;
  @override
  String get fromPlayerId;
  @override
  String get toPlayerId;
  @override
  String get deckId;
  @override
  ChallengeStatus get status;
  @override
  DateTime? get createdAt;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
