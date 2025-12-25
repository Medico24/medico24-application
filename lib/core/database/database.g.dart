// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccessibilitySettingsTable extends AccessibilitySettings
    with TableInfo<$AccessibilitySettingsTable, AccessibilitySetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccessibilitySettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _hearingLevelMeta = const VerificationMeta(
    'hearingLevel',
  );
  @override
  late final GeneratedColumn<String> hearingLevel = GeneratedColumn<String>(
    'hearing_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _visionLevelMeta = const VerificationMeta(
    'visionLevel',
  );
  @override
  late final GeneratedColumn<String> visionLevel = GeneratedColumn<String>(
    'vision_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _mobilityLevelMeta = const VerificationMeta(
    'mobilityLevel',
  );
  @override
  late final GeneratedColumn<String> mobilityLevel = GeneratedColumn<String>(
    'mobility_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _isOlderPersonMeta = const VerificationMeta(
    'isOlderPerson',
  );
  @override
  late final GeneratedColumn<bool> isOlderPerson = GeneratedColumn<bool>(
    'is_older_person',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_older_person" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hearingLevel,
    visionLevel,
    mobilityLevel,
    isOlderPerson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accessibility_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccessibilitySetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hearing_level')) {
      context.handle(
        _hearingLevelMeta,
        hearingLevel.isAcceptableOrUnknown(
          data['hearing_level']!,
          _hearingLevelMeta,
        ),
      );
    }
    if (data.containsKey('vision_level')) {
      context.handle(
        _visionLevelMeta,
        visionLevel.isAcceptableOrUnknown(
          data['vision_level']!,
          _visionLevelMeta,
        ),
      );
    }
    if (data.containsKey('mobility_level')) {
      context.handle(
        _mobilityLevelMeta,
        mobilityLevel.isAcceptableOrUnknown(
          data['mobility_level']!,
          _mobilityLevelMeta,
        ),
      );
    }
    if (data.containsKey('is_older_person')) {
      context.handle(
        _isOlderPersonMeta,
        isOlderPerson.isAcceptableOrUnknown(
          data['is_older_person']!,
          _isOlderPersonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccessibilitySetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccessibilitySetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      hearingLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hearing_level'],
      )!,
      visionLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vision_level'],
      )!,
      mobilityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobility_level'],
      )!,
      isOlderPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_older_person'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AccessibilitySettingsTable createAlias(String alias) {
    return $AccessibilitySettingsTable(attachedDatabase, alias);
  }
}

