// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClientGameState _$ClientGameStateFromJson(Map<String, dynamic> json) {
  return _ClientGameState.fromJson(json);
}

/// @nodoc
mixin _$ClientGameState {
  Game get game => throw _privateConstructorUsedError;
  @JsonKey(name: 'myStream')
  List<Turnpoint> get myStream => throw _privateConstructorUsedError;
  @JsonKey(name: 'opponentStream')
  List<Turnpoint> get opponentStream => throw _privateConstructorUsedError;
  @JsonKey(name: 'myHand')
  List<GameCard> get myHand => throw _privateConstructorUsedError;
  @JsonKey(name: 'actionPoints')
  int get actionPoints => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxActionPoints')
  int get maxActionPoints => throw _privateConstructorUsedError;
  GamePhase get phase => throw _privateConstructorUsedError;
  @JsonKey(name: 'myPlayerId')
  String get myPlayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'handSize')
  int get handSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'opponentHandSize')
  int get opponentHandSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'myControllerHp')
  int get myControllerHp => throw _privateConstructorUsedError;
  @JsonKey(name: 'opponentControllerHp')
  int get opponentControllerHp => throw _privateConstructorUsedError;
  @JsonKey(name: 'opponentPlayerId')
  String get opponentPlayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'myControllerId')
  String? get myControllerId => throw _privateConstructorUsedError;

  /// Serializes this ClientGameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientGameStateCopyWith<ClientGameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientGameStateCopyWith<$Res> {
  factory $ClientGameStateCopyWith(
    ClientGameState value,
    $Res Function(ClientGameState) then,
  ) = _$ClientGameStateCopyWithImpl<$Res, ClientGameState>;
  @useResult
  $Res call({
    Game game,
    @JsonKey(name: 'myStream') List<Turnpoint> myStream,
    @JsonKey(name: 'opponentStream') List<Turnpoint> opponentStream,
    @JsonKey(name: 'myHand') List<GameCard> myHand,
    @JsonKey(name: 'actionPoints') int actionPoints,
    @JsonKey(name: 'maxActionPoints') int maxActionPoints,
    GamePhase phase,
    @JsonKey(name: 'myPlayerId') String myPlayerId,
    @JsonKey(name: 'handSize') int handSize,
    @JsonKey(name: 'opponentHandSize') int opponentHandSize,
    @JsonKey(name: 'myControllerHp') int myControllerHp,
    @JsonKey(name: 'opponentControllerHp') int opponentControllerHp,
    @JsonKey(name: 'opponentPlayerId') String opponentPlayerId,
    @JsonKey(name: 'myControllerId') String? myControllerId,
  });

  $GameCopyWith<$Res> get game;
}

