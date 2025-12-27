import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from secure storage
    final accessToken = await _storage.read(key: 'access_token');

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - attempt token refresh
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _storage.read(key: 'refresh_token');

        if (refreshToken != null && refreshToken.isNotEmpty) {
          // TODO: Implement token refresh logic
          // For now, just pass the error along
        }
      } catch (e) {
        // Token refresh failed, pass the error
      }
    }

    super.onError(err, handler);
  }
}
