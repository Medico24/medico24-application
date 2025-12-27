class ApiConstants {
  // Base URL from environment
  static String get baseUrl {
    const url = String.fromEnvironment(
      'SERVER_URL',
      defaultValue: 'http://localhost:8000',
    );
    return url;
  }

  // API Endpoints
  static const String apiVersion = '/api/v1';

  // Health
  static const String health = '$apiVersion/health';
  static const String healthDetailed = '$apiVersion/health/detailed';
  static const String ping = '$apiVersion/ping';

  // Authentication
  static const String googleLogin = '$apiVersion/auth/google/login';
  static const String googleCallback = '$apiVersion/auth/google/callback';
  static const String refreshToken = '$apiVersion/auth/refresh';
  static const String logout = '$apiVersion/auth/logout';

  // Users
  static const String currentUser = '$apiVersion/users/me';
  static const String userOnboard = '$apiVersion/users/me/onboard';
  static String userProfile(String userId) =>
      '$apiVersion/users/$userId/profile';

  // Appointments
  static const String appointments = '$apiVersion/appointments/';
  static String appointment(String id) => '$apiVersion/appointments/$id';
  static String appointmentStatus(String id) =>
      '$apiVersion/appointments/$id/status';

  // Headers
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
