import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:medico24/core/api/api_constants.dart';
import 'package:medico24/core/api/interceptors/auth_interceptor.dart';
import 'package:medico24/core/api/interceptors/error_interceptor.dart';

class DioClient {
  static Dio? _dio;
  static final Logger _logger = Logger();

  static Dio get instance {
    if (_dio != null) return _dio!;

    final baseUrl = dotenv.env['SERVER_URL'] ?? 'http://localhost:8000';
    _logger.i('Initializing Dio with base URL: $baseUrl');

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.contentType,
        },
      ),
    );

    // Add interceptors
    _dio!.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);

    return _dio!;
  }

  static void reset() {
    _dio = null;
  }
}
