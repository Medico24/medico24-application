import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import 'package:medico24/core/api/services/pharmacy_api_service.dart';
import 'package:medico24/core/database/database.dart';

class PharmacyRepository {
  PharmacyRepository(this._apiService, this._database);
  final PharmacyApiService _apiService;
  final AppDatabase _database;
  final Logger _logger = Logger();

  /// Get list of pharmacies with optional filters
  /// Uses offline-first strategy: returns cached data on network error
  Future<List<PharmacyModel>> getPharmacies({
    int skip = 0,
    int limit = 20,
    double? latitude,
    double? longitude,
    double radiusKm = 10.0,
    bool? isActive,
    bool? isVerified,
    bool? supportsDelivery,
    bool? supportsPickup,
  }) async {
    try {
      // Try to fetch from API
      final pharmacies = await _apiService.getPharmacies(
        skip: skip,
        limit: limit,
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        isActive: isActive,
        isVerified: isVerified,
        supportsDelivery: supportsDelivery,
        supportsPickup: supportsPickup,
      );

      // Cache the results
      await _cachePharmacies(pharmacies);

      return pharmacies;
    } on DioException catch (e) {
      _logger.e(
        'Repository error fetching pharmacies, returning cached data: $e',
      );

      // Return cached data on error
      if (latitude != null && longitude != null) {
        return await getCachedNearbyPharmacies(
          latitude: latitude,
          longitude: longitude,
          radiusKm: radiusKm,
        );
      } else {
        return await getAllCachedPharmacies();
      }
    } catch (e) {
      _logger.e('Repository error fetching pharmacies: $e');
      rethrow;
    }
  }

  /// Search for nearby pharmacies using current location
  /// Uses offline-first strategy: returns cached data on network error
  Future<List<PharmacyModel>> searchNearbyPharmacies({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
    int skip = 0,
    int limit = 20,
    bool? isActive,
    bool? isVerified,
    bool? supportsDelivery,
    bool? supportsPickup,
  }) async {
    try {
      // Try to fetch from API
      final pharmacies = await _apiService.searchPharmaciesNearby(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        skip: skip,
        limit: limit,
        isActive: isActive,
        isVerified: isVerified,
        supportsDelivery: supportsDelivery,
        supportsPickup: supportsPickup,
      );

      // Cache the results
      await _cachePharmacies(pharmacies);

      return pharmacies;
    } on DioException catch (e) {
      _logger.e(
        'Repository error searching nearby pharmacies, returning cached data: $e',
      );

      // Return cached data on error
      return await getCachedNearbyPharmacies(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
      );
    } catch (e) {
      _logger.e('Repository error searching nearby pharmacies: $e');
      rethrow;
    }
  }

  /// Get pharmacy details by ID
  /// Uses offline-first strategy: returns cached data on network error
  Future<PharmacyModel> getPharmacyById(String id) async {
    try {
      // Try to fetch from API
      final pharmacy = await _apiService.getPharmacyById(id);

      // Cache the result
      await _cachePharmacies([pharmacy]);

      return pharmacy;
    } on DioException catch (e) {
      _logger.e(
        'Repository error fetching pharmacy details, returning cached data: $e',
      );

      // Return cached data on error
      final cached = await getCachedPharmacyById(id);
      if (cached != null) {
        return cached;
      }
      rethrow;
    } catch (e) {
      _logger.e('Repository error fetching pharmacy details: $e');
      rethrow;
    }
  }

  /// Create a new pharmacy
  Future<PharmacyModel> createPharmacy(PharmacyCreateRequest pharmacy) async {
    try {
      return await _apiService.createPharmacy(pharmacy);
    } catch (e) {
      _logger.e('Repository error creating pharmacy: $e');
      rethrow;
    }
  }

  /// Update pharmacy information
  Future<PharmacyModel> updatePharmacy(
    String id,
    Map<String, dynamic> updates,
  ) async {
    try {
      return await _apiService.updatePharmacy(id, updates);
    } catch (e) {
      _logger.e('Repository error updating pharmacy: $e');
      rethrow;
    }
  }

  /// Delete a pharmacy
  Future<void> deletePharmacy(String id) async {
    try {
      await _apiService.deletePharmacy(id);
    } catch (e) {
      _logger.e('Repository error deleting pharmacy: $e');
      rethrow;
    }
  }

