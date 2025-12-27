import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ErrorInterceptor extends Interceptor {
  final Logger _logger = Logger();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'An error occurred';

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(err.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection';
        break;
      default:
        errorMessage = 'Something went wrong';
    }

    _logger.e('API Error: $errorMessage', error: err);

    super.onError(err, handler);
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 422:
        return 'Validation error';
      case 500:
        return 'Internal server error';
      case 503:
        return 'Service unavailable';
      default:
        return 'Error occurred (${statusCode ?? 'unknown'})';
    }
  }
}
