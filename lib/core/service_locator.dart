import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medico24/core/api/dio_client.dart';
import 'package:medico24/core/api/services/appointment_api_service.dart';
import 'package:medico24/core/api/services/auth_api_service.dart';
import 'package:medico24/core/api/services/pharmacy_api_service.dart';
import 'package:medico24/core/api/services/user_api_service.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/repositories/appointment_repository.dart';
import 'package:medico24/core/repositories/pharmacy_repository.dart';
import 'package:medico24/core/repositories/user_repository.dart';

class ServiceLocator {
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();
  static final ServiceLocator _instance = ServiceLocator._internal();

  // Lazy initialization
  late final FlutterSecureStorage _secureStorage;
  late final AppDatabase _database;
  late final AuthApiService _authApiService;
  late final UserApiService _userApiService;
  late final AppointmentApiService _appointmentApiService;
  late final PharmacyApiService _pharmacyApiService;
  late final UserRepository _userRepository;
  late final AppointmentRepository _appointmentRepository;
  late final PharmacyRepository _pharmacyRepository;

  void init() {
    _secureStorage = const FlutterSecureStorage();
    _database = AppDatabase();
    final dio = DioClient.instance;

    _authApiService = AuthApiService(dio);
    _userApiService = UserApiService(dio);
    _appointmentApiService = AppointmentApiService(dio);
    _pharmacyApiService = PharmacyApiService();

    _userRepository = UserRepository(_userApiService, _database);
    _appointmentRepository = AppointmentRepository(
      _appointmentApiService,
      _database,
    );
    _pharmacyRepository = PharmacyRepository(_pharmacyApiService);
  }

  FlutterSecureStorage get secureStorage => _secureStorage;
  AppDatabase get database => _database;
  AuthApiService get authApi => _authApiService;
  UserApiService get userApi => _userApiService;
  AppointmentApiService get appointmentApi => _appointmentApiService;
  PharmacyApiService get pharmacyApi => _pharmacyApiService;
  UserRepository get userRepository => _userRepository;
  AppointmentRepository get appointmentRepository => _appointmentRepository;
  PharmacyRepository get pharmacyRepository => _pharmacyRepository;
}

// Global instance
final serviceLocator = ServiceLocator();
