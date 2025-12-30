import 'package:logger/logger.dart';
import '../api/models/pharmacy_model.dart';
import '../api/services/pharmacy_api_service.dart';

class PharmacyRepository {
  final PharmacyApiService _apiService;
  final Logger _logger = Logger();

  PharmacyRepository(this._apiService);

  /// Get list of pharmacies with optional filters
  /// If latitude and longitude are provided, returns nearby pharmacies sorted by distance
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
      return await _apiService.getPharmacies(
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
    } catch (e) {
      _logger.e('Repository error fetching pharmacies: $e');
      rethrow;
    }
  }

  /// Search for nearby pharmacies using current location
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
      return await _apiService.searchPharmaciesNearby(
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
    } catch (e) {
      _logger.e('Repository error searching nearby pharmacies: $e');
      rethrow;
    }
  }

  /// Get pharmacy details by ID
  Future<PharmacyModel> getPharmacyById(String id) async {
    try {
      return await _apiService.getPharmacyById(id);
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
}
