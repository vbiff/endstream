// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'turnpoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Turnpoint _$TurnpointFromJson(Map<String, dynamic> json) {
  return _Turnpoint.fromJson(json);
}

/// @nodoc
mixin _$Turnpoint {
  int get century => throw _privateConstructorUsedError;
  String get terrainType => throw _privateConstructorUsedError;
  List<OperatorInstance> get operators => throw _privateConstructorUsedError;
  List<TurnpointEffect> get activeEffects => throw _privateConstructorUsedError;
  bool get controllerPresent => throw _privateConstructorUsedError;

  /// Serializes this Turnpoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Turnpoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TurnpointCopyWith<Turnpoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TurnpointCopyWith<$Res> {
  factory $TurnpointCopyWith(Turnpoint value, $Res Function(Turnpoint) then) =
      _$TurnpointCopyWithImpl<$Res, Turnpoint>;
  @useResult
  $Res call({
    int century,
    String terrainType,
    List<OperatorInstance> operators,
    List<TurnpointEffect> activeEffects,
    bool controllerPresent,
  });
}

/// @nodoc
class _$TurnpointCopyWithImpl<$Res, $Val extends Turnpoint>
    implements $TurnpointCopyWith<$Res> {
  _$TurnpointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Turnpoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? century = null,
    Object? terrainType = null,
    Object? operators = null,
    Object? activeEffects = null,
    Object? controllerPresent = null,
  }) {
    return _then(
      _value.copyWith(
            century: null == century
                ? _value.century
                : century // ignore: cast_nullable_to_non_nullable
                      as int,
            terrainType: null == terrainType
                ? _value.terrainType
                : terrainType // ignore: cast_nullable_to_non_nullable
                      as String,
            operators: null == operators
                ? _value.operators
                : operators // ignore: cast_nullable_to_non_nullable
                      as List<OperatorInstance>,
            activeEffects: null == activeEffects
                ? _value.activeEffects
                : activeEffects // ignore: cast_nullable_to_non_nullable
                      as List<TurnpointEffect>,
            controllerPresent: null == controllerPresent
                ? _value.controllerPresent
                : controllerPresent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TurnpointImplCopyWith<$Res>
    implements $TurnpointCopyWith<$Res> {
  factory _$$TurnpointImplCopyWith(
    _$TurnpointImpl value,
    $Res Function(_$TurnpointImpl) then,
  ) = __$$TurnpointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int century,
    String terrainType,
    List<OperatorInstance> operators,
    List<TurnpointEffect> activeEffects,
    bool controllerPresent,
  });
}

/// @nodoc
class __$$TurnpointImplCopyWithImpl<$Res>
    extends _$TurnpointCopyWithImpl<$Res, _$TurnpointImpl>
    implements _$$TurnpointImplCopyWith<$Res> {
  __$$TurnpointImplCopyWithImpl(
    _$TurnpointImpl _value,
    $Res Function(_$TurnpointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Turnpoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? century = null,
    Object? terrainType = null,
    Object? operators = null,
    Object? activeEffects = null,
    Object? controllerPresent = null,
  }) {
    return _then(
      _$TurnpointImpl(
        century: null == century
            ? _value.century
            : century // ignore: cast_nullable_to_non_nullable
                  as int,
        terrainType: null == terrainType
            ? _value.terrainType
            : terrainType // ignore: cast_nullable_to_non_nullable
                  as String,
        operators: null == operators
            ? _value._operators
            : operators // ignore: cast_nullable_to_non_nullable
                  as List<OperatorInstance>,
        activeEffects: null == activeEffects
            ? _value._activeEffects
            : activeEffects // ignore: cast_nullable_to_non_nullable
                  as List<TurnpointEffect>,
        controllerPresent: null == controllerPresent
            ? _value.controllerPresent
            : controllerPresent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TurnpointImpl implements _Turnpoint {
  const _$TurnpointImpl({
    required this.century,
    this.terrainType = 'standard',
    final List<OperatorInstance> operators = const [],
    final List<TurnpointEffect> activeEffects = const [],
    this.controllerPresent = false,
  }) : _operators = operators,
       _activeEffects = activeEffects;

  factory _$TurnpointImpl.fromJson(Map<String, dynamic> json) =>
      _$$TurnpointImplFromJson(json);

  @override
  final int century;
  @override
  @JsonKey()
  final String terrainType;
  final List<OperatorInstance> _operators;
  @override
  @JsonKey()
  List<OperatorInstance> get operators {
    if (_operators is EqualUnmodifiableListView) return _operators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_operators);
  }

  final List<TurnpointEffect> _activeEffects;
  @override
  @JsonKey()
  List<TurnpointEffect> get activeEffects {
    if (_activeEffects is EqualUnmodifiableListView) return _activeEffects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeEffects);
  }

  @override
  @JsonKey()
  final bool controllerPresent;

  @override
  String toString() {
    return 'Turnpoint(century: $century, terrainType: $terrainType, operators: $operators, activeEffects: $activeEffects, controllerPresent: $controllerPresent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TurnpointImpl &&
            (identical(other.century, century) || other.century == century) &&
            (identical(other.terrainType, terrainType) ||
                other.terrainType == terrainType) &&
            const DeepCollectionEquality().equals(
              other._operators,
              _operators,
            ) &&
            const DeepCollectionEquality().equals(
              other._activeEffects,
              _activeEffects,
            ) &&
            (identical(other.controllerPresent, controllerPresent) ||
                other.controllerPresent == controllerPresent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    century,
    terrainType,
    const DeepCollectionEquality().hash(_operators),
    const DeepCollectionEquality().hash(_activeEffects),
    controllerPresent,
  );

  /// Create a copy of Turnpoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TurnpointImplCopyWith<_$TurnpointImpl> get copyWith =>
      __$$TurnpointImplCopyWithImpl<_$TurnpointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TurnpointImplToJson(this);
  }
}

abstract class _Turnpoint implements Turnpoint {
  const factory _Turnpoint({
    required final int century,
    final String terrainType,
    final List<OperatorInstance> operators,
    final List<TurnpointEffect> activeEffects,
    final bool controllerPresent,
  }) = _$TurnpointImpl;

  factory _Turnpoint.fromJson(Map<String, dynamic> json) =
      _$TurnpointImpl.fromJson;

  @override
  int get century;
  @override
  String get terrainType;
  @override
  List<OperatorInstance> get operators;
  @override
  List<TurnpointEffect> get activeEffects;
  @override
  bool get controllerPresent;

  /// Create a copy of Turnpoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TurnpointImplCopyWith<_$TurnpointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TurnpointEffect _$TurnpointEffectFromJson(Map<String, dynamic> json) {
  return _TurnpointEffect.fromJson(json);
}

/// @nodoc
mixin _$TurnpointEffect {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get sourceCardId => throw _privateConstructorUsedError;
  int get turnsRemaining => throw _privateConstructorUsedError;

  /// Serializes this TurnpointEffect to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TurnpointEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TurnpointEffectCopyWith<TurnpointEffect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TurnpointEffectCopyWith<$Res> {
  factory $TurnpointEffectCopyWith(
    TurnpointEffect value,
    $Res Function(TurnpointEffect) then,
  ) = _$TurnpointEffectCopyWithImpl<$Res, TurnpointEffect>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String sourceCardId,
    int turnsRemaining,
  });
}

/// @nodoc
class _$TurnpointEffectCopyWithImpl<$Res, $Val extends TurnpointEffect>
    implements $TurnpointEffectCopyWith<$Res> {
  _$TurnpointEffectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TurnpointEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? sourceCardId = null,
    Object? turnsRemaining = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceCardId: null == sourceCardId
                ? _value.sourceCardId
                : sourceCardId // ignore: cast_nullable_to_non_nullable
                      as String,
            turnsRemaining: null == turnsRemaining
                ? _value.turnsRemaining
                : turnsRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TurnpointEffectImplCopyWith<$Res>
    implements $TurnpointEffectCopyWith<$Res> {
  factory _$$TurnpointEffectImplCopyWith(
    _$TurnpointEffectImpl value,
    $Res Function(_$TurnpointEffectImpl) then,
  ) = __$$TurnpointEffectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String sourceCardId,
    int turnsRemaining,
  });
}

