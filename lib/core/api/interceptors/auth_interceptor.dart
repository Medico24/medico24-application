import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/auth_model.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Prevent multiple simultaneous refresh attempts
  bool _isRefreshing = false;

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

      // Prevent multiple simultaneous refresh attempts
      if (_isRefreshing) {
        _logger.i('Token refresh already in progress, waiting...');
        await Future.delayed(const Duration(milliseconds: 500));

        // Try reading the potentially updated token
        final newToken = await _storage.read(key: 'access_token');
        if (newToken != null) {
          _logger.i('Using refreshed token from ongoing refresh');
          try {
            final dio = Dio(
              BaseOptions(
                baseUrl: err.requestOptions.baseUrl,
                connectTimeout: err.requestOptions.connectTimeout,
                receiveTimeout: err.requestOptions.receiveTimeout,
                sendTimeout: err.requestOptions.sendTimeout,
              ),
            );

            final requestOptions = Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newToken',
              },
            );

            final retryResponse = await dio.request(
              err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
              options: requestOptions,
            );

            handler.resolve(retryResponse);
            return;
          } catch (e) {
            _logger.e('Retry with refreshed token failed', error: e);
          }
        }
        handler.next(err);
        return;
      }

      _isRefreshing = true;

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
        // Clone the request options and update the authorization header
        final requestOptions = Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer ${loginResponse.accessToken}',
          },
        );

        _logger.i('Retrying original request with new token...');

        // Retry using the same Dio instance to maintain consistency
        final retryResponse = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: requestOptions,
        );

        _logger.i('✅ Retry successful after token refresh');
        handler.resolve(retryResponse);
      } catch (e) {
        _logger.e('Error during token refresh', error: e);
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }
}
