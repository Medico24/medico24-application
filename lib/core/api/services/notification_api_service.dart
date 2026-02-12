import 'package:dio/dio.dart';
import 'package:medico24/core/api/api_constants.dart';
import 'package:medico24/core/api/dio_client.dart';

/// API service for notification-related endpoints
class NotificationApiService {
  NotificationApiService() {
    _dio = DioClient.instance;
  }
  late final Dio _dio;

  /// Register FCM token with backend
  Future<Map<String, dynamic>> registerToken(
    String fcmToken,
    String platform,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.notificationRegisterToken,
        data: {'fcm_token': fcmToken, 'platform': platform},
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Deactivate a specific FCM token
  Future<void> deactivateToken(String fcmToken, String platform) async {
    try {
      await _dio.delete<dynamic>(
        ApiConstants.notificationDeactivateToken,
        data: {'fcm_token': fcmToken, 'platform': platform},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Deactivate all FCM tokens for current user
  Future<void> deactivateAllTokens() async {
    try {
      await _dio.delete<dynamic>(ApiConstants.notificationDeactivateAll);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle API errors
  Exception _handleError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final message = e.response?.data['detail'] ?? 'Unknown error occurred';

      switch (statusCode) {
        case 400:
          return Exception('Bad Request: $message');
        case 401:
          return Exception('Unauthorized: $message');
        case 403:
          return Exception('Forbidden: $message');
        case 404:
          return Exception('Not Found: $message');
        case 500:
          return Exception('Server Error: $message');
        default:
          return Exception('Error: $message');
      }
    } else {
      return Exception('Network error: ${e.message}');
    }
  }
}
