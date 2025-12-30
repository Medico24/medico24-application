import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../api_constants.dart';
import '../dio_client.dart';
import '../models/pharmacy_model.dart';

class PharmacyApiService {
  final Dio _dio = DioClient.instance;
  final Logger _logger = Logger();

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
      final queryParams = <String, dynamic>{'skip': skip, 'limit': limit};

      // Add location parameters if provided (for nearby search)
      if (latitude != null) queryParams['latitude'] = latitude;
      if (longitude != null) queryParams['longitude'] = longitude;
      if (latitude != null && longitude != null) {
        queryParams['radius_km'] = radiusKm;
      }

      if (isActive != null) queryParams['is_active'] = isActive;
      if (isVerified != null) queryParams['is_verified'] = isVerified;
      if (supportsDelivery != null) {
        queryParams['supports_delivery'] = supportsDelivery;
      }
      if (supportsPickup != null) {
        queryParams['supports_pickup'] = supportsPickup;
      }

      _logger.d('Fetching pharmacies with params: $queryParams');

      final response = await _dio.get(
        ApiConstants.pharmacies,
        queryParameters: queryParams,
      );

      _logger.d('Pharmacies response: ${response.data}');

      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => PharmacyModel.fromJson(json)).toList();
    } on DioException catch (e) {
      _logger.e('Error fetching pharmacies: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error fetching pharmacies: $e');
      rethrow;
    }
  }

  /// Search for pharmacies nearby using geographic coordinates
  Future<List<PharmacyModel>> searchPharmaciesNearby({
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
      final queryParams = <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'radius_km': radiusKm,
        'skip': skip,
        'limit': limit,
      };

      if (isActive != null) queryParams['is_active'] = isActive;
      if (isVerified != null) queryParams['is_verified'] = isVerified;
      if (supportsDelivery != null) {
        queryParams['supports_delivery'] = supportsDelivery;
      }
      if (supportsPickup != null) {
        queryParams['supports_pickup'] = supportsPickup;
      }

      _logger.d('Searching nearby pharmacies with params: $queryParams');

      final response = await _dio.get(
        ApiConstants.pharmaciesNearby,
        queryParameters: queryParams,
      );

      _logger.d('Nearby pharmacies response: ${response.data}');

      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => PharmacyModel.fromJson(json)).toList();
    } on DioException catch (e) {
      _logger.e('Error searching nearby pharmacies: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error searching nearby pharmacies: $e');
      rethrow;
    }
  }

  /// Get pharmacy details by ID
  Future<PharmacyModel> getPharmacyById(String id) async {
    try {
      _logger.d('Fetching pharmacy details for ID: $id');

      final response = await _dio.get(ApiConstants.pharmacy(id));

      _logger.d('Pharmacy details response: ${response.data}');

      return PharmacyModel.fromJson(response.data);
    } on DioException catch (e) {
      _logger.e('Error fetching pharmacy details: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error fetching pharmacy details: $e');
      rethrow;
    }
  }

  /// Create a new pharmacy
  Future<PharmacyModel> createPharmacy(PharmacyCreateRequest pharmacy) async {
    try {
      _logger.d('Creating pharmacy: ${pharmacy.toJson()}');

      final response = await _dio.post(
        ApiConstants.pharmacies,
        data: pharmacy.toJson(),
      );

      _logger.d('Created pharmacy response: ${response.data}');

      return PharmacyModel.fromJson(response.data);
    } on DioException catch (e) {
      _logger.e('Error creating pharmacy: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error creating pharmacy: $e');
      rethrow;
    }
  }

  /// Update pharmacy information
  Future<PharmacyModel> updatePharmacy(
    String id,
    Map<String, dynamic> updates,
  ) async {
    try {
      _logger.d('Updating pharmacy $id with: $updates');

      final response = await _dio.patch(
        ApiConstants.pharmacy(id),
        data: updates,
      );

      _logger.d('Updated pharmacy response: ${response.data}');

      return PharmacyModel.fromJson(response.data);
    } on DioException catch (e) {
      _logger.e('Error updating pharmacy: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error updating pharmacy: $e');
      rethrow;
    }
  }

  /// Delete a pharmacy
  Future<void> deletePharmacy(String id) async {
    try {
      _logger.d('Deleting pharmacy: $id');

      await _dio.delete(ApiConstants.pharmacy(id));

      _logger.d('Pharmacy deleted successfully');
    } on DioException catch (e) {
      _logger.e('Error deleting pharmacy: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error deleting pharmacy: $e');
      rethrow;
    }
  }

  /// Get pharmacy hours
  Future<List<PharmacyHoursModel>> getPharmacyHours(String pharmacyId) async {
    try {
      _logger.d('Fetching pharmacy hours for: $pharmacyId');

      final response = await _dio.get(ApiConstants.pharmacyHours(pharmacyId));

      _logger.d('Pharmacy hours response: ${response.data}');

      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => PharmacyHoursModel.fromJson(json)).toList();
    } on DioException catch (e) {
      _logger.e('Error fetching pharmacy hours: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error fetching pharmacy hours: $e');
      rethrow;
    }
  }

  /// Add or update pharmacy hours for a day
  Future<PharmacyHoursModel> addPharmacyHours(
    String pharmacyId,
    PharmacyHoursCreateRequest hours,
  ) async {
    try {
      _logger.d('Adding pharmacy hours for $pharmacyId: ${hours.toJson()}');

      final response = await _dio.post(
        ApiConstants.pharmacyHours(pharmacyId),
        data: hours.toJson(),
      );

      _logger.d('Added pharmacy hours response: ${response.data}');

      return PharmacyHoursModel.fromJson(response.data);
    } on DioException catch (e) {
      _logger.e('Error adding pharmacy hours: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error adding pharmacy hours: $e');
      rethrow;
    }
  }

  /// Delete pharmacy hours for a specific day
  Future<void> deletePharmacyHours(String pharmacyId, int dayOfWeek) async {
    try {
      _logger.d('Deleting pharmacy hours for $pharmacyId, day: $dayOfWeek');

      await _dio.delete(ApiConstants.pharmacyHoursDay(pharmacyId, dayOfWeek));

      _logger.d('Pharmacy hours deleted successfully');
    } on DioException catch (e) {
      _logger.e('Error deleting pharmacy hours: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error deleting pharmacy hours: $e');
      rethrow;
    }
  }
}
