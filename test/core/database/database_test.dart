import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:medico24/core/database/database.dart';

// Create test database class
class TestDatabase extends AppDatabase {
  TestDatabase(QueryExecutor executor) : super.forTesting(executor);
}

void main() {
  late TestDatabase database;

  setUp(() {
    // Create in-memory database for testing
    database = TestDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Database - Pharmacy Caching', () {
    test('insertOrUpdateCachedPharmacy inserts new pharmacy', () async {
      // Arrange
      final pharmacy = CachedPharmaciesCompanion(
        id: const Value('1'),
        name: const Value('Test Pharmacy'),
        description: const Value('Test description'),
        address: const Value('123 Test St'),
        city: const Value('Test City'),
        state: const Value('Test State'),
        country: const Value('Test Country'),
        postalCode: const Value('12345'),
        latitude: const Value(40.7128),
        longitude: const Value(-74.0060),
        phone: const Value('+1234567890'),
        email: const Value('test@pharmacy.com'),
        website: const Value.absent(),
        isActive: const Value(true),
        isVerified: const Value(true),
        supportsDelivery: const Value(true),
        supportsPickup: const Value(true),
        openingHours: const Value.absent(),
        services: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        lastSyncedAt: Value(DateTime.now()),
      );

      // Act
      await database.insertOrUpdateCachedPharmacy(pharmacy);

      // Assert
      final result = await database.getAllCachedPharmacies();
      expect(result.length, 1);
      expect(result[0].name, 'Test Pharmacy');
    });

    test('insertOrUpdateCachedPharmacy updates existing pharmacy', () async {
      // Arrange
      final pharmacy1 = CachedPharmaciesCompanion(
        id: const Value('1'),
        name: const Value('Test Pharmacy'),
        description: const Value('Test description'),
        address: const Value('123 Test St'),
        city: const Value('Test City'),
        state: const Value('Test State'),
        country: const Value('Test Country'),
        postalCode: const Value('12345'),
        latitude: const Value(40.7128),
        longitude: const Value(-74.0060),
        phone: const Value('+1234567890'),
        email: const Value('test@pharmacy.com'),
        website: const Value.absent(),
        isActive: const Value(true),
        isVerified: const Value(true),
        supportsDelivery: const Value(true),
        supportsPickup: const Value(true),
        openingHours: const Value.absent(),
        services: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        lastSyncedAt: Value(DateTime.now()),
      );

      await database.insertOrUpdateCachedPharmacy(pharmacy1);

      final pharmacy2 = CachedPharmaciesCompanion(
        id: const Value('1'),
        name: const Value('Updated Pharmacy'),
        description: const Value('Updated description'),
        address: const Value('456 Updated St'),
        city: const Value('Updated City'),
        state: const Value('Updated State'),
        country: const Value('Updated Country'),
        postalCode: const Value('54321'),
        latitude: const Value(40.7580),
        longitude: const Value(-73.9855),
        phone: const Value('+0987654321'),
        email: const Value('updated@pharmacy.com'),
        website: const Value.absent(),
        isActive: const Value(true),
        isVerified: const Value(false),
        supportsDelivery: const Value(false),
        supportsPickup: const Value(true),
        openingHours: const Value.absent(),
        services: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        lastSyncedAt: Value(DateTime.now()),
      );

      // Act
      await database.insertOrUpdateCachedPharmacy(pharmacy2);

      // Assert
      final result = await database.getAllCachedPharmacies();
      expect(result.length, 1);
      expect(result[0].name, 'Updated Pharmacy');
      expect(result[0].isVerified, false);
    });

    test('getNearbyPharmacies returns pharmacies within radius', () async {
      // Arrange - Insert pharmacies at different locations
      final pharmacy1 = CachedPharmaciesCompanion(
        id: const Value('1'),
        name: const Value('Nearby Pharmacy'),
        description: const Value.absent(),
        address: const Value('123 Test St'),
        city: const Value('Test City'),
        state: const Value.absent(),
        country: const Value('Test Country'),
        postalCode: const Value.absent(),
        latitude: const Value(40.7128),
        longitude: const Value(-74.0060),
        phone: const Value.absent(),
        email: const Value.absent(),
        website: const Value.absent(),
        isActive: const Value(true),
        isVerified: const Value(true),
        supportsDelivery: const Value(true),
        supportsPickup: const Value(true),
        openingHours: const Value.absent(),
        services: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        lastSyncedAt: Value(DateTime.now()),
      );

      final pharmacy2 = CachedPharmaciesCompanion(
        id: const Value('2'),
        name: const Value('Far Away Pharmacy'),
        description: const Value.absent(),
        address: const Value('456 Test St'),
        city: const Value('Test City'),
        state: const Value.absent(),
        country: const Value('Test Country'),
        postalCode: const Value.absent(),
        latitude: const Value(41.0000), // Far away
        longitude: const Value(-75.0000),
        phone: const Value.absent(),
        email: const Value.absent(),
        website: const Value.absent(),
        isActive: const Value(true),
        isVerified: const Value(true),
        supportsDelivery: const Value(true),
        supportsPickup: const Value(true),
        openingHours: const Value.absent(),
        services: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        lastSyncedAt: Value(DateTime.now()),
      );

      await database.insertOrUpdateCachedPharmacies([pharmacy1, pharmacy2]);

      // Act
      final result = await database.getNearbyPharmacies(40.7128, -74.0060, 10);

      // Assert
      expect(result.length, 1);
      expect(result[0].name, 'Nearby Pharmacy');
    });

    test('getCachedPharmacyById returns correct pharmacy', () async {
      // Arrange
      final pharmacy = CachedPharmaciesCompanion(
        id: const Value('test-123'),
        name: const Value('Test Pharmacy'),
        description: const Value.absent(),
        address: const Value('123 Test St'),
        city: const Value('Test City'),
        state: const Value.absent(),
        country: const Value('Test Country'),
        postalCode: const Value.absent(),
        latitude: const Value(40.7128),
        longitude: const Value(-74.0060),
        phone: const Value.absent(),
        email: const Value.absent(),
        website: const Value.absent(),
        isActive: const Value(true),
        isVerified: const Value(true),
        supportsDelivery: const Value(true),
        supportsPickup: const Value(true),
        openingHours: const Value.absent(),
        services: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        lastSyncedAt: Value(DateTime.now()),
      );

      await database.insertOrUpdateCachedPharmacy(pharmacy);

      // Act
      final result = await database.getCachedPharmacyById('test-123');

      // Assert
      expect(result, isNotNull);
      expect(result!.id, 'test-123');
      expect(result.name, 'Test Pharmacy');
    });

    test('clearCachedPharmacies removes all pharmacies', () async {
      // Arrange
      final pharmacy = CachedPharmaciesCompanion(
        id: const Value('1'),
        name: const Value('Test Pharmacy'),
        description: const Value.absent(),
        address: const Value('123 Test St'),
        city: const Value('Test City'),
        state: const Value.absent(),
        country: const Value('Test Country'),
        postalCode: const Value.absent(),
        latitude: const Value(40.7128),
        longitude: const Value(-74.0060),
        phone: const Value.absent(),
        email: const Value.absent(),
        website: const Value.absent(),
        isActive: const Value(true),
        isVerified: const Value(true),
        supportsDelivery: const Value(true),
        supportsPickup: const Value(true),
        openingHours: const Value.absent(),
        services: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        lastSyncedAt: Value(DateTime.now()),
      );

      await database.insertOrUpdateCachedPharmacy(pharmacy);

      // Act
      await database.clearCachedPharmacies();

      // Assert
      final result = await database.getAllCachedPharmacies();
      expect(result.length, 0);
    });
  });
}
