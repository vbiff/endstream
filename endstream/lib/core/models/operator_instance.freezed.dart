// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operator_instance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OperatorInstance _$OperatorInstanceFromJson(Map<String, dynamic> json) {
  return _OperatorInstance.fromJson(json);
}

/// @nodoc
mixin _$OperatorInstance {
  String get operatorCardId => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  int get currentHp => throw _privateConstructorUsedError;
  int get maxHp => throw _privateConstructorUsedError;
  int get attack => throw _privateConstructorUsedError;
  StreamPosition get position => throw _privateConstructorUsedError;
  List<StatusEffect> get statusEffects => throw _privateConstructorUsedError;
  bool get hasActedThisTurn => throw _privateConstructorUsedError;
  List<String> get equipmentCardIds => throw _privateConstructorUsedError;

  /// Serializes this OperatorInstance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OperatorInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OperatorInstanceCopyWith<OperatorInstance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperatorInstanceCopyWith<$Res> {
  factory $OperatorInstanceCopyWith(
    OperatorInstance value,
    $Res Function(OperatorInstance) then,
  ) = _$OperatorInstanceCopyWithImpl<$Res, OperatorInstance>;
  @useResult
  $Res call({
    String operatorCardId,
    String ownerId,
    int currentHp,
    int maxHp,
    int attack,
    StreamPosition position,
    List<StatusEffect> statusEffects,
    bool hasActedThisTurn,
    List<String> equipmentCardIds,
  });

  $StreamPositionCopyWith<$Res> get position;
}

