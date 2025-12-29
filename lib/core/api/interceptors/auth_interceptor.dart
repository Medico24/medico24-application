import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/auth_model.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      _logger.w('Received 401 Unauthorized - refreshing Firebase token');

      try {
        // Get current Firebase user
        final user = _auth.currentUser;

        if (user == null) {
          _logger.e('No Firebase user found, cannot refresh token');
          handler.next(err);
          return;
        }

        // Force refresh the Firebase ID token
        _logger.i('Refreshing Firebase ID token...');
        final newFirebaseToken = await user.getIdToken(true);

        if (newFirebaseToken == null) {
          _logger.e('Failed to get new Firebase ID token');
          handler.next(err);
          return;
        }

        _logger.i('Firebase token refreshed, re-authenticating with backend');

        // Re-authenticate with backend using new Firebase token
        final dio = Dio(
          BaseOptions(
            baseUrl: err.requestOptions.baseUrl,
            connectTimeout: err.requestOptions.connectTimeout,
            receiveTimeout: err.requestOptions.receiveTimeout,
            sendTimeout: err.requestOptions.sendTimeout,
          ),
        );
        final response = await dio.post(
          '/api/v1/auth/firebase/verify',
          data: {'id_token': newFirebaseToken},
        );

        final loginResponse = LoginResponse.fromJson(response.data);

        // Store new tokens
        await _storage.write(
          key: 'access_token',
          value: loginResponse.accessToken,
        );
        await _storage.write(
          key: 'refresh_token',
          value: loginResponse.refreshToken,
        );

        _logger.i('Backend tokens refreshed successfully');

        // Retry the original request with new token
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] =
            'Bearer ${loginResponse.accessToken}';

        final retryResponse = await dio.fetch(requestOptions);
        handler.resolve(retryResponse);
      } catch (e) {
        _logger.e('Error during token refresh', error: e);
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
