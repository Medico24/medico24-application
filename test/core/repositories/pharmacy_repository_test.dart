import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import 'package:medico24/core/api/services/pharmacy_api_service.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/repositories/pharmacy_repository.dart';

import 'pharmacy_repository_test.mocks.dart';

@GenerateMocks([PharmacyApiService, AppDatabase])
void main() {
  late MockPharmacyApiService mockApiService;
  late MockAppDatabase mockDatabase;
  late PharmacyRepository repository;

  setUp(() {
    mockApiService = MockPharmacyApiService();
    mockDatabase = MockAppDatabase();
    repository = PharmacyRepository(mockApiService, mockDatabase);
  });

  group('PharmacyRepository - Offline First Strategy', () {
    final testPharmacies = [
      PharmacyModel(
        id: '1',
        name: 'Test Pharmacy 1',
        description: 'Test description',
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
          id: 'loc1',
          pharmacyId: '1',
          addressLine: '123 Test St',
          city: 'Test City',
          state: 'Test State',
          country: 'Test Country',
          pincode: '12345',
          latitude: 40.7128,
          longitude: -74.0060,
          createdAt: DateTime.now(),
        ),
      ),
    ];

    final cachedPharmacies = [
      CachedPharmacy(
        id: '1',
        name: 'Cached Pharmacy',
        description: 'Cached description',
        address: '123 Cached St',
        city: 'Cached City',
        state: 'Cached State',
        country: 'Cached Country',
        postalCode: '12345',
        latitude: 40.7128,
        longitude: -74.0060,
        phone: '+1234567890',
        email: 'cached@pharmacy.com',
        website: null,
        isActive: true,
        isVerified: true,
        supportsDelivery: true,
        supportsPickup: true,
        openingHours: null,
        services: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastSyncedAt: DateTime.now(),
      ),
    ];

    group('getPharmacies', () {
      test('returns API data and caches it when online', () async {
        // Arrange
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
        ).thenAnswer((_) async => testPharmacies);

        when(
          mockDatabase.insertOrUpdateCachedPharmacies(any),
        ).thenAnswer((_) async => {});

        // Act
        final result = await repository.getPharmacies();

        // Assert
        expect(result, testPharmacies);
        verify(
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
        ).called(1);
        verify(mockDatabase.insertOrUpdateCachedPharmacies(any)).called(1);
      });

      test('returns cached data when API fails with DioException', () async {
        // Arrange
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

        when(
          mockDatabase.getAllCachedPharmacies(),
        ).thenAnswer((_) async => cachedPharmacies);

        // Act
        final result = await repository.getPharmacies();

        // Assert
        expect(result.length, 1);
        expect(result[0].name, 'Cached Pharmacy');
        verify(mockDatabase.getAllCachedPharmacies()).called(1);
      });

      test(
        'returns cached nearby data when API fails with location params',
        () async {
          // Arrange
          const lat = 40.7128;
          const lon = -74.0060;
          const radius = 10.0;

          when(
            mockApiService.getPharmacies(
              skip: anyNamed('skip'),
              limit: anyNamed('limit'),
              latitude: lat,
              longitude: lon,
              radiusKm: radius,
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

          when(
            mockDatabase.getNearbyPharmacies(lat, lon, radius),
          ).thenAnswer((_) async => cachedPharmacies);

          // Act
          final result = await repository.getPharmacies(
            latitude: lat,
            longitude: lon,
            radiusKm: radius,
          );

          // Assert
          expect(result.length, 1);
          verify(mockDatabase.getNearbyPharmacies(lat, lon, radius)).called(1);
        },
      );
    });

    group('searchNearbyPharmacies', () {
      test('returns API data and caches it when online', () async {
        // Arrange
        const lat = 40.7128;
        const lon = -74.0060;

        when(
          mockApiService.searchPharmaciesNearby(
            latitude: lat,
            longitude: lon,
            radiusKm: anyNamed('radiusKm'),
            skip: anyNamed('skip'),
            limit: anyNamed('limit'),
            isActive: anyNamed('isActive'),
            isVerified: anyNamed('isVerified'),
            supportsDelivery: anyNamed('supportsDelivery'),
            supportsPickup: anyNamed('supportsPickup'),
          ),
        ).thenAnswer((_) async => testPharmacies);

        when(
          mockDatabase.insertOrUpdateCachedPharmacies(any),
        ).thenAnswer((_) async => {});

        // Act
        final result = await repository.searchNearbyPharmacies(
          latitude: lat,
          longitude: lon,
        );

        // Assert
        expect(result, testPharmacies);
        verify(mockDatabase.insertOrUpdateCachedPharmacies(any)).called(1);
      });

      test('returns cached data when API fails', () async {
        // Arrange
        const lat = 40.7128;
        const lon = -74.0060;

        when(
          mockApiService.searchPharmaciesNearby(
            latitude: lat,
            longitude: lon,
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
            type: DioExceptionType.connectionTimeout,
          ),
        );

        when(
          mockDatabase.getNearbyPharmacies(lat, lon, any),
        ).thenAnswer((_) async => cachedPharmacies);

        // Act
        final result = await repository.searchNearbyPharmacies(
          latitude: lat,
          longitude: lon,
        );

        // Assert
        expect(result.length, 1);
        expect(result[0].name, 'Cached Pharmacy');
        verify(mockDatabase.getNearbyPharmacies(lat, lon, any)).called(1);
      });
    });

    group('getPharmacyById', () {
      test('returns API data and caches it when online', () async {
        // Arrange
        const pharmacyId = '1';

        when(
          mockApiService.getPharmacyById(pharmacyId),
        ).thenAnswer((_) async => testPharmacies[0]);

        when(
          mockDatabase.insertOrUpdateCachedPharmacies(any),
        ).thenAnswer((_) async => {});

        // Act
        final result = await repository.getPharmacyById(pharmacyId);

        // Assert
        expect(result, testPharmacies[0]);
        verify(mockApiService.getPharmacyById(pharmacyId)).called(1);
        verify(mockDatabase.insertOrUpdateCachedPharmacies(any)).called(1);
      });

      test('returns cached data when API fails', () async {
        // Arrange
        const pharmacyId = '1';

        when(mockApiService.getPharmacyById(pharmacyId)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/pharmacies/$pharmacyId'),
            type: DioExceptionType.receiveTimeout,
          ),
        );

        when(
          mockDatabase.getCachedPharmacyById(pharmacyId),
        ).thenAnswer((_) async => cachedPharmacies[0]);

        // Act
        final result = await repository.getPharmacyById(pharmacyId);

        // Assert
        expect(result.name, 'Cached Pharmacy');
        verify(mockDatabase.getCachedPharmacyById(pharmacyId)).called(1);
      });

      test('throws exception when API fails and no cache exists', () async {
        // Arrange
        const pharmacyId = '999';

        when(mockApiService.getPharmacyById(pharmacyId)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/pharmacies/$pharmacyId'),
            type: DioExceptionType.connectionError,
          ),
        );

        when(
          mockDatabase.getCachedPharmacyById(pharmacyId),
        ).thenAnswer((_) async => null);

        // Act & Assert
        expect(
          () => repository.getPharmacyById(pharmacyId),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('Cache operations', () {
      test('getAllCachedPharmacies returns all cached pharmacies', () async {
        // Arrange
        when(
          mockDatabase.getAllCachedPharmacies(),
        ).thenAnswer((_) async => cachedPharmacies);

        // Act
        final result = await repository.getAllCachedPharmacies();

        // Assert
        expect(result.length, 1);
        expect(result[0].name, 'Cached Pharmacy');
      });

      test(
        'getCachedNearbyPharmacies returns nearby cached pharmacies',
        () async {
          // Arrange
          const lat = 40.7128;
          const lon = -74.0060;
          const radius = 10.0;

          when(
            mockDatabase.getNearbyPharmacies(lat, lon, radius),
          ).thenAnswer((_) async => cachedPharmacies);

          // Act
          final result = await repository.getCachedNearbyPharmacies(
            latitude: lat,
            longitude: lon,
            radiusKm: radius,
          );

          // Assert
          expect(result.length, 1);
          expect(result[0].name, 'Cached Pharmacy');
        },
      );

      test('getCachedPharmacyById returns cached pharmacy by ID', () async {
        // Arrange
        const pharmacyId = '1';

        when(
          mockDatabase.getCachedPharmacyById(pharmacyId),
        ).thenAnswer((_) async => cachedPharmacies[0]);

        // Act
        final result = await repository.getCachedPharmacyById(pharmacyId);

        // Assert
        expect(result, isNotNull);
        expect(result!.name, 'Cached Pharmacy');
      });

      test('getCachedPharmacyById returns null when not found', () async {
        // Arrange
        const pharmacyId = '999';

        when(
          mockDatabase.getCachedPharmacyById(pharmacyId),
        ).thenAnswer((_) async => null);

        // Act
        final result = await repository.getCachedPharmacyById(pharmacyId);

        // Assert
        expect(result, isNull);
      });
    });
  });
}
