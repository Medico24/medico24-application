import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api/dio_client.dart';
import 'api/services/appointment_api_service.dart';
import 'api/services/auth_api_service.dart';
import 'api/services/user_api_service.dart';
import 'database/database.dart';
import 'repositories/appointment_repository.dart';
import 'repositories/user_repository.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Lazy initialization
  late final FlutterSecureStorage _secureStorage;
  late final AppDatabase _database;
  late final AuthApiService _authApiService;
  late final UserApiService _userApiService;
  late final AppointmentApiService _appointmentApiService;
  late final UserRepository _userRepository;
  late final AppointmentRepository _appointmentRepository;

  void init() {
    _secureStorage = const FlutterSecureStorage();
    _database = AppDatabase();
    final dio = DioClient.instance;

    _authApiService = AuthApiService(dio);
    _userApiService = UserApiService(dio);
    _appointmentApiService = AppointmentApiService(dio);

    _userRepository = UserRepository(_userApiService, _database);
    _appointmentRepository = AppointmentRepository(
      _appointmentApiService,
      _database,
    );
  }

  FlutterSecureStorage get secureStorage => _secureStorage;
  AppDatabase get database => _database;
  AuthApiService get authApi => _authApiService;
  UserApiService get userApi => _userApiService;
  AppointmentApiService get appointmentApi => _appointmentApiService;
  UserRepository get userRepository => _userRepository;
  AppointmentRepository get appointmentRepository => _appointmentRepository;
}

// Global instance
final serviceLocator = ServiceLocator();
