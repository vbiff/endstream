// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeckImpl _$$DeckImplFromJson(Map<String, dynamic> json) => _$DeckImpl(
  id: json['id'] as String,
  ownerId: json['owner_id'] as String,
  name: json['name'] as String,
  cards:
      (json['cards'] as List<dynamic>?)
          ?.map((e) => DeckCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isValid: json['is_valid'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$DeckImplToJson(_$DeckImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'name': instance.name,
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'is_valid': instance.isValid,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$DeckCardImpl _$$DeckCardImplFromJson(Map<String, dynamic> json) =>
    _$DeckCardImpl(
      cardId: json['card_id'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$DeckCardImplToJson(_$DeckCardImpl instance) =>
    <String, dynamic>{
      'card_id': instance.cardId,
      'quantity': instance.quantity,
    };