/// @nodoc
class _$OperatorInstanceCopyWithImpl<$Res, $Val extends OperatorInstance>
    implements $OperatorInstanceCopyWith<$Res> {
  _$OperatorInstanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OperatorInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operatorCardId = null,
    Object? ownerId = null,
    Object? currentHp = null,
    Object? maxHp = null,
    Object? attack = null,
    Object? position = null,
    Object? statusEffects = null,
    Object? hasActedThisTurn = null,
    Object? equipmentCardIds = null,
  }) {
    return _then(
      _value.copyWith(
            operatorCardId: null == operatorCardId
                ? _value.operatorCardId
                : operatorCardId // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentHp: null == currentHp
                ? _value.currentHp
                : currentHp // ignore: cast_nullable_to_non_nullable
                      as int,
            maxHp: null == maxHp
                ? _value.maxHp
                : maxHp // ignore: cast_nullable_to_non_nullable
                      as int,
            attack: null == attack
                ? _value.attack
                : attack // ignore: cast_nullable_to_non_nullable
                      as int,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as StreamPosition,
            statusEffects: null == statusEffects
                ? _value.statusEffects
                : statusEffects // ignore: cast_nullable_to_non_nullable
                      as List<StatusEffect>,
            hasActedThisTurn: null == hasActedThisTurn
                ? _value.hasActedThisTurn
                : hasActedThisTurn // ignore: cast_nullable_to_non_nullable
                      as bool,
            equipmentCardIds: null == equipmentCardIds
                ? _value.equipmentCardIds
                : equipmentCardIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of OperatorInstance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamPositionCopyWith<$Res> get position {
    return $StreamPositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OperatorInstanceImplCopyWith<$Res>
    implements $OperatorInstanceCopyWith<$Res> {
  factory _$$OperatorInstanceImplCopyWith(
    _$OperatorInstanceImpl value,
    $Res Function(_$OperatorInstanceImpl) then,
  ) = __$$OperatorInstanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String operatorCardId,
    String ownerId,
    int currentHp,
    int maxHp,
    int attack,
    StreamPosition position,
    List<StatusEffect> statusEffects,
    bool hasActedThisTurn,
    List<String> equipmentCardIds,
  });

  @override
  $StreamPositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$OperatorInstanceImplCopyWithImpl<$Res>
    extends _$OperatorInstanceCopyWithImpl<$Res, _$OperatorInstanceImpl>
    implements _$$OperatorInstanceImplCopyWith<$Res> {
  __$$OperatorInstanceImplCopyWithImpl(
    _$OperatorInstanceImpl _value,
    $Res Function(_$OperatorInstanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OperatorInstance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operatorCardId = null,
    Object? ownerId = null,
    Object? currentHp = null,
    Object? maxHp = null,
    Object? attack = null,
    Object? position = null,
    Object? statusEffects = null,
    Object? hasActedThisTurn = null,
    Object? equipmentCardIds = null,
  }) {
    return _then(
      _$OperatorInstanceImpl(
        operatorCardId: null == operatorCardId
            ? _value.operatorCardId
            : operatorCardId // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentHp: null == currentHp
            ? _value.currentHp
            : currentHp // ignore: cast_nullable_to_non_nullable
                  as int,
        maxHp: null == maxHp
            ? _value.maxHp
            : maxHp // ignore: cast_nullable_to_non_nullable
                  as int,
        attack: null == attack
            ? _value.attack
            : attack // ignore: cast_nullable_to_non_nullable
                  as int,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as StreamPosition,
        statusEffects: null == statusEffects
            ? _value._statusEffects
            : statusEffects // ignore: cast_nullable_to_non_nullable
                  as List<StatusEffect>,
        hasActedThisTurn: null == hasActedThisTurn
            ? _value.hasActedThisTurn
            : hasActedThisTurn // ignore: cast_nullable_to_non_nullable
                  as bool,
        equipmentCardIds: null == equipmentCardIds
            ? _value._equipmentCardIds
            : equipmentCardIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OperatorInstanceImpl implements _OperatorInstance {
  const _$OperatorInstanceImpl({
    required this.operatorCardId,
    required this.ownerId,
    required this.currentHp,
    required this.maxHp,
    required this.attack,
    required this.position,
    final List<StatusEffect> statusEffects = const [],
    this.hasActedThisTurn = false,
    final List<String> equipmentCardIds = const [],
  }) : _statusEffects = statusEffects,
       _equipmentCardIds = equipmentCardIds;

  factory _$OperatorInstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$OperatorInstanceImplFromJson(json);

  @override
  final String operatorCardId;
  @override
  final String ownerId;
  @override
  final int currentHp;
  @override
  final int maxHp;
  @override
  final int attack;
  @override
  final StreamPosition position;
  final List<StatusEffect> _statusEffects;
  @override
  @JsonKey()
  List<StatusEffect> get statusEffects {
    if (_statusEffects is EqualUnmodifiableListView) return _statusEffects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statusEffects);
  }

  @override
  @JsonKey()
  final bool hasActedThisTurn;
  final List<String> _equipmentCardIds;
  @override
  @JsonKey()
  List<String> get equipmentCardIds {
    if (_equipmentCardIds is EqualUnmodifiableListView)
      return _equipmentCardIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipmentCardIds);
  }

  @override
  String toString() {
    return 'OperatorInstance(operatorCardId: $operatorCardId, ownerId: $ownerId, currentHp: $currentHp, maxHp: $maxHp, attack: $attack, position: $position, statusEffects: $statusEffects, hasActedThisTurn: $hasActedThisTurn, equipmentCardIds: $equipmentCardIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperatorInstanceImpl &&
            (identical(other.operatorCardId, operatorCardId) ||
                other.operatorCardId == operatorCardId) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.currentHp, currentHp) ||
                other.currentHp == currentHp) &&
            (identical(other.maxHp, maxHp) || other.maxHp == maxHp) &&
            (identical(other.attack, attack) || other.attack == attack) &&
            (identical(other.position, position) ||
                other.position == position) &&
            const DeepCollectionEquality().equals(
              other._statusEffects,
              _statusEffects,
            ) &&
            (identical(other.hasActedThisTurn, hasActedThisTurn) ||
                other.hasActedThisTurn == hasActedThisTurn) &&
            const DeepCollectionEquality().equals(
              other._equipmentCardIds,
              _equipmentCardIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    operatorCardId,
    ownerId,
    currentHp,
    maxHp,
    attack,
    position,
    const DeepCollectionEquality().hash(_statusEffects),
    hasActedThisTurn,
    const DeepCollectionEquality().hash(_equipmentCardIds),
  );

  /// Create a copy of OperatorInstance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperatorInstanceImplCopyWith<_$OperatorInstanceImpl> get copyWith =>
      __$$OperatorInstanceImplCopyWithImpl<_$OperatorInstanceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OperatorInstanceImplToJson(this);
  }
}

abstract class _OperatorInstance implements OperatorInstance {
  const factory _OperatorInstance({
    required final String operatorCardId,
    required final String ownerId,
    required final int currentHp,
    required final int maxHp,
    required final int attack,
    required final StreamPosition position,
    final List<StatusEffect> statusEffects,
    final bool hasActedThisTurn,
    final List<String> equipmentCardIds,
  }) = _$OperatorInstanceImpl;

  factory _OperatorInstance.fromJson(Map<String, dynamic> json) =
      _$OperatorInstanceImpl.fromJson;

  @override
  String get operatorCardId;
  @override
  String get ownerId;
  @override
  int get currentHp;
  @override
  int get maxHp;
  @override
  int get attack;
  @override
  StreamPosition get position;
  @override
  List<StatusEffect> get statusEffects;
  @override
  bool get hasActedThisTurn;
  @override
  List<String> get equipmentCardIds;

  /// Create a copy of OperatorInstance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperatorInstanceImplCopyWith<_$OperatorInstanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StreamPosition _$StreamPositionFromJson(Map<String, dynamic> json) {
  return _StreamPosition.fromJson(json);
}

/// @nodoc
mixin _$StreamPosition {
  int get stream => throw _privateConstructorUsedError; // 0 or 1
  int get centuryIndex => throw _privateConstructorUsedError;

  /// Serializes this StreamPosition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreamPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamPositionCopyWith<StreamPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamPositionCopyWith<$Res> {
  factory $StreamPositionCopyWith(
    StreamPosition value,
    $Res Function(StreamPosition) then,
  ) = _$StreamPositionCopyWithImpl<$Res, StreamPosition>;
  @useResult
  $Res call({int stream, int centuryIndex});
}

/// @nodoc
class _$StreamPositionCopyWithImpl<$Res, $Val extends StreamPosition>
    implements $StreamPositionCopyWith<$Res> {
  _$StreamPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? stream = null, Object? centuryIndex = null}) {
    return _then(
      _value.copyWith(
            stream: null == stream
                ? _value.stream
                : stream // ignore: cast_nullable_to_non_nullable
                      as int,
            centuryIndex: null == centuryIndex
                ? _value.centuryIndex
                : centuryIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StreamPositionImplCopyWith<$Res>
    implements $StreamPositionCopyWith<$Res> {
  factory _$$StreamPositionImplCopyWith(
    _$StreamPositionImpl value,
    $Res Function(_$StreamPositionImpl) then,
  ) = __$$StreamPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int stream, int centuryIndex});
}

/// @nodoc
class __$$StreamPositionImplCopyWithImpl<$Res>
    extends _$StreamPositionCopyWithImpl<$Res, _$StreamPositionImpl>
    implements _$$StreamPositionImplCopyWith<$Res> {
  __$$StreamPositionImplCopyWithImpl(
    _$StreamPositionImpl _value,
    $Res Function(_$StreamPositionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? stream = null, Object? centuryIndex = null}) {
    return _then(
      _$StreamPositionImpl(
        stream: null == stream
            ? _value.stream
            : stream // ignore: cast_nullable_to_non_nullable
                  as int,
        centuryIndex: null == centuryIndex
            ? _value.centuryIndex
            : centuryIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StreamPositionImpl implements _StreamPosition {
  const _$StreamPositionImpl({
    required this.stream,
    required this.centuryIndex,
  });

  factory _$StreamPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamPositionImplFromJson(json);

  @override
  final int stream;
  // 0 or 1
  @override
  final int centuryIndex;

  @override
  String toString() {
    return 'StreamPosition(stream: $stream, centuryIndex: $centuryIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamPositionImpl &&
            (identical(other.stream, stream) || other.stream == stream) &&
            (identical(other.centuryIndex, centuryIndex) ||
                other.centuryIndex == centuryIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stream, centuryIndex);

  /// Create a copy of StreamPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamPositionImplCopyWith<_$StreamPositionImpl> get copyWith =>
      __$$StreamPositionImplCopyWithImpl<_$StreamPositionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StreamPositionImplToJson(this);
  }
}

abstract class _StreamPosition implements StreamPosition {
  const factory _StreamPosition({
    required final int stream,
    required final int centuryIndex,
  }) = _$StreamPositionImpl;

  factory _StreamPosition.fromJson(Map<String, dynamic> json) =
      _$StreamPositionImpl.fromJson;

  @override
  int get stream; // 0 or 1
  @override
  int get centuryIndex;

  /// Create a copy of StreamPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamPositionImplCopyWith<_$StreamPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusEffect _$StatusEffectFromJson(Map<String, dynamic> json) {
  return _StatusEffect.fromJson(json);
}

/// @nodoc
mixin _$StatusEffect {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get turnsRemaining => throw _privateConstructorUsedError;
  int? get attackModifier => throw _privateConstructorUsedError;
  bool? get movementBlocked => throw _privateConstructorUsedError;

  /// Serializes this StatusEffect to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusEffectCopyWith<StatusEffect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusEffectCopyWith<$Res> {
  factory $StatusEffectCopyWith(
    StatusEffect value,
    $Res Function(StatusEffect) then,
  ) = _$StatusEffectCopyWithImpl<$Res, StatusEffect>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int turnsRemaining,
    int? attackModifier,
    bool? movementBlocked,
  });
}

/// @nodoc
class _$StatusEffectCopyWithImpl<$Res, $Val extends StatusEffect>
    implements $StatusEffectCopyWith<$Res> {
  _$StatusEffectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? turnsRemaining = null,
    Object? attackModifier = freezed,
    Object? movementBlocked = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            turnsRemaining: null == turnsRemaining
                ? _value.turnsRemaining
                : turnsRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
            attackModifier: freezed == attackModifier
                ? _value.attackModifier
                : attackModifier // ignore: cast_nullable_to_non_nullable
                      as int?,
            movementBlocked: freezed == movementBlocked
                ? _value.movementBlocked
                : movementBlocked // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StatusEffectImplCopyWith<$Res>
    implements $StatusEffectCopyWith<$Res> {
  factory _$$StatusEffectImplCopyWith(
    _$StatusEffectImpl value,
    $Res Function(_$StatusEffectImpl) then,
  ) = __$$StatusEffectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int turnsRemaining,
    int? attackModifier,
    bool? movementBlocked,
  });
}

/// @nodoc
class __$$StatusEffectImplCopyWithImpl<$Res>
    extends _$StatusEffectCopyWithImpl<$Res, _$StatusEffectImpl>
    implements _$$StatusEffectImplCopyWith<$Res> {
  __$$StatusEffectImplCopyWithImpl(
    _$StatusEffectImpl _value,
    $Res Function(_$StatusEffectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? turnsRemaining = null,
    Object? attackModifier = freezed,
    Object? movementBlocked = freezed,
  }) {
    return _then(
      _$StatusEffectImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        turnsRemaining: null == turnsRemaining
            ? _value.turnsRemaining
            : turnsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
        attackModifier: freezed == attackModifier
            ? _value.attackModifier
            : attackModifier // ignore: cast_nullable_to_non_nullable
                  as int?,
        movementBlocked: freezed == movementBlocked
            ? _value.movementBlocked
            : movementBlocked // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusEffectImpl implements _StatusEffect {
  const _$StatusEffectImpl({
    required this.id,
    required this.name,
    this.description,
    this.turnsRemaining = 0,
    this.attackModifier,
    this.movementBlocked,
  });

  factory _$StatusEffectImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusEffectImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final int turnsRemaining;
  @override
  final int? attackModifier;
  @override
  final bool? movementBlocked;

  @override
  String toString() {
    return 'StatusEffect(id: $id, name: $name, description: $description, turnsRemaining: $turnsRemaining, attackModifier: $attackModifier, movementBlocked: $movementBlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusEffectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.turnsRemaining, turnsRemaining) ||
                other.turnsRemaining == turnsRemaining) &&
            (identical(other.attackModifier, attackModifier) ||
                other.attackModifier == attackModifier) &&
            (identical(other.movementBlocked, movementBlocked) ||
                other.movementBlocked == movementBlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    turnsRemaining,
    attackModifier,
    movementBlocked,
  );

  /// Create a copy of StatusEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusEffectImplCopyWith<_$StatusEffectImpl> get copyWith =>
      __$$StatusEffectImplCopyWithImpl<_$StatusEffectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusEffectImplToJson(this);
  }
}

abstract class _StatusEffect implements StatusEffect {
  const factory _StatusEffect({
    required final String id,
    required final String name,
    final String? description,
    final int turnsRemaining,
    final int? attackModifier,
    final bool? movementBlocked,
  }) = _$StatusEffectImpl;

  factory _StatusEffect.fromJson(Map<String, dynamic> json) =
      _$StatusEffectImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get turnsRemaining;
  @override
  int? get attackModifier;
  @override
  bool? get movementBlocked;

  /// Create a copy of StatusEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusEffectImplCopyWith<_$StatusEffectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
