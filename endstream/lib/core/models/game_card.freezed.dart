// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameCard _$GameCardFromJson(Map<String, dynamic> json) {
  return _GameCard.fromJson(json);
}

/// @nodoc
mixin _$GameCard {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  CardType get type => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;
  Rarity get rarity => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get flavorText => throw _privateConstructorUsedError;
  String? get artAssetPath => throw _privateConstructorUsedError;
  int? get hp => throw _privateConstructorUsedError;
  int? get attack => throw _privateConstructorUsedError;
  List<Ability> get abilities => throw _privateConstructorUsedError;

  /// Serializes this GameCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCardCopyWith<GameCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCardCopyWith<$Res> {
  factory $GameCardCopyWith(GameCard value, $Res Function(GameCard) then) =
      _$GameCardCopyWithImpl<$Res, GameCard>;
  @useResult
  $Res call({
    String id,
    String name,
    CardType type,
    int cost,
    Rarity rarity,
    String? text,
    String? flavorText,
    String? artAssetPath,
    int? hp,
    int? attack,
    List<Ability> abilities,
  });
}

/// @nodoc
class _$GameCardCopyWithImpl<$Res, $Val extends GameCard>
    implements $GameCardCopyWith<$Res> {
  _$GameCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? cost = null,
    Object? rarity = null,
    Object? text = freezed,
    Object? flavorText = freezed,
    Object? artAssetPath = freezed,
    Object? hp = freezed,
    Object? attack = freezed,
    Object? abilities = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CardType,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as int,
            rarity: null == rarity
                ? _value.rarity
                : rarity // ignore: cast_nullable_to_non_nullable
                      as Rarity,
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            flavorText: freezed == flavorText
                ? _value.flavorText
                : flavorText // ignore: cast_nullable_to_non_nullable
                      as String?,
            artAssetPath: freezed == artAssetPath
                ? _value.artAssetPath
                : artAssetPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            hp: freezed == hp
                ? _value.hp
                : hp // ignore: cast_nullable_to_non_nullable
                      as int?,
            attack: freezed == attack
                ? _value.attack
                : attack // ignore: cast_nullable_to_non_nullable
                      as int?,
            abilities: null == abilities
                ? _value.abilities
                : abilities // ignore: cast_nullable_to_non_nullable
                      as List<Ability>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameCardImplCopyWith<$Res>
    implements $GameCardCopyWith<$Res> {
  factory _$$GameCardImplCopyWith(
    _$GameCardImpl value,
    $Res Function(_$GameCardImpl) then,
  ) = __$$GameCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    CardType type,
    int cost,
    Rarity rarity,
    String? text,
    String? flavorText,
    String? artAssetPath,
    int? hp,
    int? attack,
    List<Ability> abilities,
  });
}

/// @nodoc
class __$$GameCardImplCopyWithImpl<$Res>
    extends _$GameCardCopyWithImpl<$Res, _$GameCardImpl>
    implements _$$GameCardImplCopyWith<$Res> {
  __$$GameCardImplCopyWithImpl(
    _$GameCardImpl _value,
    $Res Function(_$GameCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? cost = null,
    Object? rarity = null,
    Object? text = freezed,
    Object? flavorText = freezed,
    Object? artAssetPath = freezed,
    Object? hp = freezed,
    Object? attack = freezed,
    Object? abilities = null,
  }) {
    return _then(
      _$GameCardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CardType,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as int,
        rarity: null == rarity
            ? _value.rarity
            : rarity // ignore: cast_nullable_to_non_nullable
                  as Rarity,
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        flavorText: freezed == flavorText
            ? _value.flavorText
            : flavorText // ignore: cast_nullable_to_non_nullable
                  as String?,
        artAssetPath: freezed == artAssetPath
            ? _value.artAssetPath
            : artAssetPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        hp: freezed == hp
            ? _value.hp
            : hp // ignore: cast_nullable_to_non_nullable
                  as int?,
        attack: freezed == attack
            ? _value.attack
            : attack // ignore: cast_nullable_to_non_nullable
                  as int?,
        abilities: null == abilities
            ? _value._abilities
            : abilities // ignore: cast_nullable_to_non_nullable
                  as List<Ability>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameCardImpl implements _GameCard {
  const _$GameCardImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.cost,
    this.rarity = Rarity.common,
    this.text,
    this.flavorText,
    this.artAssetPath,
    this.hp,
    this.attack,
    final List<Ability> abilities = const [],
  }) : _abilities = abilities;

  factory _$GameCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameCardImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final CardType type;
  @override
  final int cost;
  @override
  @JsonKey()
  final Rarity rarity;
  @override
  final String? text;
  @override
  final String? flavorText;
  @override
  final String? artAssetPath;
  @override
  final int? hp;
  @override
  final int? attack;
  final List<Ability> _abilities;
  @override
  @JsonKey()
  List<Ability> get abilities {
    if (_abilities is EqualUnmodifiableListView) return _abilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_abilities);
  }

  @override
  String toString() {
    return 'GameCard(id: $id, name: $name, type: $type, cost: $cost, rarity: $rarity, text: $text, flavorText: $flavorText, artAssetPath: $artAssetPath, hp: $hp, attack: $attack, abilities: $abilities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.flavorText, flavorText) ||
                other.flavorText == flavorText) &&
            (identical(other.artAssetPath, artAssetPath) ||
                other.artAssetPath == artAssetPath) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.attack, attack) || other.attack == attack) &&
            const DeepCollectionEquality().equals(
              other._abilities,
              _abilities,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    cost,
    rarity,
    text,
    flavorText,
    artAssetPath,
    hp,
    attack,
    const DeepCollectionEquality().hash(_abilities),
  );

  /// Create a copy of GameCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameCardImplCopyWith<_$GameCardImpl> get copyWith =>
      __$$GameCardImplCopyWithImpl<_$GameCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameCardImplToJson(this);
  }
}

