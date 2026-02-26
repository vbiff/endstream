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
  @JsonKey(name: 'instanceId')
  String? get instanceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'operatorCardId')
  String get operatorCardId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ownerId')
  String get ownerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'currentHp')
  int get currentHp => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxHp')
  int get maxHp => throw _privateConstructorUsedError;
  int get attack => throw _privateConstructorUsedError;
  StreamPosition get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'statusEffects')
  List<StatusEffect> get statusEffects => throw _privateConstructorUsedError;
  @JsonKey(name: 'hasActedThisTurn')
  bool get hasActedThisTurn => throw _privateConstructorUsedError;
  @JsonKey(name: 'equipmentCardIds')
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
    @JsonKey(name: 'instanceId') String? instanceId,
    @JsonKey(name: 'operatorCardId') String operatorCardId,
    @JsonKey(name: 'ownerId') String ownerId,
    @JsonKey(name: 'currentHp') int currentHp,
    @JsonKey(name: 'maxHp') int maxHp,
    int attack,
    StreamPosition position,
    @JsonKey(name: 'statusEffects') List<StatusEffect> statusEffects,
    @JsonKey(name: 'hasActedThisTurn') bool hasActedThisTurn,
    @JsonKey(name: 'equipmentCardIds') List<String> equipmentCardIds,
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
    Object? instanceId = freezed,
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
            instanceId: freezed == instanceId
                ? _value.instanceId
                : instanceId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    @JsonKey(name: 'instanceId') String? instanceId,
    @JsonKey(name: 'operatorCardId') String operatorCardId,
    @JsonKey(name: 'ownerId') String ownerId,
    @JsonKey(name: 'currentHp') int currentHp,
    @JsonKey(name: 'maxHp') int maxHp,
    int attack,
    StreamPosition position,
    @JsonKey(name: 'statusEffects') List<StatusEffect> statusEffects,
    @JsonKey(name: 'hasActedThisTurn') bool hasActedThisTurn,
    @JsonKey(name: 'equipmentCardIds') List<String> equipmentCardIds,
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
    Object? instanceId = freezed,
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
        instanceId: freezed == instanceId
            ? _value.instanceId
            : instanceId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    @JsonKey(name: 'instanceId') this.instanceId,
    @JsonKey(name: 'operatorCardId') required this.operatorCardId,
    @JsonKey(name: 'ownerId') required this.ownerId,
    @JsonKey(name: 'currentHp') required this.currentHp,
    @JsonKey(name: 'maxHp') required this.maxHp,
    required this.attack,
    required this.position,
    @JsonKey(name: 'statusEffects')
    final List<StatusEffect> statusEffects = const [],
    @JsonKey(name: 'hasActedThisTurn') this.hasActedThisTurn = false,
    @JsonKey(name: 'equipmentCardIds')
    final List<String> equipmentCardIds = const [],
  }) : _statusEffects = statusEffects,
       _equipmentCardIds = equipmentCardIds;

  factory _$OperatorInstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$OperatorInstanceImplFromJson(json);

  @override
  @JsonKey(name: 'instanceId')
  final String? instanceId;
  @override
  @JsonKey(name: 'operatorCardId')
  final String operatorCardId;
  @override
  @JsonKey(name: 'ownerId')
  final String ownerId;
  @override
  @JsonKey(name: 'currentHp')
  final int currentHp;
  @override
  @JsonKey(name: 'maxHp')
  final int maxHp;
  @override
  final int attack;
  @override
  final StreamPosition position;
  final List<StatusEffect> _statusEffects;
  @override
  @JsonKey(name: 'statusEffects')
  List<StatusEffect> get statusEffects {
    if (_statusEffects is EqualUnmodifiableListView) return _statusEffects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statusEffects);
  }

  @override
  @JsonKey(name: 'hasActedThisTurn')
  final bool hasActedThisTurn;
  final List<String> _equipmentCardIds;
  @override
  @JsonKey(name: 'equipmentCardIds')
  List<String> get equipmentCardIds {
    if (_equipmentCardIds is EqualUnmodifiableListView)
      return _equipmentCardIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipmentCardIds);
  }

  @override
  String toString() {
    return 'OperatorInstance(instanceId: $instanceId, operatorCardId: $operatorCardId, ownerId: $ownerId, currentHp: $currentHp, maxHp: $maxHp, attack: $attack, position: $position, statusEffects: $statusEffects, hasActedThisTurn: $hasActedThisTurn, equipmentCardIds: $equipmentCardIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperatorInstanceImpl &&
            (identical(other.instanceId, instanceId) ||
                other.instanceId == instanceId) &&
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
    instanceId,
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
    @JsonKey(name: 'instanceId') final String? instanceId,
    @JsonKey(name: 'operatorCardId') required final String operatorCardId,
    @JsonKey(name: 'ownerId') required final String ownerId,
    @JsonKey(name: 'currentHp') required final int currentHp,
    @JsonKey(name: 'maxHp') required final int maxHp,
    required final int attack,
    required final StreamPosition position,
    @JsonKey(name: 'statusEffects') final List<StatusEffect> statusEffects,
    @JsonKey(name: 'hasActedThisTurn') final bool hasActedThisTurn,
    @JsonKey(name: 'equipmentCardIds') final List<String> equipmentCardIds,
  }) = _$OperatorInstanceImpl;

  factory _OperatorInstance.fromJson(Map<String, dynamic> json) =
      _$OperatorInstanceImpl.fromJson;

  @override
  @JsonKey(name: 'instanceId')
  String? get instanceId;
  @override
  @JsonKey(name: 'operatorCardId')
  String get operatorCardId;
  @override
  @JsonKey(name: 'ownerId')
  String get ownerId;
  @override
  @JsonKey(name: 'currentHp')
  int get currentHp;
  @override
  @JsonKey(name: 'maxHp')
  int get maxHp;
  @override
  int get attack;
  @override
  StreamPosition get position;
  @override
  @JsonKey(name: 'statusEffects')
  List<StatusEffect> get statusEffects;
  @override
  @JsonKey(name: 'hasActedThisTurn')
  bool get hasActedThisTurn;
  @override
  @JsonKey(name: 'equipmentCardIds')
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
  @JsonKey(name: 'centuryIndex')
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
  $Res call({int stream, @JsonKey(name: 'centuryIndex') int centuryIndex});
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
  $Res call({int stream, @JsonKey(name: 'centuryIndex') int centuryIndex});
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
    @JsonKey(name: 'centuryIndex') required this.centuryIndex,
  });

  factory _$StreamPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamPositionImplFromJson(json);

  @override
  final int stream;
  // 0 or 1
  @override
  @JsonKey(name: 'centuryIndex')
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
    @JsonKey(name: 'centuryIndex') required final int centuryIndex,
  }) = _$StreamPositionImpl;

  factory _StreamPosition.fromJson(Map<String, dynamic> json) =
      _$StreamPositionImpl.fromJson;

  @override
  int get stream; // 0 or 1
  @override
  @JsonKey(name: 'centuryIndex')
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
  String get type => throw _privateConstructorUsedError;
  int? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'turnsRemaining')
  int get turnsRemaining => throw _privateConstructorUsedError;
  @JsonKey(name: 'sourcePlayerId')
  String get sourcePlayerId => throw _privateConstructorUsedError;

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
    String type,
    int? value,
    @JsonKey(name: 'turnsRemaining') int turnsRemaining,
    @JsonKey(name: 'sourcePlayerId') String sourcePlayerId,
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
    Object? type = null,
    Object? value = freezed,
    Object? turnsRemaining = null,
    Object? sourcePlayerId = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int?,
            turnsRemaining: null == turnsRemaining
                ? _value.turnsRemaining
                : turnsRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
            sourcePlayerId: null == sourcePlayerId
                ? _value.sourcePlayerId
                : sourcePlayerId // ignore: cast_nullable_to_non_nullable
                      as String,
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
    String type,
    int? value,
    @JsonKey(name: 'turnsRemaining') int turnsRemaining,
    @JsonKey(name: 'sourcePlayerId') String sourcePlayerId,
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
    Object? type = null,
    Object? value = freezed,
    Object? turnsRemaining = null,
    Object? sourcePlayerId = null,
  }) {
    return _then(
      _$StatusEffectImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int?,
        turnsRemaining: null == turnsRemaining
            ? _value.turnsRemaining
            : turnsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
        sourcePlayerId: null == sourcePlayerId
            ? _value.sourcePlayerId
            : sourcePlayerId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusEffectImpl implements _StatusEffect {
  const _$StatusEffectImpl({
    required this.type,
    this.value,
    @JsonKey(name: 'turnsRemaining') this.turnsRemaining = 0,
    @JsonKey(name: 'sourcePlayerId') required this.sourcePlayerId,
  });

  factory _$StatusEffectImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusEffectImplFromJson(json);

  @override
  final String type;
  @override
  final int? value;
  @override
  @JsonKey(name: 'turnsRemaining')
  final int turnsRemaining;
  @override
  @JsonKey(name: 'sourcePlayerId')
  final String sourcePlayerId;

  @override
  String toString() {
    return 'StatusEffect(type: $type, value: $value, turnsRemaining: $turnsRemaining, sourcePlayerId: $sourcePlayerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusEffectImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.turnsRemaining, turnsRemaining) ||
                other.turnsRemaining == turnsRemaining) &&
            (identical(other.sourcePlayerId, sourcePlayerId) ||
                other.sourcePlayerId == sourcePlayerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, value, turnsRemaining, sourcePlayerId);

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
    required final String type,
    final int? value,
    @JsonKey(name: 'turnsRemaining') final int turnsRemaining,
    @JsonKey(name: 'sourcePlayerId') required final String sourcePlayerId,
  }) = _$StatusEffectImpl;

  factory _StatusEffect.fromJson(Map<String, dynamic> json) =
      _$StatusEffectImpl.fromJson;

  @override
  String get type;
  @override
  int? get value;
  @override
  @JsonKey(name: 'turnsRemaining')
  int get turnsRemaining;
  @override
  @JsonKey(name: 'sourcePlayerId')
  String get sourcePlayerId;

  /// Create a copy of StatusEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusEffectImplCopyWith<_$StatusEffectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
