import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:medico24/core/api/services/auth_api_service.dart';
import 'package:medico24/core/api/services/user_api_service.dart';
import 'package:medico24/core/api/services/appointment_api_service.dart';
import 'package:medico24/core/api/services/pharmacy_api_service.dart';
import 'package:medico24/core/api/services/notification_api_service.dart';
import 'package:medico24/core/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Generate mocks for testing
@GenerateMocks([
  Dio,
  AuthApiService,
  UserApiService,
  AppointmentApiService,
  PharmacyApiService,
  NotificationApiService,
  AppDatabase,
  FirebaseAuth,
  GoogleSignIn,
  FlutterSecureStorage,
  User,
  UserCredential,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
])
void main() {}

/// Helper class for common test utilities
class TestHelpers {
  /// Create a mock Dio response
  static Response<T> mockResponse<T>({
    required T data,
    int statusCode = 200,
    String? statusMessage,
  }) {
    return Response(
      data: data,
      statusCode: statusCode,
      statusMessage: statusMessage,
      requestOptions: RequestOptions(path: ''),
    );
  }

  /// Create a mock DioException
  static DioException mockDioException({
    int statusCode = 500,
    String message = 'Test error',
    Map<String, dynamic>? responseData,
  }) {
    return DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        statusCode: statusCode,
        data: responseData ?? {'detail': message},
        requestOptions: RequestOptions(path: ''),
      ),
    );
  }

  /// Create a test DateTime
  static DateTime testDateTime = DateTime(2024, 1, 1, 12, 0, 0);

  /// Create a test DateTime string
  static String testDateTimeString = '2024-01-01T12:00:00Z';
}
