import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import 'package:medico24/core/api/services/pharmacy_api_service.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/repositories/pharmacy_repository.dart';
import 'package:drift/native.dart';

import 'offline_integration_test.mocks.dart';

@GenerateMocks([PharmacyApiService])
void main() {
  group('Offline Integration Test - End to End', () {
    late MockPharmacyApiService mockApiService;
    late AppDatabase database;
    late PharmacyRepository repository;

    setUp(() {
      mockApiService = MockPharmacyApiService();
      // Use in-memory database for testing
      database = AppDatabase.forTesting(NativeDatabase.memory());
      repository = PharmacyRepository(mockApiService, database);
    });

    tearDown(() async {
      await database.close();
    });

    test(
      'Complete offline flow: API success -> cache -> API failure -> cached data',
      () async {
        // Step 1: Create test data
        final testPharmacy = PharmacyModel(
          id: 'test-pharmacy-1',
          name: 'Test Pharmacy',
          description: 'A test pharmacy',
          phone: '+1234567890',
          email: 'test@pharmacy.com',
          isActive: true,
          isVerified: true,
          rating: 4.5,
          ratingCount: 100,
          supportsDelivery: true,
          supportsPickup: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          location: PharmacyLocationModel(
            id: 'loc-1',
            pharmacyId: 'test-pharmacy-1',
            addressLine: '123 Test Street',
            city: 'Test City',
            state: 'Test State',
            country: 'Test Country',
            pincode: '12345',
            latitude: 40.7128,
            longitude: -74.0060,
            createdAt: DateTime.now(),
          ),
        );

        // Step 2: Simulate online - API returns data
        when(
          mockApiService.searchPharmaciesNearby(
            latitude: 40.7128,
            longitude: -74.0060,
            radiusKm: anyNamed('radiusKm'),
            skip: anyNamed('skip'),
            limit: anyNamed('limit'),
            isActive: anyNamed('isActive'),
            isVerified: anyNamed('isVerified'),
            supportsDelivery: anyNamed('supportsDelivery'),
            supportsPickup: anyNamed('supportsPickup'),
          ),
        ).thenAnswer((_) async => [testPharmacy]);

        // Make the first call - should get from API and cache it
        final onlineResult = await repository.searchNearbyPharmacies(
          latitude: 40.7128,
          longitude: -74.0060,
        );

        // Verify API was called
        verify(
          mockApiService.searchPharmaciesNearby(
            latitude: 40.7128,
            longitude: -74.0060,
            radiusKm: anyNamed('radiusKm'),
            skip: anyNamed('skip'),
            limit: anyNamed('limit'),
            isActive: anyNamed('isActive'),
            isVerified: anyNamed('isVerified'),
            supportsDelivery: anyNamed('supportsDelivery'),
            supportsPickup: anyNamed('supportsPickup'),
          ),
        ).called(1);

        // Verify data was returned
        expect(onlineResult.length, 1);
        expect(onlineResult[0].id, 'test-pharmacy-1');
        expect(onlineResult[0].name, 'Test Pharmacy');

        // Step 3: Verify data was cached in database
        final cachedData = await database.getAllCachedPharmacies();
        expect(cachedData.length, 1);
        expect(cachedData[0].id, 'test-pharmacy-1');
        expect(cachedData[0].name, 'Test Pharmacy');

        // Step 4: Simulate offline - API throws error
        when(
          mockApiService.searchPharmaciesNearby(
            latitude: 40.7128,
            longitude: -74.0060,
            radiusKm: anyNamed('radiusKm'),
            skip: anyNamed('skip'),
            limit: anyNamed('limit'),
            isActive: anyNamed('isActive'),
            isVerified: anyNamed('isVerified'),
            supportsDelivery: anyNamed('supportsDelivery'),
            supportsPickup: anyNamed('supportsPickup'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/pharmacies/nearby'),
            type: DioExceptionType.connectionError,
            message: 'No internet connection',
          ),
        );

        // Make the second call - should get from cache
        final offlineResult = await repository.searchNearbyPharmacies(
          latitude: 40.7128,
          longitude: -74.0060,
        );

        // Verify we got cached data
        expect(offlineResult.length, 1);
        expect(offlineResult[0].id, 'test-pharmacy-1');
        expect(offlineResult[0].name, 'Test Pharmacy');
        expect(offlineResult[0].location?.addressLine, '123 Test Street');

        // Step 5: Verify we can access cached data directly
        final directCache = await repository.getCachedNearbyPharmacies(
          latitude: 40.7128,
          longitude: -74.0060,
        );
        expect(directCache.length, 1);
        expect(directCache[0].name, 'Test Pharmacy');
      },
    );

    test('getPharmacyById works offline after initial cache', () async {
      // Create test pharmacy
      final testPharmacy = PharmacyModel(
        id: 'pharmacy-123',
        name: 'Offline Test Pharmacy',
        description: null,
        phone: '+9876543210',
        email: 'offline@test.com',
        isActive: true,
        isVerified: false,
        rating: 3.5,
        ratingCount: 50,
        supportsDelivery: false,
        supportsPickup: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        location: PharmacyLocationModel(
          id: 'loc-123',
          pharmacyId: 'pharmacy-123',
          addressLine: '456 Offline Ave',
          city: 'Cache City',
          country: 'Local',
          latitude: 41.0,
          longitude: -75.0,
          createdAt: DateTime.now(),
        ),
      );

      // Online: Get pharmacy by ID
      when(
        mockApiService.getPharmacyById('pharmacy-123'),
      ).thenAnswer((_) async => testPharmacy);

      final onlinePharmacy = await repository.getPharmacyById('pharmacy-123');
      expect(onlinePharmacy.name, 'Offline Test Pharmacy');

      // Simulate offline
      when(mockApiService.getPharmacyById('pharmacy-123')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/pharmacies/pharmacy-123'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      // Offline: Should return cached data
      final offlinePharmacy = await repository.getPharmacyById('pharmacy-123');
      expect(offlinePharmacy.name, 'Offline Test Pharmacy');
      expect(offlinePharmacy.location?.city, 'Cache City');
    });

    test('Multiple pharmacies can be cached and retrieved', () async {
      final pharmacies = List.generate(
        5,
        (i) => PharmacyModel(
          id: 'pharmacy-$i',
          name: 'Pharmacy $i',
          description: 'Description $i',
          phone: '+123456789$i',
          email: 'pharmacy$i@test.com',
          isActive: true,
          isVerified: i % 2 == 0,
          rating: 3.0 + i * 0.5,
          ratingCount: i * 10,
          supportsDelivery: i % 2 == 0,
          supportsPickup: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          location: PharmacyLocationModel(
            id: 'loc-$i',
            pharmacyId: 'pharmacy-$i',
            addressLine: '$i Test Street',
            city: 'City $i',
            country: 'Country',
            latitude: 40.0 + i * 0.01,
            longitude: -74.0 + i * 0.01,
            createdAt: DateTime.now(),
          ),
        ),
      );

      // Online: Get all pharmacies
      when(
        mockApiService.getPharmacies(
          skip: anyNamed('skip'),
          limit: anyNamed('limit'),
          latitude: anyNamed('latitude'),
          longitude: anyNamed('longitude'),
          radiusKm: anyNamed('radiusKm'),
          isActive: anyNamed('isActive'),
          isVerified: anyNamed('isVerified'),
          supportsDelivery: anyNamed('supportsDelivery'),
          supportsPickup: anyNamed('supportsPickup'),
        ),
      ).thenAnswer((_) async => pharmacies);

      await repository.getPharmacies();

      // Verify all were cached
      final cached = await database.getAllCachedPharmacies();
      expect(cached.length, 5);

      // Simulate offline
      when(
        mockApiService.getPharmacies(
          skip: anyNamed('skip'),
          limit: anyNamed('limit'),
          latitude: anyNamed('latitude'),
          longitude: anyNamed('longitude'),
          radiusKm: anyNamed('radiusKm'),
          isActive: anyNamed('isActive'),
          isVerified: anyNamed('isVerified'),
          supportsDelivery: anyNamed('supportsDelivery'),
          supportsPickup: anyNamed('supportsPickup'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/pharmacies'),
          type: DioExceptionType.connectionError,
        ),
      );

      // Get from cache
      final offlinePharmacies = await repository.getPharmacies();
      expect(offlinePharmacies.length, 5);
      expect(offlinePharmacies.map((p) => p.name).toList(), [
        'Pharmacy 0',
        'Pharmacy 1',
        'Pharmacy 2',
        'Pharmacy 3',
        'Pharmacy 4',
      ]);
    });
  });
}
