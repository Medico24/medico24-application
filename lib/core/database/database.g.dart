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

class $AppointmentsTable extends Appointments
    with TableInfo<$AppointmentsTable, Appointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
    'doctor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clinicIdMeta = const VerificationMeta(
    'clinicId',
  );
  @override
  late final GeneratedColumn<String> clinicId = GeneratedColumn<String>(
    'clinic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clinicNameMeta = const VerificationMeta(
    'clinicName',
  );
  @override
  late final GeneratedColumn<String> clinicName = GeneratedColumn<String>(
    'clinic_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appointmentAtMeta = const VerificationMeta(
    'appointmentAt',
  );
  @override
  late final GeneratedColumn<DateTime> appointmentAt =
      GeneratedColumn<DateTime>(
        'appointment_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _appointmentEndAtMeta = const VerificationMeta(
    'appointmentEndAt',
  );
  @override
  late final GeneratedColumn<DateTime> appointmentEndAt =
      GeneratedColumn<DateTime>(
        'appointment_end_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactPhoneMeta = const VerificationMeta(
    'contactPhone',
  );
  @override
  late final GeneratedColumn<String> contactPhone = GeneratedColumn<String>(
    'contact_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _cancelledAtMeta = const VerificationMeta(
    'cancelledAt',
  );
  @override
  late final GeneratedColumn<DateTime> cancelledAt = GeneratedColumn<DateTime>(
    'cancelled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    doctorId,
    doctorName,
    clinicId,
    clinicName,
    appointmentAt,
    appointmentEndAt,
    reason,
    contactPhone,
    notes,
    status,
    source,
    createdAt,
    updatedAt,
    cancelledAt,
    deletedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Appointment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_doctorNameMeta);
    }
    if (data.containsKey('clinic_id')) {
      context.handle(
        _clinicIdMeta,
        clinicId.isAcceptableOrUnknown(data['clinic_id']!, _clinicIdMeta),
      );
    }
    if (data.containsKey('clinic_name')) {
      context.handle(
        _clinicNameMeta,
        clinicName.isAcceptableOrUnknown(data['clinic_name']!, _clinicNameMeta),
      );
    }
    if (data.containsKey('appointment_at')) {
      context.handle(
        _appointmentAtMeta,
        appointmentAt.isAcceptableOrUnknown(
          data['appointment_at']!,
          _appointmentAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentAtMeta);
    }
    if (data.containsKey('appointment_end_at')) {
      context.handle(
        _appointmentEndAtMeta,
        appointmentEndAt.isAcceptableOrUnknown(
          data['appointment_end_at']!,
          _appointmentEndAtMeta,
        ),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('contact_phone')) {
      context.handle(
        _contactPhoneMeta,
        contactPhone.isAcceptableOrUnknown(
          data['contact_phone']!,
          _contactPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactPhoneMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('cancelled_at')) {
      context.handle(
        _cancelledAtMeta,
        cancelledAt.isAcceptableOrUnknown(
          data['cancelled_at']!,
          _cancelledAtMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Appointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Appointment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_id'],
      ),
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      )!,
      clinicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_id'],
      ),
      clinicName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_name'],
      ),
      appointmentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}appointment_at'],
      )!,
      appointmentEndAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}appointment_end_at'],
      ),
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      contactPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_phone'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      cancelledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cancelled_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $AppointmentsTable createAlias(String alias) {
    return $AppointmentsTable(attachedDatabase, alias);
  }
}

