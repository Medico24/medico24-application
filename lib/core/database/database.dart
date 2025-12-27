import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    AccessibilitySettings,
    SavedAddresses,
    RecentLocations,
    CurrentLocation,
    Appointments,
    CachedUser,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Add new tables for version 2
        await m.createTable(appointments);
        await m.createTable(cachedUser);
      }
      if (from < 3) {
        // Recreate appointments and cachedUser tables with new schema
        await m.deleteTable('appointments');
        await m.deleteTable('cached_user');
        await m.createTable(appointments);
        await m.createTable(cachedUser);
      }
    },
  );

  // Accessibility Settings Methods
  Future<AccessibilitySetting?> getAccessibilitySettings() async {
    return await (select(accessibilitySettings)..limit(1)).getSingleOrNull();
  }

  Future<int> updateAccessibilitySettings({
    required String hearingLevel,
    required String visionLevel,
    required String mobilityLevel,
    required bool isOlderPerson,
  }) async {
    final existing = await getAccessibilitySettings();

    if (existing == null) {
      return await into(accessibilitySettings).insert(
        AccessibilitySettingsCompanion.insert(
          hearingLevel: Value(hearingLevel),
          visionLevel: Value(visionLevel),
          mobilityLevel: Value(mobilityLevel),
          isOlderPerson: Value(isOlderPerson),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      return await (update(
        accessibilitySettings,
      )..where((tbl) => tbl.id.equals(existing.id))).write(
        AccessibilitySettingsCompanion(
          hearingLevel: Value(hearingLevel),
          visionLevel: Value(visionLevel),
          mobilityLevel: Value(mobilityLevel),
          isOlderPerson: Value(isOlderPerson),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Saved Addresses Methods
  Future<List<SavedAddressesData>> getAllSavedAddresses() {
    return (select(savedAddresses)..orderBy([
          (t) => OrderingTerm(expression: t.isDefault, mode: OrderingMode.desc),
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .get();
  }

  Future<int> addSavedAddress({
    required String title,
    required String address,
    required String city,
    double? latitude,
    double? longitude,
    bool isDefault = false,
  }) {
    return into(savedAddresses).insert(
      SavedAddressesCompanion.insert(
        title: title,
        address: address,
        city: city,
        latitude: Value(latitude),
        longitude: Value(longitude),
        isDefault: Value(isDefault),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<int> deleteSavedAddress(int id) {
    return (delete(savedAddresses)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Recent Locations Methods
  Future<List<RecentLocation>> getRecentLocations({int limit = 5}) {
    return (select(recentLocations)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.accessedAt, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .get();
  }

  Future<int> addRecentLocation({
    required String address,
    required String city,
    double? latitude,
    double? longitude,
  }) async {
    // Check if location already exists
    final existing = await (select(
      recentLocations,
    )..where((tbl) => tbl.address.equals(address))).getSingleOrNull();

    if (existing != null) {
      // Update accessed time
      return await (update(recentLocations)
            ..where((tbl) => tbl.id.equals(existing.id)))
          .write(RecentLocationsCompanion(accessedAt: Value(DateTime.now())));
    } else {
      return await into(recentLocations).insert(
        RecentLocationsCompanion.insert(
          address: address,
          city: city,
          latitude: Value(latitude),
          longitude: Value(longitude),
          accessedAt: DateTime.now(),
        ),
      );
    }
  }

  Future<void> clearOldRecentLocations({int keepCount = 10}) async {
    final allRecent =
        await (select(recentLocations)..orderBy([
              (t) => OrderingTerm(
                expression: t.accessedAt,
                mode: OrderingMode.desc,
              ),
            ]))
            .get();

    if (allRecent.length > keepCount) {
      final toDelete = allRecent.skip(keepCount);
      for (final location in toDelete) {
        await (delete(
          recentLocations,
        )..where((tbl) => tbl.id.equals(location.id))).go();
      }
    }
  }

  // Current Location Methods
  Future<CurrentLocationData?> getCurrentLocation() async {
    return await (select(currentLocation)..limit(1)).getSingleOrNull();
  }

  Future<int> updateCurrentLocation({
    required String title,
    required String address,
    required String city,
    double? latitude,
    double? longitude,
  }) async {
    final existing = await getCurrentLocation();

    if (existing == null) {
      return await into(currentLocation).insert(
        CurrentLocationCompanion.insert(
          title: title,
          address: address,
          city: city,
          latitude: Value(latitude),
          longitude: Value(longitude),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      return await (update(
        currentLocation,
      )..where((tbl) => tbl.id.equals(existing.id))).write(
        CurrentLocationCompanion(
          title: Value(title),
          address: Value(address),
          city: Value(city),
          latitude: Value(latitude),
          longitude: Value(longitude),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  // Appointments Methods
  Future<List<Appointment>> getAllAppointments() async {
    return await select(appointments).get();
  }

  Future<List<Appointment>> getAppointmentsByDateRange(
    DateTime fromDate,
    DateTime toDate,
  ) async {
    return await (select(appointments)
          ..where((tbl) => tbl.appointmentAt.isBetweenValues(fromDate, toDate))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.appointmentAt)]))
        .get();
  }

  Future<int> insertAppointment(AppointmentsCompanion appointment) async {
    return await into(appointments).insert(appointment);
  }

  Future<void> insertAppointments(
    List<AppointmentsCompanion> appointmentList,
  ) async {
    await batch((batch) {
      batch.insertAll(
        appointments,
        appointmentList,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<int> updateAppointment(Appointment appointment) async {
    return await (update(
      appointments,
    )..where((tbl) => tbl.id.equals(appointment.id))).write(
      AppointmentsCompanion(
        patientId: Value(appointment.patientId),
        doctorId: Value(appointment.doctorId),
        doctorName: Value(appointment.doctorName),
        clinicId: Value(appointment.clinicId),
        clinicName: Value(appointment.clinicName),
        appointmentAt: Value(appointment.appointmentAt),
        appointmentEndAt: Value(appointment.appointmentEndAt),
        reason: Value(appointment.reason),
        contactPhone: Value(appointment.contactPhone),
        notes: Value(appointment.notes),
        status: Value(appointment.status),
        source: Value(appointment.source),
        updatedAt: Value(appointment.updatedAt),
        cancelledAt: Value(appointment.cancelledAt),
        deletedAt: Value(appointment.deletedAt),
        lastSyncedAt: Value(appointment.lastSyncedAt),
      ),
    );
  }

  Future<int> deleteAppointment(String id) async {
    return await (delete(appointments)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> clearAppointments() async {
    await delete(appointments).go();
  }

  // Cached User Methods
  Future<CachedUserData?> getCachedUser() async {
    return await (select(cachedUser)..limit(1)).getSingleOrNull();
  }

  Future<int> insertOrUpdateCachedUser(CachedUserCompanion user) async {
    return await into(cachedUser).insertOnConflictUpdate(user);
  }

  Future<void> clearCachedUser() async {
    await delete(cachedUser).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'medico24.sqlite'));
    return NativeDatabase(file);
  });
}
