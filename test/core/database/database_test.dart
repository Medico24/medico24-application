import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:medico24/core/database/database.dart';

// Create test database class
class TestDatabase extends AppDatabase {
  TestDatabase(super.executor) : super.forTesting();
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

  group('Database - Location Management', () {
    test(
      'updateCurrentLocation inserts new location with coordinates',
      () async {
        // Act
        await database.updateCurrentLocation(
          title: 'Home',
          address: '123 Main St, City, State',
          city: 'Test City',
          latitude: 40.7128,
          longitude: -74.0060,
        );

        // Assert
        final result = await database.getCurrentLocation();
        expect(result, isNotNull);
        expect(result!.title, 'Home');
        expect(result.latitude, 40.7128);
        expect(result.longitude, -74.0060);
        expect(result.city, 'Test City');
      },
    );

    test('updateCurrentLocation updates existing location', () async {
      // Arrange - Insert initial location
      await database.updateCurrentLocation(
        title: 'Home',
        address: '123 Main St',
        city: 'Old City',
        latitude: 40.7128,
        longitude: -74.0060,
      );

      // Act - Update to new location
      await database.updateCurrentLocation(
        title: 'Work',
        address: '456 Office Blvd',
        city: 'New City',
        latitude: 34.0522,
        longitude: -118.2437,
      );

      // Assert
      final result = await database.getCurrentLocation();
      expect(result, isNotNull);
      expect(result!.title, 'Work');
      expect(result.latitude, 34.0522);
      expect(result.longitude, -118.2437);
      expect(result.city, 'New City');
    });

    test('addSavedAddress saves address with coordinates', () async {
      // Act
      await database.addSavedAddress(
        title: 'Home',
        address: '123 Main St, City, State',
        city: 'Test City',
        latitude: 40.7128,
        longitude: -74.0060,
        isDefault: true,
      );

      // Assert
      final result = await database.getAllSavedAddresses();
      expect(result.length, 1);
      expect(result[0].title, 'Home');
      expect(result[0].latitude, 40.7128);
      expect(result[0].longitude, -74.0060);
      expect(result[0].isDefault, true);
    });

    test('addRecentLocation saves recent location with coordinates', () async {
      // Act
      await database.addRecentLocation(
        address: '789 Recent Ave',
        city: 'Recent City',
        latitude: 51.5074,
        longitude: -0.1278,
      );

      // Assert
      final result = await database.getRecentLocations(limit: 10);
      expect(result.length, 1);
      expect(result[0].address, '789 Recent Ave');
      expect(result[0].latitude, 51.5074);
      expect(result[0].longitude, -0.1278);
    });

    test('getCurrentLocation returns null when no location is set', () async {
      // Act
      final result = await database.getCurrentLocation();

      // Assert
      expect(result, isNull);
    });

    test('deleteSavedAddress removes address', () async {
      // Arrange
      await database.addSavedAddress(
        title: 'Work',
        address: '456 Office Blvd',
        city: 'Work City',
        latitude: 34.0522,
        longitude: -118.2437,
      );

      final addresses = await database.getAllSavedAddresses();
      final addressId = addresses[0].id;

      // Act
      await database.deleteSavedAddress(addressId);

      // Assert
      final result = await database.getAllSavedAddresses();
      expect(result.length, 0);
    });

    test('getRecentLocations limits results correctly', () async {
      // Arrange - Add multiple recent locations
      for (int i = 0; i < 10; i++) {
        await database.addRecentLocation(
          address: 'Address $i',
          city: 'City $i',
          latitude: 40.0 + i,
          longitude: -74.0 + i,
        );
      }

      // Act
      final result = await database.getRecentLocations(limit: 5);

      // Assert
      expect(result.length, 5);
    });
  });
}
