// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deck.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Deck _$DeckFromJson(Map<String, dynamic> json) {
  return _Deck.fromJson(json);
}

/// @nodoc
mixin _$Deck {
  String get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<DeckCard> get cards => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Deck to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeckCopyWith<Deck> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckCopyWith<$Res> {
  factory $DeckCopyWith(Deck value, $Res Function(Deck) then) =
      _$DeckCopyWithImpl<$Res, Deck>;
  @useResult
  $Res call({
    String id,
    String ownerId,
    String name,
    List<DeckCard> cards,
    bool isValid,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$DeckCopyWithImpl<$Res, $Val extends Deck>
    implements $DeckCopyWith<$Res> {
  _$DeckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? name = null,
    Object? cards = null,
    Object? isValid = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            cards: null == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<DeckCard>,
            isValid: null == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeckImplCopyWith<$Res> implements $DeckCopyWith<$Res> {
  factory _$$DeckImplCopyWith(
    _$DeckImpl value,
    $Res Function(_$DeckImpl) then,
  ) = __$$DeckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String ownerId,
    String name,
    List<DeckCard> cards,
    bool isValid,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$DeckImplCopyWithImpl<$Res>
    extends _$DeckCopyWithImpl<$Res, _$DeckImpl>
    implements _$$DeckImplCopyWith<$Res> {
  __$$DeckImplCopyWithImpl(_$DeckImpl _value, $Res Function(_$DeckImpl) _then)
    : super(_value, _then);

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? name = null,
    Object? cards = null,
    Object? isValid = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$DeckImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        cards: null == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<DeckCard>,
        isValid: null == isValid
            ? _value.isValid
            : isValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeckImpl implements _Deck {
  const _$DeckImpl({
    required this.id,
    required this.ownerId,
    required this.name,
    final List<DeckCard> cards = const [],
    this.isValid = false,
    this.createdAt,
    this.updatedAt,
  }) : _cards = cards;

  factory _$DeckImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckImplFromJson(json);

  @override
  final String id;
  @override
  final String ownerId;
  @override
  final String name;
  final List<DeckCard> _cards;
  @override
  @JsonKey()
  List<DeckCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  @JsonKey()
  final bool isValid;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Deck(id: $id, ownerId: $ownerId, name: $name, cards: $cards, isValid: $isValid, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    ownerId,
    name,
    const DeepCollectionEquality().hash(_cards),
    isValid,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckImplCopyWith<_$DeckImpl> get copyWith =>
      __$$DeckImplCopyWithImpl<_$DeckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeckImplToJson(this);
  }
}

abstract class _Deck implements Deck {
  const factory _Deck({
    required final String id,
    required final String ownerId,
    required final String name,
    final List<DeckCard> cards,
    final bool isValid,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$DeckImpl;

  factory _Deck.fromJson(Map<String, dynamic> json) = _$DeckImpl.fromJson;

  @override
  String get id;
  @override
  String get ownerId;
  @override
  String get name;
  @override
  List<DeckCard> get cards;
  @override
  bool get isValid;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeckImplCopyWith<_$DeckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeckCard _$DeckCardFromJson(Map<String, dynamic> json) {
  return _DeckCard.fromJson(json);
}

/// @nodoc
mixin _$DeckCard {
  String get cardId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this DeckCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeckCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeckCardCopyWith<DeckCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckCardCopyWith<$Res> {
  factory $DeckCardCopyWith(DeckCard value, $Res Function(DeckCard) then) =
      _$DeckCardCopyWithImpl<$Res, DeckCard>;
  @useResult
  $Res call({String cardId, int quantity});
}

/// @nodoc
class _$DeckCardCopyWithImpl<$Res, $Val extends DeckCard>
    implements $DeckCardCopyWith<$Res> {
  _$DeckCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeckCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cardId = null, Object? quantity = null}) {
    return _then(
      _value.copyWith(
            cardId: null == cardId
                ? _value.cardId
                : cardId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeckCardImplCopyWith<$Res>
    implements $DeckCardCopyWith<$Res> {
  factory _$$DeckCardImplCopyWith(
    _$DeckCardImpl value,
    $Res Function(_$DeckCardImpl) then,
  ) = __$$DeckCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cardId, int quantity});
}

/// @nodoc
class __$$DeckCardImplCopyWithImpl<$Res>
    extends _$DeckCardCopyWithImpl<$Res, _$DeckCardImpl>
    implements _$$DeckCardImplCopyWith<$Res> {
  __$$DeckCardImplCopyWithImpl(
    _$DeckCardImpl _value,
    $Res Function(_$DeckCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeckCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cardId = null, Object? quantity = null}) {
    return _then(
      _$DeckCardImpl(
        cardId: null == cardId
            ? _value.cardId
            : cardId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeckCardImpl implements _DeckCard {
  const _$DeckCardImpl({required this.cardId, this.quantity = 1});

  factory _$DeckCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckCardImplFromJson(json);

  @override
  final String cardId;
  @override
  @JsonKey()
  final int quantity;

  @override
  String toString() {
    return 'DeckCard(cardId: $cardId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckCardImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cardId, quantity);

  /// Create a copy of DeckCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckCardImplCopyWith<_$DeckCardImpl> get copyWith =>
      __$$DeckCardImplCopyWithImpl<_$DeckCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeckCardImplToJson(this);
  }
}

abstract class _DeckCard implements DeckCard {
  const factory _DeckCard({required final String cardId, final int quantity}) =
      _$DeckCardImpl;

  factory _DeckCard.fromJson(Map<String, dynamic> json) =
      _$DeckCardImpl.fromJson;

  @override
  String get cardId;
  @override
  int get quantity;

  /// Create a copy of DeckCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeckCardImplCopyWith<_$DeckCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