class Appointment extends DataClass implements Insertable<Appointment> {
  final String id;
  final String patientId;
  final String? doctorId;
  final String doctorName;
  final String? clinicId;
  final String? clinicName;
  final DateTime appointmentAt;
  final DateTime? appointmentEndAt;
  final String reason;
  final String contactPhone;
  final String? notes;
  final String status;
  final String source;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? cancelledAt;
  final DateTime? deletedAt;
  final DateTime? lastSyncedAt;
  const Appointment({
    required this.id,
    required this.patientId,
    this.doctorId,
    required this.doctorName,
    this.clinicId,
    this.clinicName,
    required this.appointmentAt,
    this.appointmentEndAt,
    required this.reason,
    required this.contactPhone,
    this.notes,
    required this.status,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
    this.cancelledAt,
    this.deletedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || doctorId != null) {
      map['doctor_id'] = Variable<String>(doctorId);
    }
    map['doctor_name'] = Variable<String>(doctorName);
    if (!nullToAbsent || clinicId != null) {
      map['clinic_id'] = Variable<String>(clinicId);
    }
    if (!nullToAbsent || clinicName != null) {
      map['clinic_name'] = Variable<String>(clinicName);
    }
    map['appointment_at'] = Variable<DateTime>(appointmentAt);
    if (!nullToAbsent || appointmentEndAt != null) {
      map['appointment_end_at'] = Variable<DateTime>(appointmentEndAt);
    }
    map['reason'] = Variable<String>(reason);
    map['contact_phone'] = Variable<String>(contactPhone);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || cancelledAt != null) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  AppointmentsCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      doctorName: Value(doctorName),
      clinicId: clinicId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicId),
      clinicName: clinicName == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicName),
      appointmentAt: Value(appointmentAt),
      appointmentEndAt: appointmentEndAt == null && nullToAbsent
          ? const Value.absent()
          : Value(appointmentEndAt),
      reason: Value(reason),
      contactPhone: Value(contactPhone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      cancelledAt: cancelledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(cancelledAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory Appointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Appointment(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      doctorId: serializer.fromJson<String?>(json['doctorId']),
      doctorName: serializer.fromJson<String>(json['doctorName']),
      clinicId: serializer.fromJson<String?>(json['clinicId']),
      clinicName: serializer.fromJson<String?>(json['clinicName']),
      appointmentAt: serializer.fromJson<DateTime>(json['appointmentAt']),
      appointmentEndAt: serializer.fromJson<DateTime?>(
        json['appointmentEndAt'],
      ),
      reason: serializer.fromJson<String>(json['reason']),
      contactPhone: serializer.fromJson<String>(json['contactPhone']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      cancelledAt: serializer.fromJson<DateTime?>(json['cancelledAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'doctorId': serializer.toJson<String?>(doctorId),
      'doctorName': serializer.toJson<String>(doctorName),
      'clinicId': serializer.toJson<String?>(clinicId),
      'clinicName': serializer.toJson<String?>(clinicName),
      'appointmentAt': serializer.toJson<DateTime>(appointmentAt),
      'appointmentEndAt': serializer.toJson<DateTime?>(appointmentEndAt),
      'reason': serializer.toJson<String>(reason),
      'contactPhone': serializer.toJson<String>(contactPhone),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'cancelledAt': serializer.toJson<DateTime?>(cancelledAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  Appointment copyWith({
    String? id,
    String? patientId,
    Value<String?> doctorId = const Value.absent(),
    String? doctorName,
    Value<String?> clinicId = const Value.absent(),
    Value<String?> clinicName = const Value.absent(),
    DateTime? appointmentAt,
    Value<DateTime?> appointmentEndAt = const Value.absent(),
    String? reason,
    String? contactPhone,
    Value<String?> notes = const Value.absent(),
    String? status,
    String? source,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> cancelledAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => Appointment(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    doctorId: doctorId.present ? doctorId.value : this.doctorId,
    doctorName: doctorName ?? this.doctorName,
    clinicId: clinicId.present ? clinicId.value : this.clinicId,
    clinicName: clinicName.present ? clinicName.value : this.clinicName,
    appointmentAt: appointmentAt ?? this.appointmentAt,
    appointmentEndAt: appointmentEndAt.present
        ? appointmentEndAt.value
        : this.appointmentEndAt,
    reason: reason ?? this.reason,
    contactPhone: contactPhone ?? this.contactPhone,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cancelledAt: cancelledAt.present ? cancelledAt.value : this.cancelledAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  Appointment copyWithCompanion(AppointmentsCompanion data) {
    return Appointment(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      doctorName: data.doctorName.present
          ? data.doctorName.value
          : this.doctorName,
      clinicId: data.clinicId.present ? data.clinicId.value : this.clinicId,
      clinicName: data.clinicName.present
          ? data.clinicName.value
          : this.clinicName,
      appointmentAt: data.appointmentAt.present
          ? data.appointmentAt.value
          : this.appointmentAt,
      appointmentEndAt: data.appointmentEndAt.present
          ? data.appointmentEndAt.value
          : this.appointmentEndAt,
      reason: data.reason.present ? data.reason.value : this.reason,
      contactPhone: data.contactPhone.present
          ? data.contactPhone.value
          : this.contactPhone,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      cancelledAt: data.cancelledAt.present
          ? data.cancelledAt.value
          : this.cancelledAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Appointment(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('clinicId: $clinicId, ')
          ..write('clinicName: $clinicName, ')
          ..write('appointmentAt: $appointmentAt, ')
          ..write('appointmentEndAt: $appointmentEndAt, ')
          ..write('reason: $reason, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    doctorId,
    doctorName,
    clinicId,
    clinicName,
    appointmentAt,
    appointmentEndAt,
    reason,
    contactPhone,
    notes,
    status,
    source,
    createdAt,
    updatedAt,
    cancelledAt,
    deletedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appointment &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.doctorId == this.doctorId &&
          other.doctorName == this.doctorName &&
          other.clinicId == this.clinicId &&
          other.clinicName == this.clinicName &&
          other.appointmentAt == this.appointmentAt &&
          other.appointmentEndAt == this.appointmentEndAt &&
          other.reason == this.reason &&
          other.contactPhone == this.contactPhone &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.cancelledAt == this.cancelledAt &&
          other.deletedAt == this.deletedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class AppointmentsCompanion extends UpdateCompanion<Appointment> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String?> doctorId;
  final Value<String> doctorName;
  final Value<String?> clinicId;
  final Value<String?> clinicName;
  final Value<DateTime> appointmentAt;
  final Value<DateTime?> appointmentEndAt;
  final Value<String> reason;
  final Value<String> contactPhone;
  final Value<String?> notes;
  final Value<String> status;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> cancelledAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const AppointmentsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.clinicId = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.appointmentAt = const Value.absent(),
    this.appointmentEndAt = const Value.absent(),
    this.reason = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppointmentsCompanion.insert({
    required String id,
    required String patientId,
    this.doctorId = const Value.absent(),
    required String doctorName,
    this.clinicId = const Value.absent(),
    this.clinicName = const Value.absent(),
    required DateTime appointmentAt,
    this.appointmentEndAt = const Value.absent(),
    required String reason,
    required String contactPhone,
    this.notes = const Value.absent(),
    required String status,
    required String source,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.cancelledAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       doctorName = Value(doctorName),
       appointmentAt = Value(appointmentAt),
       reason = Value(reason),
       contactPhone = Value(contactPhone),
       status = Value(status),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Appointment> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? doctorId,
    Expression<String>? doctorName,
    Expression<String>? clinicId,
    Expression<String>? clinicName,
    Expression<DateTime>? appointmentAt,
    Expression<DateTime>? appointmentEndAt,
    Expression<String>? reason,
    Expression<String>? contactPhone,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? cancelledAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (doctorId != null) 'doctor_id': doctorId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (clinicId != null) 'clinic_id': clinicId,
      if (clinicName != null) 'clinic_name': clinicName,
      if (appointmentAt != null) 'appointment_at': appointmentAt,
      if (appointmentEndAt != null) 'appointment_end_at': appointmentEndAt,
      if (reason != null) 'reason': reason,
      if (contactPhone != null) 'contact_phone': contactPhone,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (cancelledAt != null) 'cancelled_at': cancelledAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppointmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String?>? doctorId,
    Value<String>? doctorName,
    Value<String?>? clinicId,
    Value<String?>? clinicName,
    Value<DateTime>? appointmentAt,
    Value<DateTime?>? appointmentEndAt,
    Value<String>? reason,
    Value<String>? contactPhone,
    Value<String?>? notes,
    Value<String>? status,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? cancelledAt,
    Value<DateTime?>? deletedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return AppointmentsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      clinicId: clinicId ?? this.clinicId,
      clinicName: clinicName ?? this.clinicName,
      appointmentAt: appointmentAt ?? this.appointmentAt,
      appointmentEndAt: appointmentEndAt ?? this.appointmentEndAt,
      reason: reason ?? this.reason,
      contactPhone: contactPhone ?? this.contactPhone,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      deletedAt: deletedAt ?? this.deletedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (clinicId.present) {
      map['clinic_id'] = Variable<String>(clinicId.value);
    }
    if (clinicName.present) {
      map['clinic_name'] = Variable<String>(clinicName.value);
    }
    if (appointmentAt.present) {
      map['appointment_at'] = Variable<DateTime>(appointmentAt.value);
    }
    if (appointmentEndAt.present) {
      map['appointment_end_at'] = Variable<DateTime>(appointmentEndAt.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (contactPhone.present) {
      map['contact_phone'] = Variable<String>(contactPhone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (cancelledAt.present) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('clinicId: $clinicId, ')
          ..write('clinicName: $clinicName, ')
          ..write('appointmentAt: $appointmentAt, ')
          ..write('appointmentEndAt: $appointmentEndAt, ')
          ..write('reason: $reason, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedUserTable extends CachedUser
    with TableInfo<$CachedUserTable, CachedUserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedUserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firebaseUidMeta = const VerificationMeta(
    'firebaseUid',
  );
  @override
  late final GeneratedColumn<String> firebaseUid = GeneratedColumn<String>(
    'firebase_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailVerifiedMeta = const VerificationMeta(
    'emailVerified',
  );
  @override
  late final GeneratedColumn<bool> emailVerified = GeneratedColumn<bool>(
    'email_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("email_verified" IN (0, 1))',
    ),
  );
  static const VerificationMeta _authProviderMeta = const VerificationMeta(
    'authProvider',
  );
  @override
  late final GeneratedColumn<String> authProvider = GeneratedColumn<String>(
    'auth_provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _givenNameMeta = const VerificationMeta(
    'givenName',
  );
  @override
  late final GeneratedColumn<String> givenName = GeneratedColumn<String>(
    'given_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _familyNameMeta = const VerificationMeta(
    'familyName',
  );
  @override
  late final GeneratedColumn<String> familyName = GeneratedColumn<String>(
    'family_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isOnboardedMeta = const VerificationMeta(
    'isOnboarded',
  );
  @override
  late final GeneratedColumn<bool> isOnboarded = GeneratedColumn<bool>(
    'is_onboarded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_onboarded" IN (0, 1))',
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
  static const VerificationMeta _lastLoginAtMeta = const VerificationMeta(
    'lastLoginAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastLoginAt = GeneratedColumn<DateTime>(
    'last_login_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firebaseUid,
    email,
    emailVerified,
    authProvider,
    fullName,
    givenName,
    familyName,
    photoUrl,
    phone,
    role,
    isActive,
    isOnboarded,
    createdAt,
    updatedAt,
    lastLoginAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_user';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedUserData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('firebase_uid')) {
      context.handle(
        _firebaseUidMeta,
        firebaseUid.isAcceptableOrUnknown(
          data['firebase_uid']!,
          _firebaseUidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firebaseUidMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('email_verified')) {
      context.handle(
        _emailVerifiedMeta,
        emailVerified.isAcceptableOrUnknown(
          data['email_verified']!,
          _emailVerifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emailVerifiedMeta);
    }
    if (data.containsKey('auth_provider')) {
      context.handle(
        _authProviderMeta,
        authProvider.isAcceptableOrUnknown(
          data['auth_provider']!,
          _authProviderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_authProviderMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    }
    if (data.containsKey('given_name')) {
      context.handle(
        _givenNameMeta,
        givenName.isAcceptableOrUnknown(data['given_name']!, _givenNameMeta),
      );
    }
    if (data.containsKey('family_name')) {
      context.handle(
        _familyNameMeta,
        familyName.isAcceptableOrUnknown(data['family_name']!, _familyNameMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('is_onboarded')) {
      context.handle(
        _isOnboardedMeta,
        isOnboarded.isAcceptableOrUnknown(
          data['is_onboarded']!,
          _isOnboardedMeta,
        ),
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_login_at')) {
      context.handle(
        _lastLoginAtMeta,
        lastLoginAt.isAcceptableOrUnknown(
          data['last_login_at']!,
          _lastLoginAtMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedUserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedUserData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      firebaseUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}firebase_uid'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      emailVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}email_verified'],
      )!,
      authProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_provider'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      ),
      givenName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}given_name'],
      ),
      familyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}family_name'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isOnboarded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_onboarded'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastLoginAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_login_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $CachedUserTable createAlias(String alias) {
    return $CachedUserTable(attachedDatabase, alias);
  }
}

class CachedUserData extends DataClass implements Insertable<CachedUserData> {
  final String id;
  final String firebaseUid;
  final String email;
  final bool emailVerified;
  final String authProvider;
  final String? fullName;
  final String? givenName;
  final String? familyName;
  final String? photoUrl;
  final String? phone;
  final String role;
  final bool isActive;
  final bool isOnboarded;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final DateTime? lastSyncedAt;
  const CachedUserData({
    required this.id,
    required this.firebaseUid,
    required this.email,
    required this.emailVerified,
    required this.authProvider,
    this.fullName,
    this.givenName,
    this.familyName,
    this.photoUrl,
    this.phone,
    required this.role,
    required this.isActive,
    required this.isOnboarded,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['firebase_uid'] = Variable<String>(firebaseUid);
    map['email'] = Variable<String>(email);
    map['email_verified'] = Variable<bool>(emailVerified);
    map['auth_provider'] = Variable<String>(authProvider);
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || givenName != null) {
      map['given_name'] = Variable<String>(givenName);
    }
    if (!nullToAbsent || familyName != null) {
      map['family_name'] = Variable<String>(familyName);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    map['is_onboarded'] = Variable<bool>(isOnboarded);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastLoginAt != null) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  CachedUserCompanion toCompanion(bool nullToAbsent) {
    return CachedUserCompanion(
      id: Value(id),
      firebaseUid: Value(firebaseUid),
      email: Value(email),
      emailVerified: Value(emailVerified),
      authProvider: Value(authProvider),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      givenName: givenName == null && nullToAbsent
          ? const Value.absent()
          : Value(givenName),
      familyName: familyName == null && nullToAbsent
          ? const Value.absent()
          : Value(familyName),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      role: Value(role),
      isActive: Value(isActive),
      isOnboarded: Value(isOnboarded),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastLoginAt: lastLoginAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory CachedUserData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedUserData(
      id: serializer.fromJson<String>(json['id']),
      firebaseUid: serializer.fromJson<String>(json['firebaseUid']),
      email: serializer.fromJson<String>(json['email']),
      emailVerified: serializer.fromJson<bool>(json['emailVerified']),
      authProvider: serializer.fromJson<String>(json['authProvider']),
      fullName: serializer.fromJson<String?>(json['fullName']),
      givenName: serializer.fromJson<String?>(json['givenName']),
      familyName: serializer.fromJson<String?>(json['familyName']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      phone: serializer.fromJson<String?>(json['phone']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isOnboarded: serializer.fromJson<bool>(json['isOnboarded']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastLoginAt: serializer.fromJson<DateTime?>(json['lastLoginAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firebaseUid': serializer.toJson<String>(firebaseUid),
      'email': serializer.toJson<String>(email),
      'emailVerified': serializer.toJson<bool>(emailVerified),
      'authProvider': serializer.toJson<String>(authProvider),
      'fullName': serializer.toJson<String?>(fullName),
      'givenName': serializer.toJson<String?>(givenName),
      'familyName': serializer.toJson<String?>(familyName),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'phone': serializer.toJson<String?>(phone),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
      'isOnboarded': serializer.toJson<bool>(isOnboarded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastLoginAt': serializer.toJson<DateTime?>(lastLoginAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  CachedUserData copyWith({
    String? id,
    String? firebaseUid,
    String? email,
    bool? emailVerified,
    String? authProvider,
    Value<String?> fullName = const Value.absent(),
    Value<String?> givenName = const Value.absent(),
    Value<String?> familyName = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    String? role,
    bool? isActive,
    bool? isOnboarded,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastLoginAt = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => CachedUserData(
    id: id ?? this.id,
    firebaseUid: firebaseUid ?? this.firebaseUid,
    email: email ?? this.email,
    emailVerified: emailVerified ?? this.emailVerified,
    authProvider: authProvider ?? this.authProvider,
    fullName: fullName.present ? fullName.value : this.fullName,
    givenName: givenName.present ? givenName.value : this.givenName,
    familyName: familyName.present ? familyName.value : this.familyName,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    phone: phone.present ? phone.value : this.phone,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
    isOnboarded: isOnboarded ?? this.isOnboarded,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastLoginAt: lastLoginAt.present ? lastLoginAt.value : this.lastLoginAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  CachedUserData copyWithCompanion(CachedUserCompanion data) {
    return CachedUserData(
      id: data.id.present ? data.id.value : this.id,
      firebaseUid: data.firebaseUid.present
          ? data.firebaseUid.value
          : this.firebaseUid,
      email: data.email.present ? data.email.value : this.email,
      emailVerified: data.emailVerified.present
          ? data.emailVerified.value
          : this.emailVerified,
      authProvider: data.authProvider.present
          ? data.authProvider.value
          : this.authProvider,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      givenName: data.givenName.present ? data.givenName.value : this.givenName,
      familyName: data.familyName.present
          ? data.familyName.value
          : this.familyName,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isOnboarded: data.isOnboarded.present
          ? data.isOnboarded.value
          : this.isOnboarded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastLoginAt: data.lastLoginAt.present
          ? data.lastLoginAt.value
          : this.lastLoginAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedUserData(')
          ..write('id: $id, ')
          ..write('firebaseUid: $firebaseUid, ')
          ..write('email: $email, ')
          ..write('emailVerified: $emailVerified, ')
          ..write('authProvider: $authProvider, ')
          ..write('fullName: $fullName, ')
          ..write('givenName: $givenName, ')
          ..write('familyName: $familyName, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('isOnboarded: $isOnboarded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastLoginAt: $lastLoginAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firebaseUid,
    email,
    emailVerified,
    authProvider,
    fullName,
    givenName,
    familyName,
    photoUrl,
    phone,
    role,
    isActive,
    isOnboarded,
    createdAt,
    updatedAt,
    lastLoginAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedUserData &&
          other.id == this.id &&
          other.firebaseUid == this.firebaseUid &&
          other.email == this.email &&
          other.emailVerified == this.emailVerified &&
          other.authProvider == this.authProvider &&
          other.fullName == this.fullName &&
          other.givenName == this.givenName &&
          other.familyName == this.familyName &&
          other.photoUrl == this.photoUrl &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.isOnboarded == this.isOnboarded &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastLoginAt == this.lastLoginAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class CachedUserCompanion extends UpdateCompanion<CachedUserData> {
  final Value<String> id;
  final Value<String> firebaseUid;
  final Value<String> email;
  final Value<bool> emailVerified;
  final Value<String> authProvider;
  final Value<String?> fullName;
  final Value<String?> givenName;
  final Value<String?> familyName;
  final Value<String?> photoUrl;
  final Value<String?> phone;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<bool> isOnboarded;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastLoginAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const CachedUserCompanion({
    this.id = const Value.absent(),
    this.firebaseUid = const Value.absent(),
    this.email = const Value.absent(),
    this.emailVerified = const Value.absent(),
    this.authProvider = const Value.absent(),
    this.fullName = const Value.absent(),
    this.givenName = const Value.absent(),
    this.familyName = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isOnboarded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedUserCompanion.insert({
    required String id,
    required String firebaseUid,
    required String email,
    required bool emailVerified,
    required String authProvider,
    this.fullName = const Value.absent(),
    this.givenName = const Value.absent(),
    this.familyName = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.phone = const Value.absent(),
    required String role,
    required bool isActive,
    this.isOnboarded = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.lastLoginAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       firebaseUid = Value(firebaseUid),
       email = Value(email),
       emailVerified = Value(emailVerified),
       authProvider = Value(authProvider),
       role = Value(role),
       isActive = Value(isActive),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CachedUserData> custom({
    Expression<String>? id,
    Expression<String>? firebaseUid,
    Expression<String>? email,
    Expression<bool>? emailVerified,
    Expression<String>? authProvider,
    Expression<String>? fullName,
    Expression<String>? givenName,
    Expression<String>? familyName,
    Expression<String>? photoUrl,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<bool>? isOnboarded,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastLoginAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firebaseUid != null) 'firebase_uid': firebaseUid,
      if (email != null) 'email': email,
      if (emailVerified != null) 'email_verified': emailVerified,
      if (authProvider != null) 'auth_provider': authProvider,
      if (fullName != null) 'full_name': fullName,
      if (givenName != null) 'given_name': givenName,
      if (familyName != null) 'family_name': familyName,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (isOnboarded != null) 'is_onboarded': isOnboarded,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastLoginAt != null) 'last_login_at': lastLoginAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedUserCompanion copyWith({
    Value<String>? id,
    Value<String>? firebaseUid,
    Value<String>? email,
    Value<bool>? emailVerified,
    Value<String>? authProvider,
    Value<String?>? fullName,
    Value<String?>? givenName,
    Value<String?>? familyName,
    Value<String?>? photoUrl,
    Value<String?>? phone,
    Value<String>? role,
    Value<bool>? isActive,
    Value<bool>? isOnboarded,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastLoginAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return CachedUserCompanion(
      id: id ?? this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      authProvider: authProvider ?? this.authProvider,
      fullName: fullName ?? this.fullName,
      givenName: givenName ?? this.givenName,
      familyName: familyName ?? this.familyName,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firebaseUid.present) {
      map['firebase_uid'] = Variable<String>(firebaseUid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (emailVerified.present) {
      map['email_verified'] = Variable<bool>(emailVerified.value);
    }
    if (authProvider.present) {
      map['auth_provider'] = Variable<String>(authProvider.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (givenName.present) {
      map['given_name'] = Variable<String>(givenName.value);
    }
    if (familyName.present) {
      map['family_name'] = Variable<String>(familyName.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isOnboarded.present) {
      map['is_onboarded'] = Variable<bool>(isOnboarded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastLoginAt.present) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedUserCompanion(')
          ..write('id: $id, ')
          ..write('firebaseUid: $firebaseUid, ')
          ..write('email: $email, ')
          ..write('emailVerified: $emailVerified, ')
          ..write('authProvider: $authProvider, ')
          ..write('fullName: $fullName, ')
          ..write('givenName: $givenName, ')
          ..write('familyName: $familyName, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('isOnboarded: $isOnboarded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastLoginAt: $lastLoginAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedPharmaciesTable extends CachedPharmacies
    with TableInfo<$CachedPharmaciesTable, CachedPharmacy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedPharmaciesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _supportsDeliveryMeta = const VerificationMeta(
    'supportsDelivery',
  );
  @override
  late final GeneratedColumn<bool> supportsDelivery = GeneratedColumn<bool>(
    'supports_delivery',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("supports_delivery" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _supportsPickupMeta = const VerificationMeta(
    'supportsPickup',
  );
  @override
  late final GeneratedColumn<bool> supportsPickup = GeneratedColumn<bool>(
    'supports_pickup',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("supports_pickup" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _openingHoursMeta = const VerificationMeta(
    'openingHours',
  );
  @override
  late final GeneratedColumn<String> openingHours = GeneratedColumn<String>(
    'opening_hours',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servicesMeta = const VerificationMeta(
    'services',
  );
  @override
  late final GeneratedColumn<String> services = GeneratedColumn<String>(
    'services',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    address,
    city,
    state,
    country,
    postalCode,
    latitude,
    longitude,
    phone,
    email,
    website,
    isActive,
    isVerified,
    supportsDelivery,
    supportsPickup,
    openingHours,
    services,
    createdAt,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_pharmacies';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedPharmacy> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
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
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('supports_delivery')) {
      context.handle(
        _supportsDeliveryMeta,
        supportsDelivery.isAcceptableOrUnknown(
          data['supports_delivery']!,
          _supportsDeliveryMeta,
        ),
      );
    }
    if (data.containsKey('supports_pickup')) {
      context.handle(
        _supportsPickupMeta,
        supportsPickup.isAcceptableOrUnknown(
          data['supports_pickup']!,
          _supportsPickupMeta,
        ),
      );
    }
    if (data.containsKey('opening_hours')) {
      context.handle(
        _openingHoursMeta,
        openingHours.isAcceptableOrUnknown(
          data['opening_hours']!,
          _openingHoursMeta,
        ),
      );
    }
    if (data.containsKey('services')) {
      context.handle(
        _servicesMeta,
        services.isAcceptableOrUnknown(data['services']!, _servicesMeta),
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedPharmacy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedPharmacy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      supportsDelivery: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}supports_delivery'],
      )!,
      supportsPickup: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}supports_pickup'],
      )!,
      openingHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opening_hours'],
      ),
      services: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}services'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $CachedPharmaciesTable createAlias(String alias) {
    return $CachedPharmaciesTable(attachedDatabase, alias);
  }
}

class CachedPharmacy extends DataClass implements Insertable<CachedPharmacy> {
  final String id;
  final String name;
  final String? description;
  final String address;
  final String city;
  final String? state;
  final String country;
  final String? postalCode;
  final double latitude;
  final double longitude;
  final String? phone;
  final String? email;
  final String? website;
  final bool isActive;
  final bool isVerified;
  final bool supportsDelivery;
  final bool supportsPickup;
  final String? openingHours;
  final String? services;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  const CachedPharmacy({
    required this.id,
    required this.name,
    this.description,
    required this.address,
    required this.city,
    this.state,
    required this.country,
    this.postalCode,
    required this.latitude,
    required this.longitude,
    this.phone,
    this.email,
    this.website,
    required this.isActive,
    required this.isVerified,
    required this.supportsDelivery,
    required this.supportsPickup,
    this.openingHours,
    this.services,
    required this.createdAt,
    required this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    map['country'] = Variable<String>(country);
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String>(postalCode);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_verified'] = Variable<bool>(isVerified);
    map['supports_delivery'] = Variable<bool>(supportsDelivery);
    map['supports_pickup'] = Variable<bool>(supportsPickup);
    if (!nullToAbsent || openingHours != null) {
      map['opening_hours'] = Variable<String>(openingHours);
    }
    if (!nullToAbsent || services != null) {
      map['services'] = Variable<String>(services);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  CachedPharmaciesCompanion toCompanion(bool nullToAbsent) {
    return CachedPharmaciesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      address: Value(address),
      city: Value(city),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
      country: Value(country),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
      latitude: Value(latitude),
      longitude: Value(longitude),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      isActive: Value(isActive),
      isVerified: Value(isVerified),
      supportsDelivery: Value(supportsDelivery),
      supportsPickup: Value(supportsPickup),
      openingHours: openingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(openingHours),
      services: services == null && nullToAbsent
          ? const Value.absent()
          : Value(services),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory CachedPharmacy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPharmacy(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String?>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      website: serializer.fromJson<String?>(json['website']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      supportsDelivery: serializer.fromJson<bool>(json['supportsDelivery']),
      supportsPickup: serializer.fromJson<bool>(json['supportsPickup']),
      openingHours: serializer.fromJson<String?>(json['openingHours']),
      services: serializer.fromJson<String?>(json['services']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String?>(state),
      'country': serializer.toJson<String>(country),
      'postalCode': serializer.toJson<String?>(postalCode),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'website': serializer.toJson<String?>(website),
      'isActive': serializer.toJson<bool>(isActive),
      'isVerified': serializer.toJson<bool>(isVerified),
      'supportsDelivery': serializer.toJson<bool>(supportsDelivery),
      'supportsPickup': serializer.toJson<bool>(supportsPickup),
      'openingHours': serializer.toJson<String?>(openingHours),
      'services': serializer.toJson<String?>(services),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  CachedPharmacy copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? address,
    String? city,
    Value<String?> state = const Value.absent(),
    String? country,
    Value<String?> postalCode = const Value.absent(),
    double? latitude,
    double? longitude,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> website = const Value.absent(),
    bool? isActive,
    bool? isVerified,
    bool? supportsDelivery,
    bool? supportsPickup,
    Value<String?> openingHours = const Value.absent(),
    Value<String?> services = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => CachedPharmacy(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    address: address ?? this.address,
    city: city ?? this.city,
    state: state.present ? state.value : this.state,
    country: country ?? this.country,
    postalCode: postalCode.present ? postalCode.value : this.postalCode,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    website: website.present ? website.value : this.website,
    isActive: isActive ?? this.isActive,
    isVerified: isVerified ?? this.isVerified,
    supportsDelivery: supportsDelivery ?? this.supportsDelivery,
    supportsPickup: supportsPickup ?? this.supportsPickup,
    openingHours: openingHours.present ? openingHours.value : this.openingHours,
    services: services.present ? services.value : this.services,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  CachedPharmacy copyWithCompanion(CachedPharmaciesCompanion data) {
    return CachedPharmacy(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      country: data.country.present ? data.country.value : this.country,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      website: data.website.present ? data.website.value : this.website,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      supportsDelivery: data.supportsDelivery.present
          ? data.supportsDelivery.value
          : this.supportsDelivery,
      supportsPickup: data.supportsPickup.present
          ? data.supportsPickup.value
          : this.supportsPickup,
      openingHours: data.openingHours.present
          ? data.openingHours.value
          : this.openingHours,
      services: data.services.present ? data.services.value : this.services,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedPharmacy(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('postalCode: $postalCode, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('isActive: $isActive, ')
          ..write('isVerified: $isVerified, ')
          ..write('supportsDelivery: $supportsDelivery, ')
          ..write('supportsPickup: $supportsPickup, ')
          ..write('openingHours: $openingHours, ')
          ..write('services: $services, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    description,
    address,
    city,
    state,
    country,
    postalCode,
    latitude,
    longitude,
    phone,
    email,
    website,
    isActive,
    isVerified,
    supportsDelivery,
    supportsPickup,
    openingHours,
    services,
    createdAt,
    updatedAt,
    lastSyncedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPharmacy &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.address == this.address &&
          other.city == this.city &&
          other.state == this.state &&
          other.country == this.country &&
          other.postalCode == this.postalCode &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.website == this.website &&
          other.isActive == this.isActive &&
          other.isVerified == this.isVerified &&
          other.supportsDelivery == this.supportsDelivery &&
          other.supportsPickup == this.supportsPickup &&
          other.openingHours == this.openingHours &&
          other.services == this.services &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class CachedPharmaciesCompanion extends UpdateCompanion<CachedPharmacy> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> address;
  final Value<String> city;
  final Value<String?> state;
  final Value<String> country;
  final Value<String?> postalCode;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> website;
  final Value<bool> isActive;
  final Value<bool> isVerified;
  final Value<bool> supportsDelivery;
  final Value<bool> supportsPickup;
  final Value<String?> openingHours;
  final Value<String?> services;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const CachedPharmaciesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.supportsDelivery = const Value.absent(),
    this.supportsPickup = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.services = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedPharmaciesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required String address,
    required String city,
    this.state = const Value.absent(),
    required String country,
    this.postalCode = const Value.absent(),
    required double latitude,
    required double longitude,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.supportsDelivery = const Value.absent(),
    this.supportsPickup = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.services = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       address = Value(address),
       city = Value(city),
       country = Value(country),
       latitude = Value(latitude),
       longitude = Value(longitude),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CachedPharmacy> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? country,
    Expression<String>? postalCode,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? website,
    Expression<bool>? isActive,
    Expression<bool>? isVerified,
    Expression<bool>? supportsDelivery,
    Expression<bool>? supportsPickup,
    Expression<String>? openingHours,
    Expression<String>? services,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (postalCode != null) 'postal_code': postalCode,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (isActive != null) 'is_active': isActive,
      if (isVerified != null) 'is_verified': isVerified,
      if (supportsDelivery != null) 'supports_delivery': supportsDelivery,
      if (supportsPickup != null) 'supports_pickup': supportsPickup,
      if (openingHours != null) 'opening_hours': openingHours,
      if (services != null) 'services': services,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedPharmaciesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? address,
    Value<String>? city,
    Value<String?>? state,
    Value<String>? country,
    Value<String?>? postalCode,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? website,
    Value<bool>? isActive,
    Value<bool>? isVerified,
    Value<bool>? supportsDelivery,
    Value<bool>? supportsPickup,
    Value<String?>? openingHours,
    Value<String?>? services,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return CachedPharmaciesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      supportsDelivery: supportsDelivery ?? this.supportsDelivery,
      supportsPickup: supportsPickup ?? this.supportsPickup,
      openingHours: openingHours ?? this.openingHours,
      services: services ?? this.services,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (supportsDelivery.present) {
      map['supports_delivery'] = Variable<bool>(supportsDelivery.value);
    }
    if (supportsPickup.present) {
      map['supports_pickup'] = Variable<bool>(supportsPickup.value);
    }
    if (openingHours.present) {
      map['opening_hours'] = Variable<String>(openingHours.value);
    }
    if (services.present) {
      map['services'] = Variable<String>(services.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPharmaciesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('postalCode: $postalCode, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('isActive: $isActive, ')
          ..write('isVerified: $isVerified, ')
          ..write('supportsDelivery: $supportsDelivery, ')
          ..write('supportsPickup: $supportsPickup, ')
          ..write('openingHours: $openingHours, ')
          ..write('services: $services, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
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
  late final $AppointmentsTable appointments = $AppointmentsTable(this);
  late final $CachedUserTable cachedUser = $CachedUserTable(this);
  late final $CachedPharmaciesTable cachedPharmacies = $CachedPharmaciesTable(
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
    appointments,
    cachedUser,
    cachedPharmacies,
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
typedef $$AppointmentsTableCreateCompanionBuilder =
    AppointmentsCompanion Function({
      required String id,
      required String patientId,
      Value<String?> doctorId,
      required String doctorName,
      Value<String?> clinicId,
      Value<String?> clinicName,
      required DateTime appointmentAt,
      Value<DateTime?> appointmentEndAt,
      required String reason,
      required String contactPhone,
      Value<String?> notes,
      required String status,
      required String source,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> cancelledAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$AppointmentsTableUpdateCompanionBuilder =
    AppointmentsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String?> doctorId,
      Value<String> doctorName,
      Value<String?> clinicId,
      Value<String?> clinicName,
      Value<DateTime> appointmentAt,
      Value<DateTime?> appointmentEndAt,
      Value<String> reason,
      Value<String> contactPhone,
      Value<String?> notes,
      Value<String> status,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> cancelledAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$AppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableFilterComposer({
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

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appointmentAt => $composableBuilder(
    column: $table.appointmentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appointmentEndAt => $composableBuilder(
    column: $table.appointmentEndAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableOrderingComposer({
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

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicId => $composableBuilder(
    column: $table.clinicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appointmentAt => $composableBuilder(
    column: $table.appointmentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appointmentEndAt => $composableBuilder(
    column: $table.appointmentEndAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clinicId =>
      $composableBuilder(column: $table.clinicId, builder: (column) => column);

  GeneratedColumn<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get appointmentAt => $composableBuilder(
    column: $table.appointmentAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get appointmentEndAt => $composableBuilder(
    column: $table.appointmentEndAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$AppointmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppointmentsTable,
          Appointment,
          $$AppointmentsTableFilterComposer,
          $$AppointmentsTableOrderingComposer,
          $$AppointmentsTableAnnotationComposer,
          $$AppointmentsTableCreateCompanionBuilder,
          $$AppointmentsTableUpdateCompanionBuilder,
          (
            Appointment,
            BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>,
          ),
          Appointment,
          PrefetchHooks Function()
        > {
  $$AppointmentsTableTableManager(_$AppDatabase db, $AppointmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String?> doctorId = const Value.absent(),
                Value<String> doctorName = const Value.absent(),
                Value<String?> clinicId = const Value.absent(),
                Value<String?> clinicName = const Value.absent(),
                Value<DateTime> appointmentAt = const Value.absent(),
                Value<DateTime?> appointmentEndAt = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> contactPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppointmentsCompanion(
                id: id,
                patientId: patientId,
                doctorId: doctorId,
                doctorName: doctorName,
                clinicId: clinicId,
                clinicName: clinicName,
                appointmentAt: appointmentAt,
                appointmentEndAt: appointmentEndAt,
                reason: reason,
                contactPhone: contactPhone,
                notes: notes,
                status: status,
                source: source,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cancelledAt: cancelledAt,
                deletedAt: deletedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<String?> doctorId = const Value.absent(),
                required String doctorName,
                Value<String?> clinicId = const Value.absent(),
                Value<String?> clinicName = const Value.absent(),
                required DateTime appointmentAt,
                Value<DateTime?> appointmentEndAt = const Value.absent(),
                required String reason,
                required String contactPhone,
                Value<String?> notes = const Value.absent(),
                required String status,
                required String source,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> cancelledAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppointmentsCompanion.insert(
                id: id,
                patientId: patientId,
                doctorId: doctorId,
                doctorName: doctorName,
                clinicId: clinicId,
                clinicName: clinicName,
                appointmentAt: appointmentAt,
                appointmentEndAt: appointmentEndAt,
                reason: reason,
                contactPhone: contactPhone,
                notes: notes,
                status: status,
                source: source,
                createdAt: createdAt,
                updatedAt: updatedAt,
                cancelledAt: cancelledAt,
                deletedAt: deletedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppointmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppointmentsTable,
      Appointment,
      $$AppointmentsTableFilterComposer,
      $$AppointmentsTableOrderingComposer,
      $$AppointmentsTableAnnotationComposer,
      $$AppointmentsTableCreateCompanionBuilder,
      $$AppointmentsTableUpdateCompanionBuilder,
      (
        Appointment,
        BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>,
      ),
      Appointment,
      PrefetchHooks Function()
    >;
typedef $$CachedUserTableCreateCompanionBuilder =
    CachedUserCompanion Function({
      required String id,
      required String firebaseUid,
      required String email,
      required bool emailVerified,
      required String authProvider,
      Value<String?> fullName,
      Value<String?> givenName,
      Value<String?> familyName,
      Value<String?> photoUrl,
      Value<String?> phone,
      required String role,
      required bool isActive,
      Value<bool> isOnboarded,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> lastLoginAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$CachedUserTableUpdateCompanionBuilder =
    CachedUserCompanion Function({
      Value<String> id,
      Value<String> firebaseUid,
      Value<String> email,
      Value<bool> emailVerified,
      Value<String> authProvider,
      Value<String?> fullName,
      Value<String?> givenName,
      Value<String?> familyName,
      Value<String?> photoUrl,
      Value<String?> phone,
      Value<String> role,
      Value<bool> isActive,
      Value<bool> isOnboarded,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastLoginAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$CachedUserTableFilterComposer
    extends Composer<_$AppDatabase, $CachedUserTable> {
  $$CachedUserTableFilterComposer({
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

  ColumnFilters<String> get firebaseUid => $composableBuilder(
    column: $table.firebaseUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get emailVerified => $composableBuilder(
    column: $table.emailVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authProvider => $composableBuilder(
    column: $table.authProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get givenName => $composableBuilder(
    column: $table.givenName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get familyName => $composableBuilder(
    column: $table.familyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOnboarded => $composableBuilder(
    column: $table.isOnboarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedUserTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedUserTable> {
  $$CachedUserTableOrderingComposer({
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

  ColumnOrderings<String> get firebaseUid => $composableBuilder(
    column: $table.firebaseUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get emailVerified => $composableBuilder(
    column: $table.emailVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authProvider => $composableBuilder(
    column: $table.authProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get givenName => $composableBuilder(
    column: $table.givenName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get familyName => $composableBuilder(
    column: $table.familyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnboarded => $composableBuilder(
    column: $table.isOnboarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedUserTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedUserTable> {
  $$CachedUserTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firebaseUid => $composableBuilder(
    column: $table.firebaseUid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get emailVerified => $composableBuilder(
    column: $table.emailVerified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authProvider => $composableBuilder(
    column: $table.authProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get givenName =>
      $composableBuilder(column: $table.givenName, builder: (column) => column);

  GeneratedColumn<String> get familyName => $composableBuilder(
    column: $table.familyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isOnboarded => $composableBuilder(
    column: $table.isOnboarded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLoginAt => $composableBuilder(
    column: $table.lastLoginAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$CachedUserTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedUserTable,
          CachedUserData,
          $$CachedUserTableFilterComposer,
          $$CachedUserTableOrderingComposer,
          $$CachedUserTableAnnotationComposer,
          $$CachedUserTableCreateCompanionBuilder,
          $$CachedUserTableUpdateCompanionBuilder,
          (
            CachedUserData,
            BaseReferences<_$AppDatabase, $CachedUserTable, CachedUserData>,
          ),
          CachedUserData,
          PrefetchHooks Function()
        > {
  $$CachedUserTableTableManager(_$AppDatabase db, $CachedUserTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedUserTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedUserTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedUserTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> firebaseUid = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<bool> emailVerified = const Value.absent(),
                Value<String> authProvider = const Value.absent(),
                Value<String?> fullName = const Value.absent(),
                Value<String?> givenName = const Value.absent(),
                Value<String?> familyName = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isOnboarded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastLoginAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedUserCompanion(
                id: id,
                firebaseUid: firebaseUid,
                email: email,
                emailVerified: emailVerified,
                authProvider: authProvider,
                fullName: fullName,
                givenName: givenName,
                familyName: familyName,
                photoUrl: photoUrl,
                phone: phone,
                role: role,
                isActive: isActive,
                isOnboarded: isOnboarded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastLoginAt: lastLoginAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String firebaseUid,
                required String email,
                required bool emailVerified,
                required String authProvider,
                Value<String?> fullName = const Value.absent(),
                Value<String?> givenName = const Value.absent(),
                Value<String?> familyName = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                required String role,
                required bool isActive,
                Value<bool> isOnboarded = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> lastLoginAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedUserCompanion.insert(
                id: id,
                firebaseUid: firebaseUid,
                email: email,
                emailVerified: emailVerified,
                authProvider: authProvider,
                fullName: fullName,
                givenName: givenName,
                familyName: familyName,
                photoUrl: photoUrl,
                phone: phone,
                role: role,
                isActive: isActive,
                isOnboarded: isOnboarded,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastLoginAt: lastLoginAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedUserTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedUserTable,
      CachedUserData,
      $$CachedUserTableFilterComposer,
      $$CachedUserTableOrderingComposer,
      $$CachedUserTableAnnotationComposer,
      $$CachedUserTableCreateCompanionBuilder,
      $$CachedUserTableUpdateCompanionBuilder,
      (
        CachedUserData,
        BaseReferences<_$AppDatabase, $CachedUserTable, CachedUserData>,
      ),
      CachedUserData,
      PrefetchHooks Function()
    >;
typedef $$CachedPharmaciesTableCreateCompanionBuilder =
    CachedPharmaciesCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      required String address,
      required String city,
      Value<String?> state,
      required String country,
      Value<String?> postalCode,
      required double latitude,
      required double longitude,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> website,
      Value<bool> isActive,
      Value<bool> isVerified,
      Value<bool> supportsDelivery,
      Value<bool> supportsPickup,
      Value<String?> openingHours,
      Value<String?> services,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$CachedPharmaciesTableUpdateCompanionBuilder =
    CachedPharmaciesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String> address,
      Value<String> city,
      Value<String?> state,
      Value<String> country,
      Value<String?> postalCode,
      Value<double> latitude,
      Value<double> longitude,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> website,
      Value<bool> isActive,
      Value<bool> isVerified,
      Value<bool> supportsDelivery,
      Value<bool> supportsPickup,
      Value<String?> openingHours,
      Value<String?> services,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$CachedPharmaciesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedPharmaciesTable> {
  $$CachedPharmaciesTableFilterComposer({
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

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
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

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get supportsDelivery => $composableBuilder(
    column: $table.supportsDelivery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get supportsPickup => $composableBuilder(
    column: $table.supportsPickup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get services => $composableBuilder(
    column: $table.services,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedPharmaciesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedPharmaciesTable> {
  $$CachedPharmaciesTableOrderingComposer({
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

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
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

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get supportsDelivery => $composableBuilder(
    column: $table.supportsDelivery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get supportsPickup => $composableBuilder(
    column: $table.supportsPickup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get services => $composableBuilder(
    column: $table.services,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedPharmaciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedPharmaciesTable> {
  $$CachedPharmaciesTableAnnotationComposer({
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

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get supportsDelivery => $composableBuilder(
    column: $table.supportsDelivery,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get supportsPickup => $composableBuilder(
    column: $table.supportsPickup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get services =>
      $composableBuilder(column: $table.services, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$CachedPharmaciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedPharmaciesTable,
          CachedPharmacy,
          $$CachedPharmaciesTableFilterComposer,
          $$CachedPharmaciesTableOrderingComposer,
          $$CachedPharmaciesTableAnnotationComposer,
          $$CachedPharmaciesTableCreateCompanionBuilder,
          $$CachedPharmaciesTableUpdateCompanionBuilder,
          (
            CachedPharmacy,
            BaseReferences<
              _$AppDatabase,
              $CachedPharmaciesTable,
              CachedPharmacy
            >,
          ),
          CachedPharmacy,
          PrefetchHooks Function()
        > {
  $$CachedPharmaciesTableTableManager(
    _$AppDatabase db,
    $CachedPharmaciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedPharmaciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedPharmaciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedPharmaciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<bool> supportsDelivery = const Value.absent(),
                Value<bool> supportsPickup = const Value.absent(),
                Value<String?> openingHours = const Value.absent(),
                Value<String?> services = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedPharmaciesCompanion(
                id: id,
                name: name,
                description: description,
                address: address,
                city: city,
                state: state,
                country: country,
                postalCode: postalCode,
                latitude: latitude,
                longitude: longitude,
                phone: phone,
                email: email,
                website: website,
                isActive: isActive,
                isVerified: isVerified,
                supportsDelivery: supportsDelivery,
                supportsPickup: supportsPickup,
                openingHours: openingHours,
                services: services,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required String address,
                required String city,
                Value<String?> state = const Value.absent(),
                required String country,
                Value<String?> postalCode = const Value.absent(),
                required double latitude,
                required double longitude,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<bool> supportsDelivery = const Value.absent(),
                Value<bool> supportsPickup = const Value.absent(),
                Value<String?> openingHours = const Value.absent(),
                Value<String?> services = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedPharmaciesCompanion.insert(
                id: id,
                name: name,
                description: description,
                address: address,
                city: city,
                state: state,
                country: country,
                postalCode: postalCode,
                latitude: latitude,
                longitude: longitude,
                phone: phone,
                email: email,
                website: website,
                isActive: isActive,
                isVerified: isVerified,
                supportsDelivery: supportsDelivery,
                supportsPickup: supportsPickup,
                openingHours: openingHours,
                services: services,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedPharmaciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedPharmaciesTable,
      CachedPharmacy,
      $$CachedPharmaciesTableFilterComposer,
      $$CachedPharmaciesTableOrderingComposer,
      $$CachedPharmaciesTableAnnotationComposer,
      $$CachedPharmaciesTableCreateCompanionBuilder,
      $$CachedPharmaciesTableUpdateCompanionBuilder,
      (
        CachedPharmacy,
        BaseReferences<_$AppDatabase, $CachedPharmaciesTable, CachedPharmacy>,
      ),
      CachedPharmacy,
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
  $$AppointmentsTableTableManager get appointments =>
      $$AppointmentsTableTableManager(_db, _db.appointments);
  $$CachedUserTableTableManager get cachedUser =>
      $$CachedUserTableTableManager(_db, _db.cachedUser);
  $$CachedPharmaciesTableTableManager get cachedPharmacies =>
      $$CachedPharmaciesTableTableManager(_db, _db.cachedPharmacies);
}
