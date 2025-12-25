import 'package:drift/drift.dart';

class AccessibilitySettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get hearingLevel => text().withDefault(const Constant('none'))();
  TextColumn get visionLevel => text().withDefault(const Constant('none'))();
  TextColumn get mobilityLevel => text().withDefault(const Constant('none'))();
  BoolColumn get isOlderPerson =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();
}

class SavedAddresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

class RecentLocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get accessedAt => dateTime()();
}

class CurrentLocation extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
}
