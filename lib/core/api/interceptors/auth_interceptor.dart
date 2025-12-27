import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Logger _logger = Logger();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Get access token from secure storage
      final accessToken = await _storage.read(key: 'access_token');

      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
        _logger.d('Added Authorization header to ${options.path}');
      } else {
        _logger.w('No access token found for ${options.path}');
      }
    } catch (e) {
      _logger.e('Error reading access token', error: e);
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - attempt token refresh
    if (err.response?.statusCode == 401) {
      _logger.w('Received 401 Unauthorized, token may be expired');

      try {
        final refreshToken = await _storage.read(key: 'refresh_token');

        if (refreshToken != null && refreshToken.isNotEmpty) {
          _logger.i('Attempting to refresh access token');
          // TODO: Implement token refresh logic
          // For now, just pass the error along
        }
      } catch (e) {
        _logger.e('Error during token refresh attempt', error: e);
      }
    }

    handler.next(err);
  }
}