abstract class _GameCard implements GameCard {
  const factory _GameCard({
    required final String id,
    required final String name,
    required final CardType type,
    required final int cost,
    final Rarity rarity,
    final String? text,
    final String? flavorText,
    final String? artAssetPath,
    final int? hp,
    final int? attack,
    final List<Ability> abilities,
  }) = _$GameCardImpl;

  factory _GameCard.fromJson(Map<String, dynamic> json) =
      _$GameCardImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  CardType get type;
  @override
  int get cost;
  @override
  Rarity get rarity;
  @override
  String? get text;
  @override
  String? get flavorText;
  @override
  String? get artAssetPath;
  @override
  int? get hp;
  @override
  int? get attack;
  @override
  List<Ability> get abilities;

  /// Create a copy of GameCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameCardImplCopyWith<_$GameCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Ability _$AbilityFromJson(Map<String, dynamic> json) {
  return _Ability.fromJson(json);
}

/// @nodoc
mixin _$Ability {
  String get id => throw _privateConstructorUsedError;
  String get cardId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;

  /// Serializes this Ability to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AbilityCopyWith<Ability> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbilityCopyWith<$Res> {
  factory $AbilityCopyWith(Ability value, $Res Function(Ability) then) =
      _$AbilityCopyWithImpl<$Res, Ability>;
  @useResult
  $Res call({
    String id,
    String cardId,
    String name,
    String? description,
    int cost,
  });
}

/// @nodoc
class _$AbilityCopyWithImpl<$Res, $Val extends Ability>
    implements $AbilityCopyWith<$Res> {
  _$AbilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cardId = null,
    Object? name = null,
    Object? description = freezed,
    Object? cost = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            cardId: null == cardId
                ? _value.cardId
                : cardId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AbilityImplCopyWith<$Res> implements $AbilityCopyWith<$Res> {
  factory _$$AbilityImplCopyWith(
    _$AbilityImpl value,
    $Res Function(_$AbilityImpl) then,
  ) = __$$AbilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String cardId,
    String name,
    String? description,
    int cost,
  });
}

/// @nodoc
class __$$AbilityImplCopyWithImpl<$Res>
    extends _$AbilityCopyWithImpl<$Res, _$AbilityImpl>
    implements _$$AbilityImplCopyWith<$Res> {
  __$$AbilityImplCopyWithImpl(
    _$AbilityImpl _value,
    $Res Function(_$AbilityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cardId = null,
    Object? name = null,
    Object? description = freezed,
    Object? cost = null,
  }) {
    return _then(
      _$AbilityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        cardId: null == cardId
            ? _value.cardId
            : cardId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AbilityImpl implements _Ability {
  const _$AbilityImpl({
    required this.id,
    required this.cardId,
    required this.name,
    this.description,
    this.cost = 0,
  });

  factory _$AbilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AbilityImplFromJson(json);

  @override
  final String id;
  @override
  final String cardId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final int cost;

  @override
  String toString() {
    return 'Ability(id: $id, cardId: $cardId, name: $name, description: $description, cost: $cost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AbilityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, cardId, name, description, cost);

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AbilityImplCopyWith<_$AbilityImpl> get copyWith =>
      __$$AbilityImplCopyWithImpl<_$AbilityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AbilityImplToJson(this);
  }
}

abstract class _Ability implements Ability {
  const factory _Ability({
    required final String id,
    required final String cardId,
    required final String name,
    final String? description,
    final int cost,
  }) = _$AbilityImpl;

  factory _Ability.fromJson(Map<String, dynamic> json) = _$AbilityImpl.fromJson;

  @override
  String get id;
  @override
  String get cardId;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get cost;

  /// Create a copy of Ability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AbilityImplCopyWith<_$AbilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