  /// Get pharmacy hours
  Future<List<PharmacyHoursModel>> getPharmacyHours(String pharmacyId) async {
    try {
      return await _apiService.getPharmacyHours(pharmacyId);
    } catch (e) {
      _logger.e('Repository error fetching pharmacy hours: $e');
      rethrow;
    }
  }

  /// Add or update pharmacy hours
  Future<PharmacyHoursModel> addPharmacyHours(
    String pharmacyId,
    PharmacyHoursCreateRequest hours,
  ) async {
    try {
      return await _apiService.addPharmacyHours(pharmacyId, hours);
    } catch (e) {
      _logger.e('Repository error adding pharmacy hours: $e');
      rethrow;
    }
  }

  /// Delete pharmacy hours for a specific day
  Future<void> deletePharmacyHours(String pharmacyId, int dayOfWeek) async {
    try {
      await _apiService.deletePharmacyHours(pharmacyId, dayOfWeek);
    } catch (e) {
      _logger.e('Repository error deleting pharmacy hours: $e');
      rethrow;
    }
  }

  // Cache management methods

  /// Get all cached pharmacies
  Future<List<PharmacyModel>> getAllCachedPharmacies() async {
    try {
      final cached = await _database.getAllCachedPharmacies();
      return cached.map((p) => _convertToModel(p)).toList();
    } catch (e) {
      _logger.e('Error getting all cached pharmacies', error: e);
      return [];
    }
  }

  /// Get nearby cached pharmacies
  Future<List<PharmacyModel>> getCachedNearbyPharmacies({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    try {
      final cached = await _database.getNearbyPharmacies(
        latitude,
        longitude,
        radiusKm,
      );
      return cached.map((p) => _convertToModel(p)).toList();
    } catch (e) {
      _logger.e('Error getting cached nearby pharmacies', error: e);
      return [];
    }
  }

  /// Get cached pharmacy by ID
  Future<PharmacyModel?> getCachedPharmacyById(String id) async {
    try {
      final cached = await _database.getCachedPharmacyById(id);
      if (cached == null) return null;
      return _convertToModel(cached);
    } catch (e) {
      _logger.e('Error getting cached pharmacy by ID', error: e);
      return null;
    }
  }

  /// Cache pharmacies in local database
  Future<void> _cachePharmacies(List<PharmacyModel> pharmacies) async {
    try {
      final companions = pharmacies.map((p) {
        return CachedPharmaciesCompanion(
          id: Value(p.id),
          name: Value(p.name),
          description: Value(p.description),
          address: Value(p.location?.addressLine ?? ''),
          city: Value(p.location?.city ?? ''),
          state: Value(p.location?.state),
          country: Value(p.location?.country ?? ''),
          postalCode: Value(p.location?.pincode),
          latitude: Value(p.location?.latitude ?? 0.0),
          longitude: Value(p.location?.longitude ?? 0.0),
          phone: Value(p.phone),
          email: Value(p.email),
          website: const Value(null),
          isActive: Value(p.isActive),
          isVerified: Value(p.isVerified),
          supportsDelivery: Value(p.supportsDelivery),
          supportsPickup: Value(p.supportsPickup),
          openingHours: const Value(null),
          services: const Value(null),
          createdAt: Value(p.createdAt),
          updatedAt: Value(p.updatedAt),
          lastSyncedAt: Value(DateTime.now()),
        );
      }).toList();

      await _database.insertOrUpdateCachedPharmacies(companions);
      _logger.d('Cached ${pharmacies.length} pharmacies');
    } catch (e) {
      _logger.e('Error caching pharmacies', error: e);
    }
  }

  /// Convert cached pharmacy to model
  PharmacyModel _convertToModel(CachedPharmacy cached) {
    return PharmacyModel(
      id: cached.id,
      name: cached.name,
      description: cached.description,
      phone: cached.phone,
      email: cached.email,
      isVerified: cached.isVerified,
      isActive: cached.isActive,
      rating: 0.0,
      ratingCount: 0,
      supportsDelivery: cached.supportsDelivery,
      supportsPickup: cached.supportsPickup,
      createdAt: cached.createdAt,
      updatedAt: cached.updatedAt,
      location: PharmacyLocationModel(
        id: cached.id,
        pharmacyId: cached.id,
        addressLine: cached.address,
        city: cached.city,
        state: cached.state,
        country: cached.country,
        pincode: cached.postalCode,
        latitude: cached.latitude,
        longitude: cached.longitude,
        createdAt: cached.createdAt,
      ),
    );
  }
}
