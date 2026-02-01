import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:medico24/core/database/database.dart';

void main() {
  late AppDatabase testDatabase;

  setUp(() {
    testDatabase = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await testDatabase.close();
  });

  group('Add Address Screen - Database Integration', () {
    test('saving address should store coordinates in database', () async {
      // Arrange
      const testLatitude = 23.1765;
      const testLongitude = 80.0190;
      const testAddress = 'Test Address, Test City';
      const testCity = 'Test City, Test State';

      // Act - Simulate saving address with coordinates
      await testDatabase.addSavedAddress(
        title: 'Home',
        address: testAddress,
        city: testCity,
        latitude: testLatitude,
        longitude: testLongitude,
        isDefault: true,
      );

      // Assert
      final savedAddresses = await testDatabase.getAllSavedAddresses();
      expect(savedAddresses.length, 1);
      expect(savedAddresses[0].latitude, testLatitude);
      expect(savedAddresses[0].longitude, testLongitude);
      expect(savedAddresses[0].address, testAddress);
    });

    test(
      'saving address should update current location with coordinates',
      () async {
        // Arrange
        const testLatitude = 23.1765;
        const testLongitude = 80.0190;
        const testAddress = 'Test Address';
        const testCity = 'Test City';

        // Act - Simulate the full save flow
        await testDatabase.addSavedAddress(
          title: 'Home',
          address: testAddress,
          city: testCity,
          latitude: testLatitude,
          longitude: testLongitude,
          isDefault: true,
        );

        await testDatabase.updateCurrentLocation(
          title: 'Home',
          address: testAddress,
          city: testCity,
          latitude: testLatitude,
          longitude: testLongitude,
        );

        // Assert
        final currentLocation = await testDatabase.getCurrentLocation();
        expect(currentLocation, isNotNull);
        expect(currentLocation!.latitude, testLatitude);
        expect(currentLocation.longitude, testLongitude);
      },
    );

    test('saving address should add to recent locations', () async {
      // Arrange
      const testLatitude = 23.1765;
      const testLongitude = 80.0190;
      const testAddress = 'Test Address';
      const testCity = 'Test City';

      // Act
      await testDatabase.addRecentLocation(
        address: testAddress,
        city: testCity,
        latitude: testLatitude,
        longitude: testLongitude,
      );

      // Assert
      final recentLocations = await testDatabase.getRecentLocations(limit: 10);
      expect(recentLocations.length, 1);
      expect(recentLocations[0].latitude, testLatitude);
      expect(recentLocations[0].longitude, testLongitude);
    });

    test('current location should be available for environment card', () async {
      // Arrange - Simulate saving an address
      await testDatabase.updateCurrentLocation(
        title: 'Test Location',
        address: 'Test Address',
        city: 'Test City',
        latitude: 40.7128,
        longitude: -74.0060,
      );

      // Act
      final currentLocation = await testDatabase.getCurrentLocation();

      // Assert - Verify coordinates are available for weather/AQI APIs
      expect(currentLocation, isNotNull);
      expect(currentLocation!.latitude, isNotNull);
      expect(currentLocation.longitude, isNotNull);
      expect(currentLocation.latitude, 40.7128);
      expect(currentLocation.longitude, -74.0060);
    });

    test(
      'multiple saved addresses should maintain unique coordinates',
      () async {
        // Arrange & Act - Save multiple addresses
        await testDatabase.addSavedAddress(
          title: 'Home',
          address: 'Home Address',
          city: 'Home City',
          latitude: 40.7128,
          longitude: -74.0060,
        );

        await testDatabase.addSavedAddress(
          title: 'Work',
          address: 'Work Address',
          city: 'Work City',
          latitude: 34.0522,
          longitude: -118.2437,
        );

        // Assert
        final savedAddresses = await testDatabase.getAllSavedAddresses();
        expect(savedAddresses.length, 2);
        expect(savedAddresses[0].latitude, 40.7128);
        expect(savedAddresses[1].latitude, 34.0522);
      },
    );
  });

  group('Location Selection - Current Location Update', () {
    test('selecting saved address should update current location', () async {
      // Arrange - Create a saved address
      await testDatabase.addSavedAddress(
        title: 'Office',
        address: 'Office Address',
        city: 'Office City',
        latitude: 51.5074,
        longitude: -0.1278,
      );

      final savedAddresses = await testDatabase.getAllSavedAddresses();
      final address = savedAddresses[0];

      // Act - Simulate selecting this address
      await testDatabase.updateCurrentLocation(
        title: address.title,
        address: address.address,
        city: address.city,
        latitude: address.latitude,
        longitude: address.longitude,
      );

      // Assert
      final currentLocation = await testDatabase.getCurrentLocation();
      expect(currentLocation, isNotNull);
      expect(currentLocation!.latitude, address.latitude);
      expect(currentLocation.longitude, address.longitude);
    });

    test('selecting recent location should update current location', () async {
      // Arrange - Create a recent location
      await testDatabase.addRecentLocation(
        address: 'Recent Address',
        city: 'Recent City',
        latitude: 48.8566,
        longitude: 2.3522,
      );

      final recentLocations = await testDatabase.getRecentLocations(limit: 1);
      final location = recentLocations[0];

      // Act - Simulate selecting this location
      await testDatabase.updateCurrentLocation(
        title: location.city.split(',').first,
        address: location.address,
        city: location.city,
        latitude: location.latitude,
        longitude: location.longitude,
      );

      // Assert
      final currentLocation = await testDatabase.getCurrentLocation();
      expect(currentLocation, isNotNull);
      expect(currentLocation!.latitude, location.latitude);
      expect(currentLocation.longitude, location.longitude);
    });
  });
}
