// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameCardImpl _$$GameCardImplFromJson(Map<String, dynamic> json) =>
    _$GameCardImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$CardTypeEnumMap, json['type']),
      cost: (json['cost'] as num).toInt(),
      rarity:
          $enumDecodeNullable(_$RarityEnumMap, json['rarity']) ?? Rarity.common,
      text: json['text'] as String?,
      flavorText: json['flavor_text'] as String?,
      artAssetPath: json['art_asset_path'] as String?,
      hp: (json['hp'] as num?)?.toInt(),
      attack: (json['attack'] as num?)?.toInt(),
      abilities:
          (json['abilities'] as List<dynamic>?)
              ?.map((e) => Ability.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameCardImplToJson(_$GameCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$CardTypeEnumMap[instance.type]!,
      'cost': instance.cost,
      'rarity': _$RarityEnumMap[instance.rarity]!,
      'text': instance.text,
      'flavor_text': instance.flavorText,
      'art_asset_path': instance.artAssetPath,
      'hp': instance.hp,
      'attack': instance.attack,
      'abilities': instance.abilities.map((e) => e.toJson()).toList(),
    };

const _$CardTypeEnumMap = {
  CardType.operatorCard: 'operator',
  CardType.tactic: 'tactic',
  CardType.event: 'event',
  CardType.equipment: 'equipment',
};

const _$RarityEnumMap = {
  Rarity.common: 'common',
  Rarity.rare: 'rare',
  Rarity.epic: 'epic',
  Rarity.legendary: 'legendary',
};

_$AbilityImpl _$$AbilityImplFromJson(Map<String, dynamic> json) =>
    _$AbilityImpl(
      id: json['id'] as String,
      cardId: json['card_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      cost: (json['cost'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AbilityImplToJson(_$AbilityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'card_id': instance.cardId,
      'name': instance.name,
      'description': instance.description,
      'cost': instance.cost,
    };
