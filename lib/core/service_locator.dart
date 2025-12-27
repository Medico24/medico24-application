import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api/dio_client.dart';
import 'api/services/appointment_api_service.dart';
import 'api/services/auth_api_service.dart';
import 'api/services/user_api_service.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Lazy initialization
  late final FlutterSecureStorage _secureStorage;
  late final AuthApiService _authApiService;
  late final UserApiService _userApiService;
  late final AppointmentApiService _appointmentApiService;

  void init() {
    _secureStorage = const FlutterSecureStorage();
    final dio = DioClient.instance;

    _authApiService = AuthApiService(dio);
    _userApiService = UserApiService(dio);
    _appointmentApiService = AppointmentApiService(dio);
  }

  FlutterSecureStorage get secureStorage => _secureStorage;
  AuthApiService get authApi => _authApiService;
  UserApiService get userApi => _userApiService;
  AppointmentApiService get appointmentApi => _appointmentApiService;
}

// Global instance
final serviceLocator = ServiceLocator();
