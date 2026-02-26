// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedCardsTable extends CachedCards
    with TableInfo<$CachedCardsTable, CachedCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('common'),
  );
  static const VerificationMeta _cardTextMeta = const VerificationMeta(
    'cardText',
  );
  @override
  late final GeneratedColumn<String> cardText = GeneratedColumn<String>(
    'card_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flavorTextMeta = const VerificationMeta(
    'flavorText',
  );
  @override
  late final GeneratedColumn<String> flavorText = GeneratedColumn<String>(
    'flavor_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artAssetPathMeta = const VerificationMeta(
    'artAssetPath',
  );
  @override
  late final GeneratedColumn<String> artAssetPath = GeneratedColumn<String>(
    'art_asset_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpMeta = const VerificationMeta('hp');
  @override
  late final GeneratedColumn<int> hp = GeneratedColumn<int>(
    'hp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attackMeta = const VerificationMeta('attack');
  @override
  late final GeneratedColumn<int> attack = GeneratedColumn<int>(
    'attack',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    cost,
    rarity,
    cardText,
    flavorText,
    artAssetPath,
    hp,
    attack,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    }
    if (data.containsKey('card_text')) {
      context.handle(
        _cardTextMeta,
        cardText.isAcceptableOrUnknown(data['card_text']!, _cardTextMeta),
      );
    }
    if (data.containsKey('flavor_text')) {
      context.handle(
        _flavorTextMeta,
        flavorText.isAcceptableOrUnknown(data['flavor_text']!, _flavorTextMeta),
      );
    }
    if (data.containsKey('art_asset_path')) {
      context.handle(
        _artAssetPathMeta,
        artAssetPath.isAcceptableOrUnknown(
          data['art_asset_path']!,
          _artAssetPathMeta,
        ),
      );
    }
    if (data.containsKey('hp')) {
      context.handle(_hpMeta, hp.isAcceptableOrUnknown(data['hp']!, _hpMeta));
    }
    if (data.containsKey('attack')) {
      context.handle(
        _attackMeta,
        attack.isAcceptableOrUnknown(data['attack']!, _attackMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedCard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      )!,
      rarity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rarity'],
      )!,
      cardText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_text'],
      ),
      flavorText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_text'],
      ),
      artAssetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}art_asset_path'],
      ),
      hp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hp'],
      ),
      attack: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attack'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedCardsTable createAlias(String alias) {
    return $CachedCardsTable(attachedDatabase, alias);
  }
}

