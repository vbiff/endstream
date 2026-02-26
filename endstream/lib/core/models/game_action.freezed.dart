// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameAction _$GameActionFromJson(Map<String, dynamic> json) {
  return _GameAction.fromJson(json);
}

/// @nodoc
mixin _$GameAction {
  String? get id => throw _privateConstructorUsedError;
  String get gameId => throw _privateConstructorUsedError;
  int get turn => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  ActionType get type => throw _privateConstructorUsedError;
  ActionSource? get source => throw _privateConstructorUsedError;
  ActionTarget? get target => throw _privateConstructorUsedError;
  ActionResult? get result => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GameAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameActionCopyWith<GameAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameActionCopyWith<$Res> {
  factory $GameActionCopyWith(
    GameAction value,
    $Res Function(GameAction) then,
  ) = _$GameActionCopyWithImpl<$Res, GameAction>;
  @useResult
  $Res call({
    String? id,
    String gameId,
    int turn,
    String playerId,
    ActionType type,
    ActionSource? source,
    ActionTarget? target,
    ActionResult? result,
    DateTime? createdAt,
  });

  $ActionSourceCopyWith<$Res>? get source;
  $ActionTargetCopyWith<$Res>? get target;
  $ActionResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$GameActionCopyWithImpl<$Res, $Val extends GameAction>
    implements $GameActionCopyWith<$Res> {
  _$GameActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gameId = null,
    Object? turn = null,
    Object? playerId = null,
    Object? type = null,
    Object? source = freezed,
    Object? target = freezed,
    Object? result = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            gameId: null == gameId
                ? _value.gameId
                : gameId // ignore: cast_nullable_to_non_nullable
                      as String,
            turn: null == turn
                ? _value.turn
                : turn // ignore: cast_nullable_to_non_nullable
                      as int,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ActionType,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as ActionSource?,
            target: freezed == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as ActionTarget?,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as ActionResult?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionSourceCopyWith<$Res>? get source {
    if (_value.source == null) {
      return null;
    }

    return $ActionSourceCopyWith<$Res>(_value.source!, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionTargetCopyWith<$Res>? get target {
    if (_value.target == null) {
      return null;
    }

    return $ActionTargetCopyWith<$Res>(_value.target!, (value) {
      return _then(_value.copyWith(target: value) as $Val);
    });
  }

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $ActionResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameActionImplCopyWith<$Res>
    implements $GameActionCopyWith<$Res> {
  factory _$$GameActionImplCopyWith(
    _$GameActionImpl value,
    $Res Function(_$GameActionImpl) then,
  ) = __$$GameActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String gameId,
    int turn,
    String playerId,
    ActionType type,
    ActionSource? source,
    ActionTarget? target,
    ActionResult? result,
    DateTime? createdAt,
  });

  @override
  $ActionSourceCopyWith<$Res>? get source;
  @override
  $ActionTargetCopyWith<$Res>? get target;
  @override
  $ActionResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$GameActionImplCopyWithImpl<$Res>
    extends _$GameActionCopyWithImpl<$Res, _$GameActionImpl>
    implements _$$GameActionImplCopyWith<$Res> {
  __$$GameActionImplCopyWithImpl(
    _$GameActionImpl _value,
    $Res Function(_$GameActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gameId = null,
    Object? turn = null,
    Object? playerId = null,
    Object? type = null,
    Object? source = freezed,
    Object? target = freezed,
    Object? result = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$GameActionImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        gameId: null == gameId
            ? _value.gameId
            : gameId // ignore: cast_nullable_to_non_nullable
                  as String,
        turn: null == turn
            ? _value.turn
            : turn // ignore: cast_nullable_to_non_nullable
                  as int,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ActionType,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as ActionSource?,
        target: freezed == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as ActionTarget?,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as ActionResult?,
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
class _$GameActionImpl implements _GameAction {
  const _$GameActionImpl({
    this.id,
    required this.gameId,
    required this.turn,
    required this.playerId,
    required this.type,
    this.source,
    this.target,
    this.result,
    this.createdAt,
  });

  factory _$GameActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameActionImplFromJson(json);

  @override
  final String? id;
  @override
  final String gameId;
  @override
  final int turn;
  @override
  final String playerId;
  @override
  final ActionType type;
  @override
  final ActionSource? source;
  @override
  final ActionTarget? target;
  @override
  final ActionResult? result;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'GameAction(id: $id, gameId: $gameId, turn: $turn, playerId: $playerId, type: $type, source: $source, target: $target, result: $result, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.turn, turn) || other.turn == turn) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    gameId,
    turn,
    playerId,
    type,
    source,
    target,
    result,
    createdAt,
  );

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameActionImplCopyWith<_$GameActionImpl> get copyWith =>
      __$$GameActionImplCopyWithImpl<_$GameActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameActionImplToJson(this);
  }
}

abstract class _GameAction implements GameAction {
  const factory _GameAction({
    final String? id,
    required final String gameId,
    required final int turn,
    required final String playerId,
    required final ActionType type,
    final ActionSource? source,
    final ActionTarget? target,
    final ActionResult? result,
    final DateTime? createdAt,
  }) = _$GameActionImpl;

  factory _GameAction.fromJson(Map<String, dynamic> json) =
      _$GameActionImpl.fromJson;

  @override
  String? get id;
  @override
  String get gameId;
  @override
  int get turn;
  @override
  String get playerId;
  @override
  ActionType get type;
  @override
  ActionSource? get source;
  @override
  ActionTarget? get target;
  @override
  ActionResult? get result;
  @override
  DateTime? get createdAt;

  /// Create a copy of GameAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameActionImplCopyWith<_$GameActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActionSource _$ActionSourceFromJson(Map<String, dynamic> json) {
  return _ActionSource.fromJson(json);
}

/// @nodoc
mixin _$ActionSource {
  String get type => throw _privateConstructorUsedError; // 'card', 'operator'
  String get id => throw _privateConstructorUsedError;
  Map<String, dynamic>? get position => throw _privateConstructorUsedError;

  /// Serializes this ActionSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionSourceCopyWith<ActionSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionSourceCopyWith<$Res> {
  factory $ActionSourceCopyWith(
    ActionSource value,
    $Res Function(ActionSource) then,
  ) = _$ActionSourceCopyWithImpl<$Res, ActionSource>;
  @useResult
  $Res call({String type, String id, Map<String, dynamic>? position});
}

/// @nodoc
class _$ActionSourceCopyWithImpl<$Res, $Val extends ActionSource>
    implements $ActionSourceCopyWith<$Res> {
  _$ActionSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? position = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActionSourceImplCopyWith<$Res>
    implements $ActionSourceCopyWith<$Res> {
  factory _$$ActionSourceImplCopyWith(
    _$ActionSourceImpl value,
    $Res Function(_$ActionSourceImpl) then,
  ) = __$$ActionSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String id, Map<String, dynamic>? position});
}

/// @nodoc
class __$$ActionSourceImplCopyWithImpl<$Res>
    extends _$ActionSourceCopyWithImpl<$Res, _$ActionSourceImpl>
    implements _$$ActionSourceImplCopyWith<$Res> {
  __$$ActionSourceImplCopyWithImpl(
    _$ActionSourceImpl _value,
    $Res Function(_$ActionSourceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? position = freezed,
  }) {
    return _then(
      _$ActionSourceImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        position: freezed == position
            ? _value._position
            : position // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActionSourceImpl implements _ActionSource {
  const _$ActionSourceImpl({
    required this.type,
    required this.id,
    final Map<String, dynamic>? position,
  }) : _position = position;

  factory _$ActionSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionSourceImplFromJson(json);

  @override
  final String type;
  // 'card', 'operator'
  @override
  final String id;
  final Map<String, dynamic>? _position;
  @override
  Map<String, dynamic>? get position {
    final value = _position;
    if (value == null) return null;
    if (_position is EqualUnmodifiableMapView) return _position;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ActionSource(type: $type, id: $id, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionSourceImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._position, _position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    id,
    const DeepCollectionEquality().hash(_position),
  );

  /// Create a copy of ActionSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionSourceImplCopyWith<_$ActionSourceImpl> get copyWith =>
      __$$ActionSourceImplCopyWithImpl<_$ActionSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionSourceImplToJson(this);
  }
}

abstract class _ActionSource implements ActionSource {
  const factory _ActionSource({
    required final String type,
    required final String id,
    final Map<String, dynamic>? position,
  }) = _$ActionSourceImpl;

  factory _ActionSource.fromJson(Map<String, dynamic> json) =
      _$ActionSourceImpl.fromJson;

  @override
  String get type; // 'card', 'operator'
  @override
  String get id;
  @override
  Map<String, dynamic>? get position;

  /// Create a copy of ActionSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionSourceImplCopyWith<_$ActionSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActionTarget _$ActionTargetFromJson(Map<String, dynamic> json) {
  return _ActionTarget.fromJson(json);
}

/// @nodoc
mixin _$ActionTarget {
  String get type =>
      throw _privateConstructorUsedError; // 'operator', 'turnpoint', 'controller'
  String get id => throw _privateConstructorUsedError;
  Map<String, dynamic>? get position => throw _privateConstructorUsedError;

  /// Serializes this ActionTarget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionTargetCopyWith<ActionTarget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionTargetCopyWith<$Res> {
  factory $ActionTargetCopyWith(
    ActionTarget value,
    $Res Function(ActionTarget) then,
  ) = _$ActionTargetCopyWithImpl<$Res, ActionTarget>;
  @useResult
  $Res call({String type, String id, Map<String, dynamic>? position});
}

/// @nodoc
class _$ActionTargetCopyWithImpl<$Res, $Val extends ActionTarget>
    implements $ActionTargetCopyWith<$Res> {
  _$ActionTargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? position = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActionTargetImplCopyWith<$Res>
    implements $ActionTargetCopyWith<$Res> {
  factory _$$ActionTargetImplCopyWith(
    _$ActionTargetImpl value,
    $Res Function(_$ActionTargetImpl) then,
  ) = __$$ActionTargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String id, Map<String, dynamic>? position});
}

/// @nodoc
class __$$ActionTargetImplCopyWithImpl<$Res>
    extends _$ActionTargetCopyWithImpl<$Res, _$ActionTargetImpl>
    implements _$$ActionTargetImplCopyWith<$Res> {
  __$$ActionTargetImplCopyWithImpl(
    _$ActionTargetImpl _value,
    $Res Function(_$ActionTargetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
    Object? position = freezed,
  }) {
    return _then(
      _$ActionTargetImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        position: freezed == position
            ? _value._position
            : position // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActionTargetImpl implements _ActionTarget {
  const _$ActionTargetImpl({
    required this.type,
    required this.id,
    final Map<String, dynamic>? position,
  }) : _position = position;

  factory _$ActionTargetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionTargetImplFromJson(json);

  @override
  final String type;
  // 'operator', 'turnpoint', 'controller'
  @override
  final String id;
  final Map<String, dynamic>? _position;
  @override
  Map<String, dynamic>? get position {
    final value = _position;
    if (value == null) return null;
    if (_position is EqualUnmodifiableMapView) return _position;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ActionTarget(type: $type, id: $id, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionTargetImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._position, _position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    id,
    const DeepCollectionEquality().hash(_position),
  );

  /// Create a copy of ActionTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionTargetImplCopyWith<_$ActionTargetImpl> get copyWith =>
      __$$ActionTargetImplCopyWithImpl<_$ActionTargetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionTargetImplToJson(this);
  }
}

abstract class _ActionTarget implements ActionTarget {
  const factory _ActionTarget({
    required final String type,
    required final String id,
    final Map<String, dynamic>? position,
  }) = _$ActionTargetImpl;

  factory _ActionTarget.fromJson(Map<String, dynamic> json) =
      _$ActionTargetImpl.fromJson;

  @override
  String get type; // 'operator', 'turnpoint', 'controller'
  @override
  String get id;
  @override
  Map<String, dynamic>? get position;

  /// Create a copy of ActionTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionTargetImplCopyWith<_$ActionTargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActionResult _$ActionResultFromJson(Map<String, dynamic> json) {
  return _ActionResult.fromJson(json);
}

/// @nodoc
mixin _$ActionResult {
  int? get damage => throw _privateConstructorUsedError;
  int? get healed => throw _privateConstructorUsedError;
  String? get statusApplied => throw _privateConstructorUsedError;
  bool? get eliminated => throw _privateConstructorUsedError;
  bool? get gameOver => throw _privateConstructorUsedError;
  String? get winnerId => throw _privateConstructorUsedError;

  /// Serializes this ActionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionResultCopyWith<ActionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionResultCopyWith<$Res> {
  factory $ActionResultCopyWith(
    ActionResult value,
    $Res Function(ActionResult) then,
  ) = _$ActionResultCopyWithImpl<$Res, ActionResult>;
  @useResult
  $Res call({
    int? damage,
    int? healed,
    String? statusApplied,
    bool? eliminated,
    bool? gameOver,
    String? winnerId,
  });
}

/// @nodoc
class _$ActionResultCopyWithImpl<$Res, $Val extends ActionResult>
    implements $ActionResultCopyWith<$Res> {
  _$ActionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? damage = freezed,
    Object? healed = freezed,
    Object? statusApplied = freezed,
    Object? eliminated = freezed,
    Object? gameOver = freezed,
    Object? winnerId = freezed,
  }) {
    return _then(
      _value.copyWith(
            damage: freezed == damage
                ? _value.damage
                : damage // ignore: cast_nullable_to_non_nullable
                      as int?,
            healed: freezed == healed
                ? _value.healed
                : healed // ignore: cast_nullable_to_non_nullable
                      as int?,
            statusApplied: freezed == statusApplied
                ? _value.statusApplied
                : statusApplied // ignore: cast_nullable_to_non_nullable
                      as String?,
            eliminated: freezed == eliminated
                ? _value.eliminated
                : eliminated // ignore: cast_nullable_to_non_nullable
                      as bool?,
            gameOver: freezed == gameOver
                ? _value.gameOver
                : gameOver // ignore: cast_nullable_to_non_nullable
                      as bool?,
            winnerId: freezed == winnerId
                ? _value.winnerId
                : winnerId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActionResultImplCopyWith<$Res>
    implements $ActionResultCopyWith<$Res> {
  factory _$$ActionResultImplCopyWith(
    _$ActionResultImpl value,
    $Res Function(_$ActionResultImpl) then,
  ) = __$$ActionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? damage,
    int? healed,
    String? statusApplied,
    bool? eliminated,
    bool? gameOver,
    String? winnerId,
  });
}

/// @nodoc
class __$$ActionResultImplCopyWithImpl<$Res>
    extends _$ActionResultCopyWithImpl<$Res, _$ActionResultImpl>
    implements _$$ActionResultImplCopyWith<$Res> {
  __$$ActionResultImplCopyWithImpl(
    _$ActionResultImpl _value,
    $Res Function(_$ActionResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? damage = freezed,
    Object? healed = freezed,
    Object? statusApplied = freezed,
    Object? eliminated = freezed,
    Object? gameOver = freezed,
    Object? winnerId = freezed,
  }) {
    return _then(
      _$ActionResultImpl(
        damage: freezed == damage
            ? _value.damage
            : damage // ignore: cast_nullable_to_non_nullable
                  as int?,
        healed: freezed == healed
            ? _value.healed
            : healed // ignore: cast_nullable_to_non_nullable
                  as int?,
        statusApplied: freezed == statusApplied
            ? _value.statusApplied
            : statusApplied // ignore: cast_nullable_to_non_nullable
                  as String?,
        eliminated: freezed == eliminated
            ? _value.eliminated
            : eliminated // ignore: cast_nullable_to_non_nullable
                  as bool?,
        gameOver: freezed == gameOver
            ? _value.gameOver
            : gameOver // ignore: cast_nullable_to_non_nullable
                  as bool?,
        winnerId: freezed == winnerId
            ? _value.winnerId
            : winnerId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActionResultImpl implements _ActionResult {
  const _$ActionResultImpl({
    this.damage,
    this.healed,
    this.statusApplied,
    this.eliminated,
    this.gameOver,
    this.winnerId,
  });

  factory _$ActionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionResultImplFromJson(json);

  @override
  final int? damage;
  @override
  final int? healed;
  @override
  final String? statusApplied;
  @override
  final bool? eliminated;
  @override
  final bool? gameOver;
  @override
  final String? winnerId;

  @override
  String toString() {
    return 'ActionResult(damage: $damage, healed: $healed, statusApplied: $statusApplied, eliminated: $eliminated, gameOver: $gameOver, winnerId: $winnerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionResultImpl &&
            (identical(other.damage, damage) || other.damage == damage) &&
            (identical(other.healed, healed) || other.healed == healed) &&
            (identical(other.statusApplied, statusApplied) ||
                other.statusApplied == statusApplied) &&
            (identical(other.eliminated, eliminated) ||
                other.eliminated == eliminated) &&
            (identical(other.gameOver, gameOver) ||
                other.gameOver == gameOver) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    damage,
    healed,
    statusApplied,
    eliminated,
    gameOver,
    winnerId,
  );

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionResultImplCopyWith<_$ActionResultImpl> get copyWith =>
      __$$ActionResultImplCopyWithImpl<_$ActionResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionResultImplToJson(this);
  }
}

abstract class _ActionResult implements ActionResult {
  const factory _ActionResult({
    final int? damage,
    final int? healed,
    final String? statusApplied,
    final bool? eliminated,
    final bool? gameOver,
    final String? winnerId,
  }) = _$ActionResultImpl;

  factory _ActionResult.fromJson(Map<String, dynamic> json) =
      _$ActionResultImpl.fromJson;

  @override
  int? get damage;
  @override
  int? get healed;
  @override
  String? get statusApplied;
  @override
  bool? get eliminated;
  @override
  bool? get gameOver;
  @override
  String? get winnerId;

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionResultImplCopyWith<_$ActionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