class AccessibilitySetting extends DataClass
    implements Insertable<AccessibilitySetting> {
  final int id;
  final String hearingLevel;
  final String visionLevel;
  final String mobilityLevel;
  final bool isOlderPerson;
  final DateTime updatedAt;
  const AccessibilitySetting({
    required this.id,
    required this.hearingLevel,
    required this.visionLevel,
    required this.mobilityLevel,
    required this.isOlderPerson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hearing_level'] = Variable<String>(hearingLevel);
    map['vision_level'] = Variable<String>(visionLevel);
    map['mobility_level'] = Variable<String>(mobilityLevel);
    map['is_older_person'] = Variable<bool>(isOlderPerson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AccessibilitySettingsCompanion toCompanion(bool nullToAbsent) {
    return AccessibilitySettingsCompanion(
      id: Value(id),
      hearingLevel: Value(hearingLevel),
      visionLevel: Value(visionLevel),
      mobilityLevel: Value(mobilityLevel),
      isOlderPerson: Value(isOlderPerson),
      updatedAt: Value(updatedAt),
    );
  }

  factory AccessibilitySetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccessibilitySetting(
      id: serializer.fromJson<int>(json['id']),
      hearingLevel: serializer.fromJson<String>(json['hearingLevel']),
      visionLevel: serializer.fromJson<String>(json['visionLevel']),
      mobilityLevel: serializer.fromJson<String>(json['mobilityLevel']),
      isOlderPerson: serializer.fromJson<bool>(json['isOlderPerson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hearingLevel': serializer.toJson<String>(hearingLevel),
      'visionLevel': serializer.toJson<String>(visionLevel),
      'mobilityLevel': serializer.toJson<String>(mobilityLevel),
      'isOlderPerson': serializer.toJson<bool>(isOlderPerson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AccessibilitySetting copyWith({
    int? id,
    String? hearingLevel,
    String? visionLevel,
    String? mobilityLevel,
    bool? isOlderPerson,
    DateTime? updatedAt,
  }) => AccessibilitySetting(
    id: id ?? this.id,
    hearingLevel: hearingLevel ?? this.hearingLevel,
    visionLevel: visionLevel ?? this.visionLevel,
    mobilityLevel: mobilityLevel ?? this.mobilityLevel,
    isOlderPerson: isOlderPerson ?? this.isOlderPerson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AccessibilitySetting copyWithCompanion(AccessibilitySettingsCompanion data) {
    return AccessibilitySetting(
      id: data.id.present ? data.id.value : this.id,
      hearingLevel: data.hearingLevel.present
          ? data.hearingLevel.value
          : this.hearingLevel,
      visionLevel: data.visionLevel.present
          ? data.visionLevel.value
          : this.visionLevel,
      mobilityLevel: data.mobilityLevel.present
          ? data.mobilityLevel.value
          : this.mobilityLevel,
      isOlderPerson: data.isOlderPerson.present
          ? data.isOlderPerson.value
          : this.isOlderPerson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccessibilitySetting(')
          ..write('id: $id, ')
          ..write('hearingLevel: $hearingLevel, ')
          ..write('visionLevel: $visionLevel, ')
          ..write('mobilityLevel: $mobilityLevel, ')
          ..write('isOlderPerson: $isOlderPerson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    hearingLevel,
    visionLevel,
    mobilityLevel,
    isOlderPerson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccessibilitySetting &&
          other.id == this.id &&
          other.hearingLevel == this.hearingLevel &&
          other.visionLevel == this.visionLevel &&
          other.mobilityLevel == this.mobilityLevel &&
          other.isOlderPerson == this.isOlderPerson &&
          other.updatedAt == this.updatedAt);
}

class AccessibilitySettingsCompanion
    extends UpdateCompanion<AccessibilitySetting> {
  final Value<int> id;
  final Value<String> hearingLevel;
  final Value<String> visionLevel;
  final Value<String> mobilityLevel;
  final Value<bool> isOlderPerson;
  final Value<DateTime> updatedAt;
  const AccessibilitySettingsCompanion({
    this.id = const Value.absent(),
    this.hearingLevel = const Value.absent(),
    this.visionLevel = const Value.absent(),
    this.mobilityLevel = const Value.absent(),
    this.isOlderPerson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AccessibilitySettingsCompanion.insert({
    this.id = const Value.absent(),
    this.hearingLevel = const Value.absent(),
    this.visionLevel = const Value.absent(),
    this.mobilityLevel = const Value.absent(),
    this.isOlderPerson = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<AccessibilitySetting> custom({
    Expression<int>? id,
    Expression<String>? hearingLevel,
    Expression<String>? visionLevel,
    Expression<String>? mobilityLevel,
    Expression<bool>? isOlderPerson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hearingLevel != null) 'hearing_level': hearingLevel,
      if (visionLevel != null) 'vision_level': visionLevel,
      if (mobilityLevel != null) 'mobility_level': mobilityLevel,
      if (isOlderPerson != null) 'is_older_person': isOlderPerson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AccessibilitySettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? hearingLevel,
    Value<String>? visionLevel,
    Value<String>? mobilityLevel,
    Value<bool>? isOlderPerson,
    Value<DateTime>? updatedAt,
  }) {
    return AccessibilitySettingsCompanion(
      id: id ?? this.id,
      hearingLevel: hearingLevel ?? this.hearingLevel,
      visionLevel: visionLevel ?? this.visionLevel,
      mobilityLevel: mobilityLevel ?? this.mobilityLevel,
      isOlderPerson: isOlderPerson ?? this.isOlderPerson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hearingLevel.present) {
      map['hearing_level'] = Variable<String>(hearingLevel.value);
    }
    if (visionLevel.present) {
      map['vision_level'] = Variable<String>(visionLevel.value);
    }
    if (mobilityLevel.present) {
      map['mobility_level'] = Variable<String>(mobilityLevel.value);
    }
    if (isOlderPerson.present) {
      map['is_older_person'] = Variable<bool>(isOlderPerson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccessibilitySettingsCompanion(')
          ..write('id: $id, ')
          ..write('hearingLevel: $hearingLevel, ')
          ..write('visionLevel: $visionLevel, ')
          ..write('mobilityLevel: $mobilityLevel, ')
          ..write('isOlderPerson: $isOlderPerson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SavedAddressesTable extends SavedAddresses
    with TableInfo<$SavedAddressesTable, SavedAddressesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedAddressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    address,
    city,
    latitude,
    longitude,
    isDefault,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_addresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedAddressesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedAddressesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedAddressesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SavedAddressesTable createAlias(String alias) {
    return $SavedAddressesTable(attachedDatabase, alias);
  }
}

class SavedAddressesData extends DataClass
    implements Insertable<SavedAddressesData> {
  final int id;
  final String title;
  final String address;
  final String city;
  final double? latitude;
  final double? longitude;
  final bool isDefault;
  final DateTime createdAt;
  const SavedAddressesData({
    required this.id,
    required this.title,
    required this.address,
    required this.city,
    this.latitude,
    this.longitude,
    required this.isDefault,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SavedAddressesCompanion toCompanion(bool nullToAbsent) {
    return SavedAddressesCompanion(
      id: Value(id),
      title: Value(title),
      address: Value(address),
      city: Value(city),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
    );
  }

  factory SavedAddressesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedAddressesData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SavedAddressesData copyWith({
    int? id,
    String? title,
    String? address,
    String? city,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    bool? isDefault,
    DateTime? createdAt,
  }) => SavedAddressesData(
    id: id ?? this.id,
    title: title ?? this.title,
    address: address ?? this.address,
    city: city ?? this.city,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    isDefault: isDefault ?? this.isDefault,
    createdAt: createdAt ?? this.createdAt,
  );
  SavedAddressesData copyWithCompanion(SavedAddressesCompanion data) {
    return SavedAddressesData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedAddressesData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    address,
    city,
    latitude,
    longitude,
    isDefault,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedAddressesData &&
          other.id == this.id &&
          other.title == this.title &&
          other.address == this.address &&
          other.city == this.city &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt);
}

class SavedAddressesCompanion extends UpdateCompanion<SavedAddressesData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> address;
  final Value<String> city;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  const SavedAddressesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SavedAddressesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String address,
    required String city,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isDefault = const Value.absent(),
    required DateTime createdAt,
  }) : title = Value(title),
       address = Value(address),
       city = Value(city),
       createdAt = Value(createdAt);
  static Insertable<SavedAddressesData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? address,
    Expression<String>? city,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SavedAddressesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? address,
    Value<String>? city,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<bool>? isDefault,
    Value<DateTime>? createdAt,
  }) {
    return SavedAddressesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedAddressesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RecentLocationsTable extends RecentLocations
    with TableInfo<$RecentLocationsTable, RecentLocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentLocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accessedAtMeta = const VerificationMeta(
    'accessedAt',
  );
  @override
  late final GeneratedColumn<DateTime> accessedAt = GeneratedColumn<DateTime>(
    'accessed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    address,
    city,
    latitude,
    longitude,
    accessedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecentLocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('accessed_at')) {
      context.handle(
        _accessedAtMeta,
        accessedAt.isAcceptableOrUnknown(data['accessed_at']!, _accessedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_accessedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecentLocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentLocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      accessedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}accessed_at'],
      )!,
    );
  }

  @override
  $RecentLocationsTable createAlias(String alias) {
    return $RecentLocationsTable(attachedDatabase, alias);
  }
}

class RecentLocation extends DataClass implements Insertable<RecentLocation> {
  final int id;
  final String address;
  final String city;
  final double? latitude;
  final double? longitude;
  final DateTime accessedAt;
  const RecentLocation({
    required this.id,
    required this.address,
    required this.city,
    this.latitude,
    this.longitude,
    required this.accessedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['accessed_at'] = Variable<DateTime>(accessedAt);
    return map;
  }

  RecentLocationsCompanion toCompanion(bool nullToAbsent) {
    return RecentLocationsCompanion(
      id: Value(id),
      address: Value(address),
      city: Value(city),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      accessedAt: Value(accessedAt),
    );
  }

  factory RecentLocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentLocation(
      id: serializer.fromJson<int>(json['id']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      accessedAt: serializer.fromJson<DateTime>(json['accessedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'accessedAt': serializer.toJson<DateTime>(accessedAt),
    };
  }

  RecentLocation copyWith({
    int? id,
    String? address,
    String? city,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    DateTime? accessedAt,
  }) => RecentLocation(
    id: id ?? this.id,
    address: address ?? this.address,
    city: city ?? this.city,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    accessedAt: accessedAt ?? this.accessedAt,
  );
  RecentLocation copyWithCompanion(RecentLocationsCompanion data) {
    return RecentLocation(
      id: data.id.present ? data.id.value : this.id,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accessedAt: data.accessedAt.present
          ? data.accessedAt.value
          : this.accessedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentLocation(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accessedAt: $accessedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, address, city, latitude, longitude, accessedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentLocation &&
          other.id == this.id &&
          other.address == this.address &&
          other.city == this.city &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accessedAt == this.accessedAt);
}

class RecentLocationsCompanion extends UpdateCompanion<RecentLocation> {
  final Value<int> id;
  final Value<String> address;
  final Value<String> city;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime> accessedAt;
  const RecentLocationsCompanion({
    this.id = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accessedAt = const Value.absent(),
  });
  RecentLocationsCompanion.insert({
    this.id = const Value.absent(),
    required String address,
    required String city,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required DateTime accessedAt,
  }) : address = Value(address),
       city = Value(city),
       accessedAt = Value(accessedAt);
  static Insertable<RecentLocation> custom({
    Expression<int>? id,
    Expression<String>? address,
    Expression<String>? city,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? accessedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accessedAt != null) 'accessed_at': accessedAt,
    });
  }

  RecentLocationsCompanion copyWith({
    Value<int>? id,
    Value<String>? address,
    Value<String>? city,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime>? accessedAt,
  }) {
    return RecentLocationsCompanion(
      id: id ?? this.id,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accessedAt: accessedAt ?? this.accessedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accessedAt.present) {
      map['accessed_at'] = Variable<DateTime>(accessedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentLocationsCompanion(')
          ..write('id: $id, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accessedAt: $accessedAt')
          ..write(')'))
        .toString();
  }
}

class $CurrentLocationTable extends CurrentLocation
    with TableInfo<$CurrentLocationTable, CurrentLocationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrentLocationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    address,
    city,
    latitude,
    longitude,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'current_location';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrentLocationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrentLocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrentLocationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CurrentLocationTable createAlias(String alias) {
    return $CurrentLocationTable(attachedDatabase, alias);
  }
}

class CurrentLocationData extends DataClass
    implements Insertable<CurrentLocationData> {
  final int id;
  final String title;
  final String address;
  final String city;
  final double? latitude;
  final double? longitude;
  final DateTime updatedAt;
  const CurrentLocationData({
    required this.id,
    required this.title,
    required this.address,
    required this.city,
    this.latitude,
    this.longitude,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CurrentLocationCompanion toCompanion(bool nullToAbsent) {
    return CurrentLocationCompanion(
      id: Value(id),
      title: Value(title),
      address: Value(address),
      city: Value(city),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      updatedAt: Value(updatedAt),
    );
  }

  factory CurrentLocationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrentLocationData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CurrentLocationData copyWith({
    int? id,
    String? title,
    String? address,
    String? city,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    DateTime? updatedAt,
  }) => CurrentLocationData(
    id: id ?? this.id,
    title: title ?? this.title,
    address: address ?? this.address,
    city: city ?? this.city,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CurrentLocationData copyWithCompanion(CurrentLocationCompanion data) {
    return CurrentLocationData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrentLocationData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, address, city, latitude, longitude, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrentLocationData &&
          other.id == this.id &&
          other.title == this.title &&
          other.address == this.address &&
          other.city == this.city &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.updatedAt == this.updatedAt);
}

class CurrentLocationCompanion extends UpdateCompanion<CurrentLocationData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> address;
  final Value<String> city;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime> updatedAt;
  const CurrentLocationCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CurrentLocationCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String address,
    required String city,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required DateTime updatedAt,
  }) : title = Value(title),
       address = Value(address),
       city = Value(city),
       updatedAt = Value(updatedAt);
  static Insertable<CurrentLocationData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? address,
    Expression<String>? city,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CurrentLocationCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? address,
    Value<String>? city,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime>? updatedAt,
  }) {
    return CurrentLocationCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrentLocationCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccessibilitySettingsTable accessibilitySettings =
      $AccessibilitySettingsTable(this);
  late final $SavedAddressesTable savedAddresses = $SavedAddressesTable(this);
  late final $RecentLocationsTable recentLocations = $RecentLocationsTable(
    this,
  );
  late final $CurrentLocationTable currentLocation = $CurrentLocationTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accessibilitySettings,
    savedAddresses,
    recentLocations,
    currentLocation,
  ];
}

typedef $$AccessibilitySettingsTableCreateCompanionBuilder =
    AccessibilitySettingsCompanion Function({
      Value<int> id,
      Value<String> hearingLevel,
      Value<String> visionLevel,
      Value<String> mobilityLevel,
      Value<bool> isOlderPerson,
      required DateTime updatedAt,
    });
typedef $$AccessibilitySettingsTableUpdateCompanionBuilder =
    AccessibilitySettingsCompanion Function({
      Value<int> id,
      Value<String> hearingLevel,
      Value<String> visionLevel,
      Value<String> mobilityLevel,
      Value<bool> isOlderPerson,
      Value<DateTime> updatedAt,
    });

class $$AccessibilitySettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AccessibilitySettingsTable> {
  $$AccessibilitySettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hearingLevel => $composableBuilder(
    column: $table.hearingLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visionLevel => $composableBuilder(
    column: $table.visionLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobilityLevel => $composableBuilder(
    column: $table.mobilityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOlderPerson => $composableBuilder(
    column: $table.isOlderPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccessibilitySettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccessibilitySettingsTable> {
  $$AccessibilitySettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hearingLevel => $composableBuilder(
    column: $table.hearingLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visionLevel => $composableBuilder(
    column: $table.visionLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobilityLevel => $composableBuilder(
    column: $table.mobilityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOlderPerson => $composableBuilder(
    column: $table.isOlderPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccessibilitySettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccessibilitySettingsTable> {
  $$AccessibilitySettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hearingLevel => $composableBuilder(
    column: $table.hearingLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get visionLevel => $composableBuilder(
    column: $table.visionLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mobilityLevel => $composableBuilder(
    column: $table.mobilityLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isOlderPerson => $composableBuilder(
    column: $table.isOlderPerson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AccessibilitySettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccessibilitySettingsTable,
          AccessibilitySetting,
          $$AccessibilitySettingsTableFilterComposer,
          $$AccessibilitySettingsTableOrderingComposer,
          $$AccessibilitySettingsTableAnnotationComposer,
          $$AccessibilitySettingsTableCreateCompanionBuilder,
          $$AccessibilitySettingsTableUpdateCompanionBuilder,
          (
            AccessibilitySetting,
            BaseReferences<
              _$AppDatabase,
              $AccessibilitySettingsTable,
              AccessibilitySetting
            >,
          ),
          AccessibilitySetting,
          PrefetchHooks Function()
        > {
  $$AccessibilitySettingsTableTableManager(
    _$AppDatabase db,
    $AccessibilitySettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccessibilitySettingsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$AccessibilitySettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AccessibilitySettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> hearingLevel = const Value.absent(),
                Value<String> visionLevel = const Value.absent(),
                Value<String> mobilityLevel = const Value.absent(),
                Value<bool> isOlderPerson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AccessibilitySettingsCompanion(
                id: id,
                hearingLevel: hearingLevel,
                visionLevel: visionLevel,
                mobilityLevel: mobilityLevel,
                isOlderPerson: isOlderPerson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> hearingLevel = const Value.absent(),
                Value<String> visionLevel = const Value.absent(),
                Value<String> mobilityLevel = const Value.absent(),
                Value<bool> isOlderPerson = const Value.absent(),
                required DateTime updatedAt,
              }) => AccessibilitySettingsCompanion.insert(
                id: id,
                hearingLevel: hearingLevel,
                visionLevel: visionLevel,
                mobilityLevel: mobilityLevel,
                isOlderPerson: isOlderPerson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccessibilitySettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccessibilitySettingsTable,
      AccessibilitySetting,
      $$AccessibilitySettingsTableFilterComposer,
      $$AccessibilitySettingsTableOrderingComposer,
      $$AccessibilitySettingsTableAnnotationComposer,
      $$AccessibilitySettingsTableCreateCompanionBuilder,
      $$AccessibilitySettingsTableUpdateCompanionBuilder,
      (
        AccessibilitySetting,
        BaseReferences<
          _$AppDatabase,
          $AccessibilitySettingsTable,
          AccessibilitySetting
        >,
      ),
      AccessibilitySetting,
      PrefetchHooks Function()
    >;
typedef $$SavedAddressesTableCreateCompanionBuilder =
    SavedAddressesCompanion Function({
      Value<int> id,
      required String title,
      required String address,
      required String city,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isDefault,
      required DateTime createdAt,
    });
typedef $$SavedAddressesTableUpdateCompanionBuilder =
    SavedAddressesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> address,
      Value<String> city,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
    });

class $$SavedAddressesTableFilterComposer
    extends Composer<_$AppDatabase, $SavedAddressesTable> {
  $$SavedAddressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedAddressesTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedAddressesTable> {
  $$SavedAddressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedAddressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedAddressesTable> {
  $$SavedAddressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SavedAddressesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedAddressesTable,
          SavedAddressesData,
          $$SavedAddressesTableFilterComposer,
          $$SavedAddressesTableOrderingComposer,
          $$SavedAddressesTableAnnotationComposer,
          $$SavedAddressesTableCreateCompanionBuilder,
          $$SavedAddressesTableUpdateCompanionBuilder,
          (
            SavedAddressesData,
            BaseReferences<
              _$AppDatabase,
              $SavedAddressesTable,
              SavedAddressesData
            >,
          ),
          SavedAddressesData,
          PrefetchHooks Function()
        > {
  $$SavedAddressesTableTableManager(
    _$AppDatabase db,
    $SavedAddressesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedAddressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedAddressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedAddressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SavedAddressesCompanion(
                id: id,
                title: title,
                address: address,
                city: city,
                latitude: latitude,
                longitude: longitude,
                isDefault: isDefault,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String address,
                required String city,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                required DateTime createdAt,
              }) => SavedAddressesCompanion.insert(
                id: id,
                title: title,
                address: address,
                city: city,
                latitude: latitude,
                longitude: longitude,
                isDefault: isDefault,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedAddressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedAddressesTable,
      SavedAddressesData,
      $$SavedAddressesTableFilterComposer,
      $$SavedAddressesTableOrderingComposer,
      $$SavedAddressesTableAnnotationComposer,
      $$SavedAddressesTableCreateCompanionBuilder,
      $$SavedAddressesTableUpdateCompanionBuilder,
      (
        SavedAddressesData,
        BaseReferences<_$AppDatabase, $SavedAddressesTable, SavedAddressesData>,
      ),
      SavedAddressesData,
      PrefetchHooks Function()
    >;
typedef $$RecentLocationsTableCreateCompanionBuilder =
    RecentLocationsCompanion Function({
      Value<int> id,
      required String address,
      required String city,
      Value<double?> latitude,
      Value<double?> longitude,
      required DateTime accessedAt,
    });
typedef $$RecentLocationsTableUpdateCompanionBuilder =
    RecentLocationsCompanion Function({
      Value<int> id,
      Value<String> address,
      Value<String> city,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime> accessedAt,
    });

class $$RecentLocationsTableFilterComposer
    extends Composer<_$AppDatabase, $RecentLocationsTable> {
  $$RecentLocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecentLocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentLocationsTable> {
  $$RecentLocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecentLocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentLocationsTable> {
  $$RecentLocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get accessedAt => $composableBuilder(
    column: $table.accessedAt,
    builder: (column) => column,
  );
}

class $$RecentLocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecentLocationsTable,
          RecentLocation,
          $$RecentLocationsTableFilterComposer,
          $$RecentLocationsTableOrderingComposer,
          $$RecentLocationsTableAnnotationComposer,
          $$RecentLocationsTableCreateCompanionBuilder,
          $$RecentLocationsTableUpdateCompanionBuilder,
          (
            RecentLocation,
            BaseReferences<
              _$AppDatabase,
              $RecentLocationsTable,
              RecentLocation
            >,
          ),
          RecentLocation,
          PrefetchHooks Function()
        > {
  $$RecentLocationsTableTableManager(
    _$AppDatabase db,
    $RecentLocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentLocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentLocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentLocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime> accessedAt = const Value.absent(),
              }) => RecentLocationsCompanion(
                id: id,
                address: address,
                city: city,
                latitude: latitude,
                longitude: longitude,
                accessedAt: accessedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String address,
                required String city,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                required DateTime accessedAt,
              }) => RecentLocationsCompanion.insert(
                id: id,
                address: address,
                city: city,
                latitude: latitude,
                longitude: longitude,
                accessedAt: accessedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecentLocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecentLocationsTable,
      RecentLocation,
      $$RecentLocationsTableFilterComposer,
      $$RecentLocationsTableOrderingComposer,
      $$RecentLocationsTableAnnotationComposer,
      $$RecentLocationsTableCreateCompanionBuilder,
      $$RecentLocationsTableUpdateCompanionBuilder,
      (
        RecentLocation,
        BaseReferences<_$AppDatabase, $RecentLocationsTable, RecentLocation>,
      ),
      RecentLocation,
      PrefetchHooks Function()
    >;
typedef $$CurrentLocationTableCreateCompanionBuilder =
    CurrentLocationCompanion Function({
      Value<int> id,
      required String title,
      required String address,
      required String city,
      Value<double?> latitude,
      Value<double?> longitude,
      required DateTime updatedAt,
    });
typedef $$CurrentLocationTableUpdateCompanionBuilder =
    CurrentLocationCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> address,
      Value<String> city,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime> updatedAt,
    });

class $$CurrentLocationTableFilterComposer
    extends Composer<_$AppDatabase, $CurrentLocationTable> {
  $$CurrentLocationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CurrentLocationTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrentLocationTable> {
  $$CurrentLocationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CurrentLocationTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrentLocationTable> {
  $$CurrentLocationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CurrentLocationTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurrentLocationTable,
          CurrentLocationData,
          $$CurrentLocationTableFilterComposer,
          $$CurrentLocationTableOrderingComposer,
          $$CurrentLocationTableAnnotationComposer,
          $$CurrentLocationTableCreateCompanionBuilder,
          $$CurrentLocationTableUpdateCompanionBuilder,
          (
            CurrentLocationData,
            BaseReferences<
              _$AppDatabase,
              $CurrentLocationTable,
              CurrentLocationData
            >,
          ),
          CurrentLocationData,
          PrefetchHooks Function()
        > {
  $$CurrentLocationTableTableManager(
    _$AppDatabase db,
    $CurrentLocationTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrentLocationTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrentLocationTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrentLocationTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CurrentLocationCompanion(
                id: id,
                title: title,
                address: address,
                city: city,
                latitude: latitude,
                longitude: longitude,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String address,
                required String city,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                required DateTime updatedAt,
              }) => CurrentLocationCompanion.insert(
                id: id,
                title: title,
                address: address,
                city: city,
                latitude: latitude,
                longitude: longitude,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CurrentLocationTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurrentLocationTable,
      CurrentLocationData,
      $$CurrentLocationTableFilterComposer,
      $$CurrentLocationTableOrderingComposer,
      $$CurrentLocationTableAnnotationComposer,
      $$CurrentLocationTableCreateCompanionBuilder,
      $$CurrentLocationTableUpdateCompanionBuilder,
      (
        CurrentLocationData,
        BaseReferences<
          _$AppDatabase,
          $CurrentLocationTable,
          CurrentLocationData
        >,
      ),
      CurrentLocationData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccessibilitySettingsTableTableManager get accessibilitySettings =>
      $$AccessibilitySettingsTableTableManager(_db, _db.accessibilitySettings);
  $$SavedAddressesTableTableManager get savedAddresses =>
      $$SavedAddressesTableTableManager(_db, _db.savedAddresses);
  $$RecentLocationsTableTableManager get recentLocations =>
      $$RecentLocationsTableTableManager(_db, _db.recentLocations);
  $$CurrentLocationTableTableManager get currentLocation =>
      $$CurrentLocationTableTableManager(_db, _db.currentLocation);
}
