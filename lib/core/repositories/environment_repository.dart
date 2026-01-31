import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/environment_model.dart';
import 'package:medico24/core/api/services/environment_api_service.dart';

class EnvironmentRepository {
  EnvironmentRepository(this._apiService);
  final EnvironmentApiService _apiService;
  final Logger _logger = Logger();

  /// Get environmental conditions for a specific location
  Future<EnvironmentConditionsModel> getEnvironmentConditions({
    required double latitude,
    required double longitude,
  }) async {
    try {
      return await _apiService.getEnvironmentConditions(
        latitude: latitude,
        longitude: longitude,
      );
    } on DioException catch (e) {
      _logger.e('Repository error fetching environment conditions: $e');
      rethrow;
    } catch (e) {
      _logger.e('Error in getEnvironmentConditions: $e');
      rethrow;
    }
  }
}