/// @nodoc
class _$ClientGameStateCopyWithImpl<$Res, $Val extends ClientGameState>
    implements $ClientGameStateCopyWith<$Res> {
  _$ClientGameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientGameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? myStream = null,
    Object? opponentStream = null,
    Object? myHand = null,
    Object? actionPoints = null,
    Object? maxActionPoints = null,
    Object? phase = null,
    Object? myPlayerId = null,
    Object? handSize = null,
    Object? opponentHandSize = null,
    Object? myControllerHp = null,
    Object? opponentControllerHp = null,
    Object? opponentPlayerId = null,
    Object? myControllerId = freezed,
  }) {
    return _then(
      _value.copyWith(
            game: null == game
                ? _value.game
                : game // ignore: cast_nullable_to_non_nullable
                      as Game,
            myStream: null == myStream
                ? _value.myStream
                : myStream // ignore: cast_nullable_to_non_nullable
                      as List<Turnpoint>,
            opponentStream: null == opponentStream
                ? _value.opponentStream
                : opponentStream // ignore: cast_nullable_to_non_nullable
                      as List<Turnpoint>,
            myHand: null == myHand
                ? _value.myHand
                : myHand // ignore: cast_nullable_to_non_nullable
                      as List<GameCard>,
            actionPoints: null == actionPoints
                ? _value.actionPoints
                : actionPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            maxActionPoints: null == maxActionPoints
                ? _value.maxActionPoints
                : maxActionPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            phase: null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as GamePhase,
            myPlayerId: null == myPlayerId
                ? _value.myPlayerId
                : myPlayerId // ignore: cast_nullable_to_non_nullable
                      as String,
            handSize: null == handSize
                ? _value.handSize
                : handSize // ignore: cast_nullable_to_non_nullable
                      as int,
            opponentHandSize: null == opponentHandSize
                ? _value.opponentHandSize
                : opponentHandSize // ignore: cast_nullable_to_non_nullable
                      as int,
            myControllerHp: null == myControllerHp
                ? _value.myControllerHp
                : myControllerHp // ignore: cast_nullable_to_non_nullable
                      as int,
            opponentControllerHp: null == opponentControllerHp
                ? _value.opponentControllerHp
                : opponentControllerHp // ignore: cast_nullable_to_non_nullable
                      as int,
            opponentPlayerId: null == opponentPlayerId
                ? _value.opponentPlayerId
                : opponentPlayerId // ignore: cast_nullable_to_non_nullable
                      as String,
            myControllerId: freezed == myControllerId
                ? _value.myControllerId
                : myControllerId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ClientGameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameCopyWith<$Res> get game {
    return $GameCopyWith<$Res>(_value.game, (value) {
      return _then(_value.copyWith(game: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientGameStateImplCopyWith<$Res>
    implements $ClientGameStateCopyWith<$Res> {
  factory _$$ClientGameStateImplCopyWith(
    _$ClientGameStateImpl value,
    $Res Function(_$ClientGameStateImpl) then,
  ) = __$$ClientGameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Game game,
    @JsonKey(name: 'myStream') List<Turnpoint> myStream,
    @JsonKey(name: 'opponentStream') List<Turnpoint> opponentStream,
    @JsonKey(name: 'myHand') List<GameCard> myHand,
    @JsonKey(name: 'actionPoints') int actionPoints,
    @JsonKey(name: 'maxActionPoints') int maxActionPoints,
    GamePhase phase,
    @JsonKey(name: 'myPlayerId') String myPlayerId,
    @JsonKey(name: 'handSize') int handSize,
    @JsonKey(name: 'opponentHandSize') int opponentHandSize,
    @JsonKey(name: 'myControllerHp') int myControllerHp,
    @JsonKey(name: 'opponentControllerHp') int opponentControllerHp,
    @JsonKey(name: 'opponentPlayerId') String opponentPlayerId,
    @JsonKey(name: 'myControllerId') String? myControllerId,
  });

  @override
  $GameCopyWith<$Res> get game;
}

/// @nodoc
class __$$ClientGameStateImplCopyWithImpl<$Res>
    extends _$ClientGameStateCopyWithImpl<$Res, _$ClientGameStateImpl>
    implements _$$ClientGameStateImplCopyWith<$Res> {
  __$$ClientGameStateImplCopyWithImpl(
    _$ClientGameStateImpl _value,
    $Res Function(_$ClientGameStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientGameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? myStream = null,
    Object? opponentStream = null,
    Object? myHand = null,
    Object? actionPoints = null,
    Object? maxActionPoints = null,
    Object? phase = null,
    Object? myPlayerId = null,
    Object? handSize = null,
    Object? opponentHandSize = null,
    Object? myControllerHp = null,
    Object? opponentControllerHp = null,
    Object? opponentPlayerId = null,
    Object? myControllerId = freezed,
  }) {
    return _then(
      _$ClientGameStateImpl(
        game: null == game
            ? _value.game
            : game // ignore: cast_nullable_to_non_nullable
                  as Game,
        myStream: null == myStream
            ? _value._myStream
            : myStream // ignore: cast_nullable_to_non_nullable
                  as List<Turnpoint>,
        opponentStream: null == opponentStream
            ? _value._opponentStream
            : opponentStream // ignore: cast_nullable_to_non_nullable
                  as List<Turnpoint>,
        myHand: null == myHand
            ? _value._myHand
            : myHand // ignore: cast_nullable_to_non_nullable
                  as List<GameCard>,
        actionPoints: null == actionPoints
            ? _value.actionPoints
            : actionPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        maxActionPoints: null == maxActionPoints
            ? _value.maxActionPoints
            : maxActionPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as GamePhase,
        myPlayerId: null == myPlayerId
            ? _value.myPlayerId
            : myPlayerId // ignore: cast_nullable_to_non_nullable
                  as String,
        handSize: null == handSize
            ? _value.handSize
            : handSize // ignore: cast_nullable_to_non_nullable
                  as int,
        opponentHandSize: null == opponentHandSize
            ? _value.opponentHandSize
            : opponentHandSize // ignore: cast_nullable_to_non_nullable
                  as int,
        myControllerHp: null == myControllerHp
            ? _value.myControllerHp
            : myControllerHp // ignore: cast_nullable_to_non_nullable
                  as int,
        opponentControllerHp: null == opponentControllerHp
            ? _value.opponentControllerHp
            : opponentControllerHp // ignore: cast_nullable_to_non_nullable
                  as int,
        opponentPlayerId: null == opponentPlayerId
            ? _value.opponentPlayerId
            : opponentPlayerId // ignore: cast_nullable_to_non_nullable
                  as String,
        myControllerId: freezed == myControllerId
            ? _value.myControllerId
            : myControllerId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientGameStateImpl implements _ClientGameState {
  const _$ClientGameStateImpl({
    required this.game,
    @JsonKey(name: 'myStream') required final List<Turnpoint> myStream,
    @JsonKey(name: 'opponentStream')
    required final List<Turnpoint> opponentStream,
    @JsonKey(name: 'myHand') required final List<GameCard> myHand,
    @JsonKey(name: 'actionPoints') this.actionPoints = 3,
    @JsonKey(name: 'maxActionPoints') this.maxActionPoints = 3,
    this.phase = GamePhase.actionPhase,
    @JsonKey(name: 'myPlayerId') required this.myPlayerId,
    @JsonKey(name: 'handSize') this.handSize = 0,
    @JsonKey(name: 'opponentHandSize') this.opponentHandSize = 0,
    @JsonKey(name: 'myControllerHp') this.myControllerHp = 10,
    @JsonKey(name: 'opponentControllerHp') this.opponentControllerHp = 10,
    @JsonKey(name: 'opponentPlayerId') this.opponentPlayerId = '',
    @JsonKey(name: 'myControllerId') this.myControllerId,
  }) : _myStream = myStream,
       _opponentStream = opponentStream,
       _myHand = myHand;

  factory _$ClientGameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientGameStateImplFromJson(json);

  @override
  final Game game;
  final List<Turnpoint> _myStream;
  @override
  @JsonKey(name: 'myStream')
  List<Turnpoint> get myStream {
    if (_myStream is EqualUnmodifiableListView) return _myStream;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myStream);
  }

  final List<Turnpoint> _opponentStream;
  @override
  @JsonKey(name: 'opponentStream')
  List<Turnpoint> get opponentStream {
    if (_opponentStream is EqualUnmodifiableListView) return _opponentStream;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opponentStream);
  }

  final List<GameCard> _myHand;
  @override
  @JsonKey(name: 'myHand')
  List<GameCard> get myHand {
    if (_myHand is EqualUnmodifiableListView) return _myHand;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myHand);
  }

  @override
  @JsonKey(name: 'actionPoints')
  final int actionPoints;
  @override
  @JsonKey(name: 'maxActionPoints')
  final int maxActionPoints;
  @override
  @JsonKey()
  final GamePhase phase;
  @override
  @JsonKey(name: 'myPlayerId')
  final String myPlayerId;
  @override
  @JsonKey(name: 'handSize')
  final int handSize;
  @override
  @JsonKey(name: 'opponentHandSize')
  final int opponentHandSize;
  @override
  @JsonKey(name: 'myControllerHp')
  final int myControllerHp;
  @override
  @JsonKey(name: 'opponentControllerHp')
  final int opponentControllerHp;
  @override
  @JsonKey(name: 'opponentPlayerId')
  final String opponentPlayerId;
  @override
  @JsonKey(name: 'myControllerId')
  final String? myControllerId;

  @override
  String toString() {
    return 'ClientGameState(game: $game, myStream: $myStream, opponentStream: $opponentStream, myHand: $myHand, actionPoints: $actionPoints, maxActionPoints: $maxActionPoints, phase: $phase, myPlayerId: $myPlayerId, handSize: $handSize, opponentHandSize: $opponentHandSize, myControllerHp: $myControllerHp, opponentControllerHp: $opponentControllerHp, opponentPlayerId: $opponentPlayerId, myControllerId: $myControllerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientGameStateImpl &&
            (identical(other.game, game) || other.game == game) &&
            const DeepCollectionEquality().equals(other._myStream, _myStream) &&
            const DeepCollectionEquality().equals(
              other._opponentStream,
              _opponentStream,
            ) &&
            const DeepCollectionEquality().equals(other._myHand, _myHand) &&
            (identical(other.actionPoints, actionPoints) ||
                other.actionPoints == actionPoints) &&
            (identical(other.maxActionPoints, maxActionPoints) ||
                other.maxActionPoints == maxActionPoints) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.myPlayerId, myPlayerId) ||
                other.myPlayerId == myPlayerId) &&
            (identical(other.handSize, handSize) ||
                other.handSize == handSize) &&
            (identical(other.opponentHandSize, opponentHandSize) ||
                other.opponentHandSize == opponentHandSize) &&
            (identical(other.myControllerHp, myControllerHp) ||
                other.myControllerHp == myControllerHp) &&
            (identical(other.opponentControllerHp, opponentControllerHp) ||
                other.opponentControllerHp == opponentControllerHp) &&
            (identical(other.opponentPlayerId, opponentPlayerId) ||
                other.opponentPlayerId == opponentPlayerId) &&
            (identical(other.myControllerId, myControllerId) ||
                other.myControllerId == myControllerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    game,
    const DeepCollectionEquality().hash(_myStream),
    const DeepCollectionEquality().hash(_opponentStream),
    const DeepCollectionEquality().hash(_myHand),
    actionPoints,
    maxActionPoints,
    phase,
    myPlayerId,
    handSize,
    opponentHandSize,
    myControllerHp,
    opponentControllerHp,
    opponentPlayerId,
    myControllerId,
  );

  /// Create a copy of ClientGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientGameStateImplCopyWith<_$ClientGameStateImpl> get copyWith =>
      __$$ClientGameStateImplCopyWithImpl<_$ClientGameStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientGameStateImplToJson(this);
  }
}

abstract class _ClientGameState implements ClientGameState {
  const factory _ClientGameState({
    required final Game game,
    @JsonKey(name: 'myStream') required final List<Turnpoint> myStream,
    @JsonKey(name: 'opponentStream')
    required final List<Turnpoint> opponentStream,
    @JsonKey(name: 'myHand') required final List<GameCard> myHand,
    @JsonKey(name: 'actionPoints') final int actionPoints,
    @JsonKey(name: 'maxActionPoints') final int maxActionPoints,
    final GamePhase phase,
    @JsonKey(name: 'myPlayerId') required final String myPlayerId,
    @JsonKey(name: 'handSize') final int handSize,
    @JsonKey(name: 'opponentHandSize') final int opponentHandSize,
    @JsonKey(name: 'myControllerHp') final int myControllerHp,
    @JsonKey(name: 'opponentControllerHp') final int opponentControllerHp,
    @JsonKey(name: 'opponentPlayerId') final String opponentPlayerId,
    @JsonKey(name: 'myControllerId') final String? myControllerId,
  }) = _$ClientGameStateImpl;

  factory _ClientGameState.fromJson(Map<String, dynamic> json) =
      _$ClientGameStateImpl.fromJson;

  @override
  Game get game;
  @override
  @JsonKey(name: 'myStream')
  List<Turnpoint> get myStream;
  @override
  @JsonKey(name: 'opponentStream')
  List<Turnpoint> get opponentStream;
  @override
  @JsonKey(name: 'myHand')
  List<GameCard> get myHand;
  @override
  @JsonKey(name: 'actionPoints')
  int get actionPoints;
  @override
  @JsonKey(name: 'maxActionPoints')
  int get maxActionPoints;
  @override
  GamePhase get phase;
  @override
  @JsonKey(name: 'myPlayerId')
  String get myPlayerId;
  @override
  @JsonKey(name: 'handSize')
  int get handSize;
  @override
  @JsonKey(name: 'opponentHandSize')
  int get opponentHandSize;
  @override
  @JsonKey(name: 'myControllerHp')
  int get myControllerHp;
  @override
  @JsonKey(name: 'opponentControllerHp')
  int get opponentControllerHp;
  @override
  @JsonKey(name: 'opponentPlayerId')
  String get opponentPlayerId;
  @override
  @JsonKey(name: 'myControllerId')
  String? get myControllerId;

  /// Create a copy of ClientGameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientGameStateImplCopyWith<_$ClientGameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
