// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_1_id')
  String get player1Id => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_2_id')
  String get player2Id => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  String? get winnerId => throw _privateConstructorUsedError;
  int get currentTurn => throw _privateConstructorUsedError;
  String get activePlayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'game_mode')
  GameMode get gameMode => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastActionAt => throw _privateConstructorUsedError;

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'player_1_id') String player1Id,
    @JsonKey(name: 'player_2_id') String player2Id,
    GameStatus status,
    String? winnerId,
    int currentTurn,
    String activePlayerId,
    @JsonKey(name: 'game_mode') GameMode gameMode,
    DateTime? createdAt,
    DateTime? lastActionAt,
  });
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? player1Id = null,
    Object? player2Id = null,
    Object? status = null,
    Object? winnerId = freezed,
    Object? currentTurn = null,
    Object? activePlayerId = null,
    Object? gameMode = null,
    Object? createdAt = freezed,
    Object? lastActionAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            player1Id: null == player1Id
                ? _value.player1Id
                : player1Id // ignore: cast_nullable_to_non_nullable
                      as String,
            player2Id: null == player2Id
                ? _value.player2Id
                : player2Id // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GameStatus,
            winnerId: freezed == winnerId
                ? _value.winnerId
                : winnerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentTurn: null == currentTurn
                ? _value.currentTurn
                : currentTurn // ignore: cast_nullable_to_non_nullable
                      as int,
            activePlayerId: null == activePlayerId
                ? _value.activePlayerId
                : activePlayerId // ignore: cast_nullable_to_non_nullable
                      as String,
            gameMode: null == gameMode
                ? _value.gameMode
                : gameMode // ignore: cast_nullable_to_non_nullable
                      as GameMode,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastActionAt: freezed == lastActionAt
                ? _value.lastActionAt
                : lastActionAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
    _$GameImpl value,
    $Res Function(_$GameImpl) then,
  ) = __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'player_1_id') String player1Id,
    @JsonKey(name: 'player_2_id') String player2Id,
    GameStatus status,
    String? winnerId,
    int currentTurn,
    String activePlayerId,
    @JsonKey(name: 'game_mode') GameMode gameMode,
    DateTime? createdAt,
    DateTime? lastActionAt,
  });
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
    : super(_value, _then);

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? player1Id = null,
    Object? player2Id = null,
    Object? status = null,
    Object? winnerId = freezed,
    Object? currentTurn = null,
    Object? activePlayerId = null,
    Object? gameMode = null,
    Object? createdAt = freezed,
    Object? lastActionAt = freezed,
  }) {
    return _then(
      _$GameImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        player1Id: null == player1Id
            ? _value.player1Id
            : player1Id // ignore: cast_nullable_to_non_nullable
                  as String,
        player2Id: null == player2Id
            ? _value.player2Id
            : player2Id // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GameStatus,
        winnerId: freezed == winnerId
            ? _value.winnerId
            : winnerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentTurn: null == currentTurn
            ? _value.currentTurn
            : currentTurn // ignore: cast_nullable_to_non_nullable
                  as int,
        activePlayerId: null == activePlayerId
            ? _value.activePlayerId
            : activePlayerId // ignore: cast_nullable_to_non_nullable
                  as String,
        gameMode: null == gameMode
            ? _value.gameMode
            : gameMode // ignore: cast_nullable_to_non_nullable
                  as GameMode,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastActionAt: freezed == lastActionAt
            ? _value.lastActionAt
            : lastActionAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameImpl implements _Game {
  const _$GameImpl({
    required this.id,
    @JsonKey(name: 'player_1_id') required this.player1Id,
    @JsonKey(name: 'player_2_id') required this.player2Id,
    this.status = GameStatus.active,
    this.winnerId,
    this.currentTurn = 1,
    required this.activePlayerId,
    @JsonKey(name: 'game_mode') this.gameMode = GameMode.online,
    this.createdAt,
    this.lastActionAt,
  });

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'player_1_id')
  final String player1Id;
  @override
  @JsonKey(name: 'player_2_id')
  final String player2Id;
  @override
  @JsonKey()
  final GameStatus status;
  @override
  final String? winnerId;
  @override
  @JsonKey()
  final int currentTurn;
  @override
  final String activePlayerId;
  @override
  @JsonKey(name: 'game_mode')
  final GameMode gameMode;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastActionAt;

  @override
  String toString() {
    return 'Game(id: $id, player1Id: $player1Id, player2Id: $player2Id, status: $status, winnerId: $winnerId, currentTurn: $currentTurn, activePlayerId: $activePlayerId, gameMode: $gameMode, createdAt: $createdAt, lastActionAt: $lastActionAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.player1Id, player1Id) ||
                other.player1Id == player1Id) &&
            (identical(other.player2Id, player2Id) ||
                other.player2Id == player2Id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.currentTurn, currentTurn) ||
                other.currentTurn == currentTurn) &&
            (identical(other.activePlayerId, activePlayerId) ||
                other.activePlayerId == activePlayerId) &&
            (identical(other.gameMode, gameMode) ||
                other.gameMode == gameMode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActionAt, lastActionAt) ||
                other.lastActionAt == lastActionAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    player1Id,
    player2Id,
    status,
    winnerId,
    currentTurn,
    activePlayerId,
    gameMode,
    createdAt,
    lastActionAt,
  );

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(this);
  }
}

abstract class _Game implements Game {
  const factory _Game({
    required final String id,
    @JsonKey(name: 'player_1_id') required final String player1Id,
    @JsonKey(name: 'player_2_id') required final String player2Id,
    final GameStatus status,
    final String? winnerId,
    final int currentTurn,
    required final String activePlayerId,
    @JsonKey(name: 'game_mode') final GameMode gameMode,
    final DateTime? createdAt,
    final DateTime? lastActionAt,
  }) = _$GameImpl;

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'player_1_id')
  String get player1Id;
  @override
  @JsonKey(name: 'player_2_id')
  String get player2Id;
  @override
  GameStatus get status;
  @override
  String? get winnerId;
  @override
  int get currentTurn;
  @override
  String get activePlayerId;
  @override
  @JsonKey(name: 'game_mode')
  GameMode get gameMode;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastActionAt;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
