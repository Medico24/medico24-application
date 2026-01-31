import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/api_constants.dart';
import 'package:medico24/core/api/dio_client.dart';
import 'package:medico24/core/api/models/environment_model.dart';

class EnvironmentApiService {
  EnvironmentApiService([Dio? dio])
    : _dio = dio ?? DioClient.instance,
      _logger = Logger();

  final Dio _dio;
  final Logger _logger;

  /// Get environmental conditions for a specific location
  Future<EnvironmentConditionsModel> getEnvironmentConditions({
    required double latitude,
    required double longitude,
  }) async {
    try {
      _logger.d(
        'Fetching environment conditions for lat: $latitude, lng: $longitude',
      );

      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.environmentConditions,
        queryParameters: {'lat': latitude, 'lng': longitude},
      );

      _logger.d('Environment conditions response: ${response.data}');

      if (response.data == null) {
        throw Exception('Empty response from environment API');
      }

      return EnvironmentConditionsModel.fromJson(response.data!);
    } on DioException catch (e) {
      _logger.e('DioException in getEnvironmentConditions: $e');
      rethrow;
    } catch (e) {
      _logger.e('Error in getEnvironmentConditions: $e');
      rethrow;
    }
  }
}