class CachedCard extends DataClass implements Insertable<CachedCard> {
  final String id;
  final String name;
  final String type;
  final int cost;
  final String rarity;
  final String? cardText;
  final String? flavorText;
  final String? artAssetPath;
  final int? hp;
  final int? attack;
  final DateTime cachedAt;
  const CachedCard({
    required this.id,
    required this.name,
    required this.type,
    required this.cost,
    required this.rarity,
    this.cardText,
    this.flavorText,
    this.artAssetPath,
    this.hp,
    this.attack,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['cost'] = Variable<int>(cost);
    map['rarity'] = Variable<String>(rarity);
    if (!nullToAbsent || cardText != null) {
      map['card_text'] = Variable<String>(cardText);
    }
    if (!nullToAbsent || flavorText != null) {
      map['flavor_text'] = Variable<String>(flavorText);
    }
    if (!nullToAbsent || artAssetPath != null) {
      map['art_asset_path'] = Variable<String>(artAssetPath);
    }
    if (!nullToAbsent || hp != null) {
      map['hp'] = Variable<int>(hp);
    }
    if (!nullToAbsent || attack != null) {
      map['attack'] = Variable<int>(attack);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedCardsCompanion toCompanion(bool nullToAbsent) {
    return CachedCardsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      cost: Value(cost),
      rarity: Value(rarity),
      cardText: cardText == null && nullToAbsent
          ? const Value.absent()
          : Value(cardText),
      flavorText: flavorText == null && nullToAbsent
          ? const Value.absent()
          : Value(flavorText),
      artAssetPath: artAssetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(artAssetPath),
      hp: hp == null && nullToAbsent ? const Value.absent() : Value(hp),
      attack: attack == null && nullToAbsent
          ? const Value.absent()
          : Value(attack),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedCard(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      cost: serializer.fromJson<int>(json['cost']),
      rarity: serializer.fromJson<String>(json['rarity']),
      cardText: serializer.fromJson<String?>(json['cardText']),
      flavorText: serializer.fromJson<String?>(json['flavorText']),
      artAssetPath: serializer.fromJson<String?>(json['artAssetPath']),
      hp: serializer.fromJson<int?>(json['hp']),
      attack: serializer.fromJson<int?>(json['attack']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'cost': serializer.toJson<int>(cost),
      'rarity': serializer.toJson<String>(rarity),
      'cardText': serializer.toJson<String?>(cardText),
      'flavorText': serializer.toJson<String?>(flavorText),
      'artAssetPath': serializer.toJson<String?>(artAssetPath),
      'hp': serializer.toJson<int?>(hp),
      'attack': serializer.toJson<int?>(attack),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedCard copyWith({
    String? id,
    String? name,
    String? type,
    int? cost,
    String? rarity,
    Value<String?> cardText = const Value.absent(),
    Value<String?> flavorText = const Value.absent(),
    Value<String?> artAssetPath = const Value.absent(),
    Value<int?> hp = const Value.absent(),
    Value<int?> attack = const Value.absent(),
    DateTime? cachedAt,
  }) => CachedCard(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    cost: cost ?? this.cost,
    rarity: rarity ?? this.rarity,
    cardText: cardText.present ? cardText.value : this.cardText,
    flavorText: flavorText.present ? flavorText.value : this.flavorText,
    artAssetPath: artAssetPath.present ? artAssetPath.value : this.artAssetPath,
    hp: hp.present ? hp.value : this.hp,
    attack: attack.present ? attack.value : this.attack,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedCard copyWithCompanion(CachedCardsCompanion data) {
    return CachedCard(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      cost: data.cost.present ? data.cost.value : this.cost,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      cardText: data.cardText.present ? data.cardText.value : this.cardText,
      flavorText: data.flavorText.present
          ? data.flavorText.value
          : this.flavorText,
      artAssetPath: data.artAssetPath.present
          ? data.artAssetPath.value
          : this.artAssetPath,
      hp: data.hp.present ? data.hp.value : this.hp,
      attack: data.attack.present ? data.attack.value : this.attack,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedCard(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('cost: $cost, ')
          ..write('rarity: $rarity, ')
          ..write('cardText: $cardText, ')
          ..write('flavorText: $flavorText, ')
          ..write('artAssetPath: $artAssetPath, ')
          ..write('hp: $hp, ')
          ..write('attack: $attack, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    cost,
    rarity,
    cardText,
    flavorText,
    artAssetPath,
    hp,
    attack,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedCard &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.cost == this.cost &&
          other.rarity == this.rarity &&
          other.cardText == this.cardText &&
          other.flavorText == this.flavorText &&
          other.artAssetPath == this.artAssetPath &&
          other.hp == this.hp &&
          other.attack == this.attack &&
          other.cachedAt == this.cachedAt);
}

class CachedCardsCompanion extends UpdateCompanion<CachedCard> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> cost;
  final Value<String> rarity;
  final Value<String?> cardText;
  final Value<String?> flavorText;
  final Value<String?> artAssetPath;
  final Value<int?> hp;
  final Value<int?> attack;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedCardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.cost = const Value.absent(),
    this.rarity = const Value.absent(),
    this.cardText = const Value.absent(),
    this.flavorText = const Value.absent(),
    this.artAssetPath = const Value.absent(),
    this.hp = const Value.absent(),
    this.attack = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedCardsCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.cost = const Value.absent(),
    this.rarity = const Value.absent(),
    this.cardText = const Value.absent(),
    this.flavorText = const Value.absent(),
    this.artAssetPath = const Value.absent(),
    this.hp = const Value.absent(),
    this.attack = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       cachedAt = Value(cachedAt);
  static Insertable<CachedCard> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? cost,
    Expression<String>? rarity,
    Expression<String>? cardText,
    Expression<String>? flavorText,
    Expression<String>? artAssetPath,
    Expression<int>? hp,
    Expression<int>? attack,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (cost != null) 'cost': cost,
      if (rarity != null) 'rarity': rarity,
      if (cardText != null) 'card_text': cardText,
      if (flavorText != null) 'flavor_text': flavorText,
      if (artAssetPath != null) 'art_asset_path': artAssetPath,
      if (hp != null) 'hp': hp,
      if (attack != null) 'attack': attack,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedCardsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<int>? cost,
    Value<String>? rarity,
    Value<String?>? cardText,
    Value<String?>? flavorText,
    Value<String?>? artAssetPath,
    Value<int?>? hp,
    Value<int?>? attack,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedCardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      cost: cost ?? this.cost,
      rarity: rarity ?? this.rarity,
      cardText: cardText ?? this.cardText,
      flavorText: flavorText ?? this.flavorText,
      artAssetPath: artAssetPath ?? this.artAssetPath,
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (cardText.present) {
      map['card_text'] = Variable<String>(cardText.value);
    }
    if (flavorText.present) {
      map['flavor_text'] = Variable<String>(flavorText.value);
    }
    if (artAssetPath.present) {
      map['art_asset_path'] = Variable<String>(artAssetPath.value);
    }
    if (hp.present) {
      map['hp'] = Variable<int>(hp.value);
    }
    if (attack.present) {
      map['attack'] = Variable<int>(attack.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedCardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('cost: $cost, ')
          ..write('rarity: $rarity, ')
          ..write('cardText: $cardText, ')
          ..write('flavorText: $flavorText, ')
          ..write('artAssetPath: $artAssetPath, ')
          ..write('hp: $hp, ')
          ..write('attack: $attack, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedAbilitiesTable extends CachedAbilities
    with TableInfo<$CachedAbilitiesTable, CachedAbility> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedAbilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cached_cards (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, cardId, name, description, cost];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_abilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedAbility> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedAbility map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedAbility(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      )!,
    );
  }

  @override
  $CachedAbilitiesTable createAlias(String alias) {
    return $CachedAbilitiesTable(attachedDatabase, alias);
  }
}

class CachedAbility extends DataClass implements Insertable<CachedAbility> {
  final String id;
  final String cardId;
  final String name;
  final String? description;
  final int cost;
  const CachedAbility({
    required this.id,
    required this.cardId,
    required this.name,
    this.description,
    required this.cost,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['card_id'] = Variable<String>(cardId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['cost'] = Variable<int>(cost);
    return map;
  }

  CachedAbilitiesCompanion toCompanion(bool nullToAbsent) {
    return CachedAbilitiesCompanion(
      id: Value(id),
      cardId: Value(cardId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      cost: Value(cost),
    );
  }

  factory CachedAbility.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedAbility(
      id: serializer.fromJson<String>(json['id']),
      cardId: serializer.fromJson<String>(json['cardId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      cost: serializer.fromJson<int>(json['cost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cardId': serializer.toJson<String>(cardId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'cost': serializer.toJson<int>(cost),
    };
  }

  CachedAbility copyWith({
    String? id,
    String? cardId,
    String? name,
    Value<String?> description = const Value.absent(),
    int? cost,
  }) => CachedAbility(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    cost: cost ?? this.cost,
  );
  CachedAbility copyWithCompanion(CachedAbilitiesCompanion data) {
    return CachedAbility(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      cost: data.cost.present ? data.cost.value : this.cost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedAbility(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, name, description, cost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedAbility &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.name == this.name &&
          other.description == this.description &&
          other.cost == this.cost);
}

class CachedAbilitiesCompanion extends UpdateCompanion<CachedAbility> {
  final Value<String> id;
  final Value<String> cardId;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> cost;
  final Value<int> rowid;
  const CachedAbilitiesCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.cost = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedAbilitiesCompanion.insert({
    required String id,
    required String cardId,
    required String name,
    this.description = const Value.absent(),
    this.cost = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       name = Value(name);
  static Insertable<CachedAbility> custom({
    Expression<String>? id,
    Expression<String>? cardId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? cost,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (cost != null) 'cost': cost,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedAbilitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? cardId,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? cost,
    Value<int>? rowid,
  }) {
    return CachedAbilitiesCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      name: name ?? this.name,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedAbilitiesCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('cost: $cost, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedDecksTable extends CachedDecks
    with TableInfo<$CachedDecksTable, CachedDeck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedDecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isValidMeta = const VerificationMeta(
    'isValid',
  );
  @override
  late final GeneratedColumn<bool> isValid = GeneratedColumn<bool>(
    'is_valid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_valid" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ownerId, name, isValid, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_decks';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedDeck> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_valid')) {
      context.handle(
        _isValidMeta,
        isValid.isAcceptableOrUnknown(data['is_valid']!, _isValidMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedDeck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedDeck(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isValid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_valid'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedDecksTable createAlias(String alias) {
    return $CachedDecksTable(attachedDatabase, alias);
  }
}

class CachedDeck extends DataClass implements Insertable<CachedDeck> {
  final String id;
  final String ownerId;
  final String name;
  final bool isValid;
  final DateTime cachedAt;
  const CachedDeck({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.isValid,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['name'] = Variable<String>(name);
    map['is_valid'] = Variable<bool>(isValid);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedDecksCompanion toCompanion(bool nullToAbsent) {
    return CachedDecksCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      name: Value(name),
      isValid: Value(isValid),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedDeck.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedDeck(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      name: serializer.fromJson<String>(json['name']),
      isValid: serializer.fromJson<bool>(json['isValid']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'name': serializer.toJson<String>(name),
      'isValid': serializer.toJson<bool>(isValid),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedDeck copyWith({
    String? id,
    String? ownerId,
    String? name,
    bool? isValid,
    DateTime? cachedAt,
  }) => CachedDeck(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    isValid: isValid ?? this.isValid,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedDeck copyWithCompanion(CachedDecksCompanion data) {
    return CachedDeck(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      name: data.name.present ? data.name.value : this.name,
      isValid: data.isValid.present ? data.isValid.value : this.isValid,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedDeck(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('isValid: $isValid, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, name, isValid, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedDeck &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.name == this.name &&
          other.isValid == this.isValid &&
          other.cachedAt == this.cachedAt);
}

class CachedDecksCompanion extends UpdateCompanion<CachedDeck> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> name;
  final Value<bool> isValid;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedDecksCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.name = const Value.absent(),
    this.isValid = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedDecksCompanion.insert({
    required String id,
    required String ownerId,
    required String name,
    this.isValid = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       name = Value(name),
       cachedAt = Value(cachedAt);
  static Insertable<CachedDeck> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? name,
    Expression<bool>? isValid,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (name != null) 'name': name,
      if (isValid != null) 'is_valid': isValid,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedDecksCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? name,
    Value<bool>? isValid,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedDecksCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      isValid: isValid ?? this.isValid,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isValid.present) {
      map['is_valid'] = Variable<bool>(isValid.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedDecksCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('isValid: $isValid, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedDeckCardsTable extends CachedDeckCards
    with TableInfo<$CachedDeckCardsTable, CachedDeckCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedDeckCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cached_decks (id)',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [deckId, cardId, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_deck_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedDeckCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deckId, cardId};
  @override
  CachedDeckCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedDeckCard(
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
    );
  }

  @override
  $CachedDeckCardsTable createAlias(String alias) {
    return $CachedDeckCardsTable(attachedDatabase, alias);
  }
}

class CachedDeckCard extends DataClass implements Insertable<CachedDeckCard> {
  final String deckId;
  final String cardId;
  final int quantity;
  const CachedDeckCard({
    required this.deckId,
    required this.cardId,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['deck_id'] = Variable<String>(deckId);
    map['card_id'] = Variable<String>(cardId);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  CachedDeckCardsCompanion toCompanion(bool nullToAbsent) {
    return CachedDeckCardsCompanion(
      deckId: Value(deckId),
      cardId: Value(cardId),
      quantity: Value(quantity),
    );
  }

  factory CachedDeckCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedDeckCard(
      deckId: serializer.fromJson<String>(json['deckId']),
      cardId: serializer.fromJson<String>(json['cardId']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deckId': serializer.toJson<String>(deckId),
      'cardId': serializer.toJson<String>(cardId),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  CachedDeckCard copyWith({String? deckId, String? cardId, int? quantity}) =>
      CachedDeckCard(
        deckId: deckId ?? this.deckId,
        cardId: cardId ?? this.cardId,
        quantity: quantity ?? this.quantity,
      );
  CachedDeckCard copyWithCompanion(CachedDeckCardsCompanion data) {
    return CachedDeckCard(
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedDeckCard(')
          ..write('deckId: $deckId, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(deckId, cardId, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedDeckCard &&
          other.deckId == this.deckId &&
          other.cardId == this.cardId &&
          other.quantity == this.quantity);
}

class CachedDeckCardsCompanion extends UpdateCompanion<CachedDeckCard> {
  final Value<String> deckId;
  final Value<String> cardId;
  final Value<int> quantity;
  final Value<int> rowid;
  const CachedDeckCardsCompanion({
    this.deckId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedDeckCardsCompanion.insert({
    required String deckId,
    required String cardId,
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : deckId = Value(deckId),
       cardId = Value(cardId);
  static Insertable<CachedDeckCard> custom({
    Expression<String>? deckId,
    Expression<String>? cardId,
    Expression<int>? quantity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deckId != null) 'deck_id': deckId,
      if (cardId != null) 'card_id': cardId,
      if (quantity != null) 'quantity': quantity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedDeckCardsCompanion copyWith({
    Value<String>? deckId,
    Value<String>? cardId,
    Value<int>? quantity,
    Value<int>? rowid,
  }) {
    return CachedDeckCardsCompanion(
      deckId: deckId ?? this.deckId,
      cardId: cardId ?? this.cardId,
      quantity: quantity ?? this.quantity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedDeckCardsCompanion(')
          ..write('deckId: $deckId, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CacheMetadataTable extends CacheMetadata
    with TableInfo<$CacheMetadataTable, CacheMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastFetchedMeta = const VerificationMeta(
    'lastFetched',
  );
  @override
  late final GeneratedColumn<DateTime> lastFetched = GeneratedColumn<DateTime>(
    'last_fetched',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, lastFetched];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('last_fetched')) {
      context.handle(
        _lastFetchedMeta,
        lastFetched.isAcceptableOrUnknown(
          data['last_fetched']!,
          _lastFetchedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastFetchedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  CacheMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      lastFetched: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_fetched'],
      )!,
    );
  }

  @override
  $CacheMetadataTable createAlias(String alias) {
    return $CacheMetadataTable(attachedDatabase, alias);
  }
}

class CacheMetadataData extends DataClass
    implements Insertable<CacheMetadataData> {
  final String key;
  final DateTime lastFetched;
  const CacheMetadataData({required this.key, required this.lastFetched});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['last_fetched'] = Variable<DateTime>(lastFetched);
    return map;
  }

  CacheMetadataCompanion toCompanion(bool nullToAbsent) {
    return CacheMetadataCompanion(
      key: Value(key),
      lastFetched: Value(lastFetched),
    );
  }

  factory CacheMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheMetadataData(
      key: serializer.fromJson<String>(json['key']),
      lastFetched: serializer.fromJson<DateTime>(json['lastFetched']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'lastFetched': serializer.toJson<DateTime>(lastFetched),
    };
  }

  CacheMetadataData copyWith({String? key, DateTime? lastFetched}) =>
      CacheMetadataData(
        key: key ?? this.key,
        lastFetched: lastFetched ?? this.lastFetched,
      );
  CacheMetadataData copyWithCompanion(CacheMetadataCompanion data) {
    return CacheMetadataData(
      key: data.key.present ? data.key.value : this.key,
      lastFetched: data.lastFetched.present
          ? data.lastFetched.value
          : this.lastFetched,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheMetadataData(')
          ..write('key: $key, ')
          ..write('lastFetched: $lastFetched')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, lastFetched);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheMetadataData &&
          other.key == this.key &&
          other.lastFetched == this.lastFetched);
}

class CacheMetadataCompanion extends UpdateCompanion<CacheMetadataData> {
  final Value<String> key;
  final Value<DateTime> lastFetched;
  final Value<int> rowid;
  const CacheMetadataCompanion({
    this.key = const Value.absent(),
    this.lastFetched = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CacheMetadataCompanion.insert({
    required String key,
    required DateTime lastFetched,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       lastFetched = Value(lastFetched);
  static Insertable<CacheMetadataData> custom({
    Expression<String>? key,
    Expression<DateTime>? lastFetched,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (lastFetched != null) 'last_fetched': lastFetched,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CacheMetadataCompanion copyWith({
    Value<String>? key,
    Value<DateTime>? lastFetched,
    Value<int>? rowid,
  }) {
    return CacheMetadataCompanion(
      key: key ?? this.key,
      lastFetched: lastFetched ?? this.lastFetched,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (lastFetched.present) {
      map['last_fetched'] = Variable<DateTime>(lastFetched.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheMetadataCompanion(')
          ..write('key: $key, ')
          ..write('lastFetched: $lastFetched, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedCardsTable cachedCards = $CachedCardsTable(this);
  late final $CachedAbilitiesTable cachedAbilities = $CachedAbilitiesTable(
    this,
  );
  late final $CachedDecksTable cachedDecks = $CachedDecksTable(this);
  late final $CachedDeckCardsTable cachedDeckCards = $CachedDeckCardsTable(
    this,
  );
  late final $CacheMetadataTable cacheMetadata = $CacheMetadataTable(this);
  late final CardCacheDao cardCacheDao = CardCacheDao(this as AppDatabase);
  late final DeckCacheDao deckCacheDao = DeckCacheDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedCards,
    cachedAbilities,
    cachedDecks,
    cachedDeckCards,
    cacheMetadata,
  ];
}

typedef $$CachedCardsTableCreateCompanionBuilder =
    CachedCardsCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<int> cost,
      Value<String> rarity,
      Value<String?> cardText,
      Value<String?> flavorText,
      Value<String?> artAssetPath,
      Value<int?> hp,
      Value<int?> attack,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedCardsTableUpdateCompanionBuilder =
    CachedCardsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<int> cost,
      Value<String> rarity,
      Value<String?> cardText,
      Value<String?> flavorText,
      Value<String?> artAssetPath,
      Value<int?> hp,
      Value<int?> attack,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

final class $$CachedCardsTableReferences
    extends BaseReferences<_$AppDatabase, $CachedCardsTable, CachedCard> {
  $$CachedCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CachedAbilitiesTable, List<CachedAbility>>
  _cachedAbilitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cachedAbilities,
    aliasName: $_aliasNameGenerator(
      db.cachedCards.id,
      db.cachedAbilities.cardId,
    ),
  );

  $$CachedAbilitiesTableProcessedTableManager get cachedAbilitiesRefs {
    final manager = $$CachedAbilitiesTableTableManager(
      $_db,
      $_db.cachedAbilities,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cachedAbilitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CachedCardsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedCardsTable> {
  $$CachedCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardText => $composableBuilder(
    column: $table.cardText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorText => $composableBuilder(
    column: $table.flavorText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artAssetPath => $composableBuilder(
    column: $table.artAssetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attack => $composableBuilder(
    column: $table.attack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cachedAbilitiesRefs(
    Expression<bool> Function($$CachedAbilitiesTableFilterComposer f) f,
  ) {
    final $$CachedAbilitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cachedAbilities,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedAbilitiesTableFilterComposer(
            $db: $db,
            $table: $db.cachedAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CachedCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedCardsTable> {
  $$CachedCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardText => $composableBuilder(
    column: $table.cardText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorText => $composableBuilder(
    column: $table.flavorText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artAssetPath => $composableBuilder(
    column: $table.artAssetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attack => $composableBuilder(
    column: $table.attack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedCardsTable> {
  $$CachedCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<String> get cardText =>
      $composableBuilder(column: $table.cardText, builder: (column) => column);

  GeneratedColumn<String> get flavorText => $composableBuilder(
    column: $table.flavorText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artAssetPath => $composableBuilder(
    column: $table.artAssetPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hp =>
      $composableBuilder(column: $table.hp, builder: (column) => column);

  GeneratedColumn<int> get attack =>
      $composableBuilder(column: $table.attack, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  Expression<T> cachedAbilitiesRefs<T extends Object>(
    Expression<T> Function($$CachedAbilitiesTableAnnotationComposer a) f,
  ) {
    final $$CachedAbilitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cachedAbilities,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedAbilitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.cachedAbilities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CachedCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedCardsTable,
          CachedCard,
          $$CachedCardsTableFilterComposer,
          $$CachedCardsTableOrderingComposer,
          $$CachedCardsTableAnnotationComposer,
          $$CachedCardsTableCreateCompanionBuilder,
          $$CachedCardsTableUpdateCompanionBuilder,
          (CachedCard, $$CachedCardsTableReferences),
          CachedCard,
          PrefetchHooks Function({bool cachedAbilitiesRefs})
        > {
  $$CachedCardsTableTableManager(_$AppDatabase db, $CachedCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> cost = const Value.absent(),
                Value<String> rarity = const Value.absent(),
                Value<String?> cardText = const Value.absent(),
                Value<String?> flavorText = const Value.absent(),
                Value<String?> artAssetPath = const Value.absent(),
                Value<int?> hp = const Value.absent(),
                Value<int?> attack = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedCardsCompanion(
                id: id,
                name: name,
                type: type,
                cost: cost,
                rarity: rarity,
                cardText: cardText,
                flavorText: flavorText,
                artAssetPath: artAssetPath,
                hp: hp,
                attack: attack,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<int> cost = const Value.absent(),
                Value<String> rarity = const Value.absent(),
                Value<String?> cardText = const Value.absent(),
                Value<String?> flavorText = const Value.absent(),
                Value<String?> artAssetPath = const Value.absent(),
                Value<int?> hp = const Value.absent(),
                Value<int?> attack = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedCardsCompanion.insert(
                id: id,
                name: name,
                type: type,
                cost: cost,
                rarity: rarity,
                cardText: cardText,
                flavorText: flavorText,
                artAssetPath: artAssetPath,
                hp: hp,
                attack: attack,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CachedCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cachedAbilitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cachedAbilitiesRefs) db.cachedAbilities,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cachedAbilitiesRefs)
                    await $_getPrefetchedData<
                      CachedCard,
                      $CachedCardsTable,
                      CachedAbility
                    >(
                      currentTable: table,
                      referencedTable: $$CachedCardsTableReferences
                          ._cachedAbilitiesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CachedCardsTableReferences(
                            db,
                            table,
                            p0,
                          ).cachedAbilitiesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.cardId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CachedCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedCardsTable,
      CachedCard,
      $$CachedCardsTableFilterComposer,
      $$CachedCardsTableOrderingComposer,
      $$CachedCardsTableAnnotationComposer,
      $$CachedCardsTableCreateCompanionBuilder,
      $$CachedCardsTableUpdateCompanionBuilder,
      (CachedCard, $$CachedCardsTableReferences),
      CachedCard,
      PrefetchHooks Function({bool cachedAbilitiesRefs})
    >;
typedef $$CachedAbilitiesTableCreateCompanionBuilder =
    CachedAbilitiesCompanion Function({
      required String id,
      required String cardId,
      required String name,
      Value<String?> description,
      Value<int> cost,
      Value<int> rowid,
    });
typedef $$CachedAbilitiesTableUpdateCompanionBuilder =
    CachedAbilitiesCompanion Function({
      Value<String> id,
      Value<String> cardId,
      Value<String> name,
      Value<String?> description,
      Value<int> cost,
      Value<int> rowid,
    });

final class $$CachedAbilitiesTableReferences
    extends
        BaseReferences<_$AppDatabase, $CachedAbilitiesTable, CachedAbility> {
  $$CachedAbilitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CachedCardsTable _cardIdTable(_$AppDatabase db) =>
      db.cachedCards.createAlias(
        $_aliasNameGenerator(db.cachedAbilities.cardId, db.cachedCards.id),
      );

  $$CachedCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CachedCardsTableTableManager(
      $_db,
      $_db.cachedCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CachedAbilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedAbilitiesTable> {
  $$CachedAbilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  $$CachedCardsTableFilterComposer get cardId {
    final $$CachedCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cachedCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedCardsTableFilterComposer(
            $db: $db,
            $table: $db.cachedCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedAbilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedAbilitiesTable> {
  $$CachedAbilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  $$CachedCardsTableOrderingComposer get cardId {
    final $$CachedCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cachedCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedCardsTableOrderingComposer(
            $db: $db,
            $table: $db.cachedCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedAbilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedAbilitiesTable> {
  $$CachedAbilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  $$CachedCardsTableAnnotationComposer get cardId {
    final $$CachedCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cachedCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cachedCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedAbilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedAbilitiesTable,
          CachedAbility,
          $$CachedAbilitiesTableFilterComposer,
          $$CachedAbilitiesTableOrderingComposer,
          $$CachedAbilitiesTableAnnotationComposer,
          $$CachedAbilitiesTableCreateCompanionBuilder,
          $$CachedAbilitiesTableUpdateCompanionBuilder,
          (CachedAbility, $$CachedAbilitiesTableReferences),
          CachedAbility,
          PrefetchHooks Function({bool cardId})
        > {
  $$CachedAbilitiesTableTableManager(
    _$AppDatabase db,
    $CachedAbilitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedAbilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedAbilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedAbilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> cost = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedAbilitiesCompanion(
                id: id,
                cardId: cardId,
                name: name,
                description: description,
                cost: cost,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cardId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> cost = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedAbilitiesCompanion.insert(
                id: id,
                cardId: cardId,
                name: name,
                description: description,
                cost: cost,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CachedAbilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable:
                                    $$CachedAbilitiesTableReferences
                                        ._cardIdTable(db),
                                referencedColumn:
                                    $$CachedAbilitiesTableReferences
                                        ._cardIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CachedAbilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedAbilitiesTable,
      CachedAbility,
      $$CachedAbilitiesTableFilterComposer,
      $$CachedAbilitiesTableOrderingComposer,
      $$CachedAbilitiesTableAnnotationComposer,
      $$CachedAbilitiesTableCreateCompanionBuilder,
      $$CachedAbilitiesTableUpdateCompanionBuilder,
      (CachedAbility, $$CachedAbilitiesTableReferences),
      CachedAbility,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$CachedDecksTableCreateCompanionBuilder =
    CachedDecksCompanion Function({
      required String id,
      required String ownerId,
      required String name,
      Value<bool> isValid,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedDecksTableUpdateCompanionBuilder =
    CachedDecksCompanion Function({
      Value<String> id,
      Value<String> ownerId,
      Value<String> name,
      Value<bool> isValid,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

final class $$CachedDecksTableReferences
    extends BaseReferences<_$AppDatabase, $CachedDecksTable, CachedDeck> {
  $$CachedDecksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CachedDeckCardsTable, List<CachedDeckCard>>
  _cachedDeckCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cachedDeckCards,
    aliasName: $_aliasNameGenerator(
      db.cachedDecks.id,
      db.cachedDeckCards.deckId,
    ),
  );

  $$CachedDeckCardsTableProcessedTableManager get cachedDeckCardsRefs {
    final manager = $$CachedDeckCardsTableTableManager(
      $_db,
      $_db.cachedDeckCards,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cachedDeckCardsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CachedDecksTableFilterComposer
    extends Composer<_$AppDatabase, $CachedDecksTable> {
  $$CachedDecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isValid => $composableBuilder(
    column: $table.isValid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cachedDeckCardsRefs(
    Expression<bool> Function($$CachedDeckCardsTableFilterComposer f) f,
  ) {
    final $$CachedDeckCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cachedDeckCards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedDeckCardsTableFilterComposer(
            $db: $db,
            $table: $db.cachedDeckCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CachedDecksTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedDecksTable> {
  $$CachedDecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isValid => $composableBuilder(
    column: $table.isValid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedDecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedDecksTable> {
  $$CachedDecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isValid =>
      $composableBuilder(column: $table.isValid, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  Expression<T> cachedDeckCardsRefs<T extends Object>(
    Expression<T> Function($$CachedDeckCardsTableAnnotationComposer a) f,
  ) {
    final $$CachedDeckCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cachedDeckCards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedDeckCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cachedDeckCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CachedDecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedDecksTable,
          CachedDeck,
          $$CachedDecksTableFilterComposer,
          $$CachedDecksTableOrderingComposer,
          $$CachedDecksTableAnnotationComposer,
          $$CachedDecksTableCreateCompanionBuilder,
          $$CachedDecksTableUpdateCompanionBuilder,
          (CachedDeck, $$CachedDecksTableReferences),
          CachedDeck,
          PrefetchHooks Function({bool cachedDeckCardsRefs})
        > {
  $$CachedDecksTableTableManager(_$AppDatabase db, $CachedDecksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedDecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedDecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedDecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isValid = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedDecksCompanion(
                id: id,
                ownerId: ownerId,
                name: name,
                isValid: isValid,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String name,
                Value<bool> isValid = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedDecksCompanion.insert(
                id: id,
                ownerId: ownerId,
                name: name,
                isValid: isValid,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CachedDecksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cachedDeckCardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cachedDeckCardsRefs) db.cachedDeckCards,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cachedDeckCardsRefs)
                    await $_getPrefetchedData<
                      CachedDeck,
                      $CachedDecksTable,
                      CachedDeckCard
                    >(
                      currentTable: table,
                      referencedTable: $$CachedDecksTableReferences
                          ._cachedDeckCardsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CachedDecksTableReferences(
                            db,
                            table,
                            p0,
                          ).cachedDeckCardsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.deckId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CachedDecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedDecksTable,
      CachedDeck,
      $$CachedDecksTableFilterComposer,
      $$CachedDecksTableOrderingComposer,
      $$CachedDecksTableAnnotationComposer,
      $$CachedDecksTableCreateCompanionBuilder,
      $$CachedDecksTableUpdateCompanionBuilder,
      (CachedDeck, $$CachedDecksTableReferences),
      CachedDeck,
      PrefetchHooks Function({bool cachedDeckCardsRefs})
    >;
typedef $$CachedDeckCardsTableCreateCompanionBuilder =
    CachedDeckCardsCompanion Function({
      required String deckId,
      required String cardId,
      Value<int> quantity,
      Value<int> rowid,
    });
typedef $$CachedDeckCardsTableUpdateCompanionBuilder =
    CachedDeckCardsCompanion Function({
      Value<String> deckId,
      Value<String> cardId,
      Value<int> quantity,
      Value<int> rowid,
    });

final class $$CachedDeckCardsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CachedDeckCardsTable, CachedDeckCard> {
  $$CachedDeckCardsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CachedDecksTable _deckIdTable(_$AppDatabase db) =>
      db.cachedDecks.createAlias(
        $_aliasNameGenerator(db.cachedDeckCards.deckId, db.cachedDecks.id),
      );

  $$CachedDecksTableProcessedTableManager get deckId {
    final $_column = $_itemColumn<String>('deck_id')!;

    final manager = $$CachedDecksTableTableManager(
      $_db,
      $_db.cachedDecks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CachedDeckCardsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedDeckCardsTable> {
  $$CachedDeckCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  $$CachedDecksTableFilterComposer get deckId {
    final $$CachedDecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.cachedDecks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedDecksTableFilterComposer(
            $db: $db,
            $table: $db.cachedDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedDeckCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedDeckCardsTable> {
  $$CachedDeckCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  $$CachedDecksTableOrderingComposer get deckId {
    final $$CachedDecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.cachedDecks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedDecksTableOrderingComposer(
            $db: $db,
            $table: $db.cachedDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedDeckCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedDeckCardsTable> {
  $$CachedDeckCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  $$CachedDecksTableAnnotationComposer get deckId {
    final $$CachedDecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.cachedDecks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedDecksTableAnnotationComposer(
            $db: $db,
            $table: $db.cachedDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedDeckCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedDeckCardsTable,
          CachedDeckCard,
          $$CachedDeckCardsTableFilterComposer,
          $$CachedDeckCardsTableOrderingComposer,
          $$CachedDeckCardsTableAnnotationComposer,
          $$CachedDeckCardsTableCreateCompanionBuilder,
          $$CachedDeckCardsTableUpdateCompanionBuilder,
          (CachedDeckCard, $$CachedDeckCardsTableReferences),
          CachedDeckCard,
          PrefetchHooks Function({bool deckId})
        > {
  $$CachedDeckCardsTableTableManager(
    _$AppDatabase db,
    $CachedDeckCardsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedDeckCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedDeckCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedDeckCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> deckId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedDeckCardsCompanion(
                deckId: deckId,
                cardId: cardId,
                quantity: quantity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String deckId,
                required String cardId,
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedDeckCardsCompanion.insert(
                deckId: deckId,
                cardId: cardId,
                quantity: quantity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CachedDeckCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({deckId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (deckId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deckId,
                                referencedTable:
                                    $$CachedDeckCardsTableReferences
                                        ._deckIdTable(db),
                                referencedColumn:
                                    $$CachedDeckCardsTableReferences
                                        ._deckIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CachedDeckCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedDeckCardsTable,
      CachedDeckCard,
      $$CachedDeckCardsTableFilterComposer,
      $$CachedDeckCardsTableOrderingComposer,
      $$CachedDeckCardsTableAnnotationComposer,
      $$CachedDeckCardsTableCreateCompanionBuilder,
      $$CachedDeckCardsTableUpdateCompanionBuilder,
      (CachedDeckCard, $$CachedDeckCardsTableReferences),
      CachedDeckCard,
      PrefetchHooks Function({bool deckId})
    >;
typedef $$CacheMetadataTableCreateCompanionBuilder =
    CacheMetadataCompanion Function({
      required String key,
      required DateTime lastFetched,
      Value<int> rowid,
    });
typedef $$CacheMetadataTableUpdateCompanionBuilder =
    CacheMetadataCompanion Function({
      Value<String> key,
      Value<DateTime> lastFetched,
      Value<int> rowid,
    });

class $$CacheMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $CacheMetadataTable> {
  $$CacheMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastFetched => $composableBuilder(
    column: $table.lastFetched,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheMetadataTable> {
  $$CacheMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastFetched => $composableBuilder(
    column: $table.lastFetched,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheMetadataTable> {
  $$CacheMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<DateTime> get lastFetched => $composableBuilder(
    column: $table.lastFetched,
    builder: (column) => column,
  );
}

class $$CacheMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheMetadataTable,
          CacheMetadataData,
          $$CacheMetadataTableFilterComposer,
          $$CacheMetadataTableOrderingComposer,
          $$CacheMetadataTableAnnotationComposer,
          $$CacheMetadataTableCreateCompanionBuilder,
          $$CacheMetadataTableUpdateCompanionBuilder,
          (
            CacheMetadataData,
            BaseReferences<
              _$AppDatabase,
              $CacheMetadataTable,
              CacheMetadataData
            >,
          ),
          CacheMetadataData,
          PrefetchHooks Function()
        > {
  $$CacheMetadataTableTableManager(_$AppDatabase db, $CacheMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<DateTime> lastFetched = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CacheMetadataCompanion(
                key: key,
                lastFetched: lastFetched,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required DateTime lastFetched,
                Value<int> rowid = const Value.absent(),
              }) => CacheMetadataCompanion.insert(
                key: key,
                lastFetched: lastFetched,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheMetadataTable,
      CacheMetadataData,
      $$CacheMetadataTableFilterComposer,
      $$CacheMetadataTableOrderingComposer,
      $$CacheMetadataTableAnnotationComposer,
      $$CacheMetadataTableCreateCompanionBuilder,
      $$CacheMetadataTableUpdateCompanionBuilder,
      (
        CacheMetadataData,
        BaseReferences<_$AppDatabase, $CacheMetadataTable, CacheMetadataData>,
      ),
      CacheMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedCardsTableTableManager get cachedCards =>
      $$CachedCardsTableTableManager(_db, _db.cachedCards);
  $$CachedAbilitiesTableTableManager get cachedAbilities =>
      $$CachedAbilitiesTableTableManager(_db, _db.cachedAbilities);
  $$CachedDecksTableTableManager get cachedDecks =>
      $$CachedDecksTableTableManager(_db, _db.cachedDecks);
  $$CachedDeckCardsTableTableManager get cachedDeckCards =>
      $$CachedDeckCardsTableTableManager(_db, _db.cachedDeckCards);
  $$CacheMetadataTableTableManager get cacheMetadata =>
      $$CacheMetadataTableTableManager(_db, _db.cacheMetadata);
}
