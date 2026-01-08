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

class Appointments extends Table {
  TextColumn get id => text()(); // Server-generated UUID
  TextColumn get patientId => text()();
  TextColumn get doctorId => text().nullable()();
  TextColumn get doctorName => text()();
  TextColumn get clinicId => text().nullable()();
  TextColumn get clinicName => text().nullable()();
  DateTimeColumn get appointmentAt => dateTime()();
  DateTimeColumn get appointmentEndAt => dateTime().nullable()();
  TextColumn get reason => text()();
  TextColumn get contactPhone => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get status =>
      text()(); // scheduled, confirmed, rescheduled, cancelled, completed, no_show
  TextColumn get source =>
      text()(); // patient_app, doctor_app, admin_panel, api
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get cancelledAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedUser extends Table {
  TextColumn get id => text()();
  TextColumn get firebaseUid => text()();
  TextColumn get email => text()();
  BoolColumn get emailVerified => boolean()();
  TextColumn get authProvider => text()();
  TextColumn get fullName => text().nullable()();
  TextColumn get givenName => text().nullable()();
  TextColumn get familyName => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get role => text()();
  BoolColumn get isActive => boolean()();
  BoolColumn get isOnboarded => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastLoginAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedPharmacies extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  TextColumn get state => text().nullable()();
  TextColumn get country => text()();
  TextColumn get postalCode => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get website => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  BoolColumn get supportsDelivery =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get supportsPickup =>
      boolean().withDefault(const Constant(true))();
  TextColumn get openingHours => text().nullable()();
  TextColumn get services => text().nullable()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