/// @nodoc
class __$$TurnpointEffectImplCopyWithImpl<$Res>
    extends _$TurnpointEffectCopyWithImpl<$Res, _$TurnpointEffectImpl>
    implements _$$TurnpointEffectImplCopyWith<$Res> {
  __$$TurnpointEffectImplCopyWithImpl(
    _$TurnpointEffectImpl _value,
    $Res Function(_$TurnpointEffectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TurnpointEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? sourceCardId = null,
    Object? turnsRemaining = null,
  }) {
    return _then(
      _$TurnpointEffectImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceCardId: null == sourceCardId
            ? _value.sourceCardId
            : sourceCardId // ignore: cast_nullable_to_non_nullable
                  as String,
        turnsRemaining: null == turnsRemaining
            ? _value.turnsRemaining
            : turnsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TurnpointEffectImpl implements _TurnpointEffect {
  const _$TurnpointEffectImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.sourceCardId,
    this.turnsRemaining = 0,
  });

  factory _$TurnpointEffectImpl.fromJson(Map<String, dynamic> json) =>
      _$$TurnpointEffectImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String sourceCardId;
  @override
  @JsonKey()
  final int turnsRemaining;

  @override
  String toString() {
    return 'TurnpointEffect(id: $id, name: $name, description: $description, sourceCardId: $sourceCardId, turnsRemaining: $turnsRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TurnpointEffectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sourceCardId, sourceCardId) ||
                other.sourceCardId == sourceCardId) &&
            (identical(other.turnsRemaining, turnsRemaining) ||
                other.turnsRemaining == turnsRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    sourceCardId,
    turnsRemaining,
  );

  /// Create a copy of TurnpointEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TurnpointEffectImplCopyWith<_$TurnpointEffectImpl> get copyWith =>
      __$$TurnpointEffectImplCopyWithImpl<_$TurnpointEffectImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TurnpointEffectImplToJson(this);
  }
}

abstract class _TurnpointEffect implements TurnpointEffect {
  const factory _TurnpointEffect({
    required final String id,
    required final String name,
    required final String description,
    required final String sourceCardId,
    final int turnsRemaining,
  }) = _$TurnpointEffectImpl;

  factory _TurnpointEffect.fromJson(Map<String, dynamic> json) =
      _$TurnpointEffectImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get sourceCardId;
  @override
  int get turnsRemaining;

  /// Create a copy of TurnpointEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TurnpointEffectImplCopyWith<_$TurnpointEffectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
