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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'medico24.sqlite'));
    return NativeDatabase(file);
  });
}
