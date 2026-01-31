import 'package:medico24/core/api/models/user_model.dart';
import 'package:medico24/core/api/models/appointment_model.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import 'package:medico24/core/api/models/auth_model.dart';
import 'package:medico24/core/api/models/environment_model.dart';

/// Mock data for testing
class MockData {
  // User Model Mock Data
  static final mockUserJson = {
    'id': 'user123',
    'firebase_uid': 'firebase123',
    'email': 'test@example.com',
    'email_verified': true,
    'auth_provider': 'google',
    'full_name': 'Test User',
    'given_name': 'Test',
    'family_name': 'User',
    'photo_url': 'https://example.com/photo.jpg',
    'phone': '+1234567890',
    'role': 'patient',
    'is_active': true,
    'is_onboarded': true,
    'created_at': '2024-01-01T12:00:00Z',
    'updated_at': '2024-01-01T12:00:00Z',
    'last_login_at': '2024-01-01T12:00:00Z',
  };

  static UserModel get mockUser => UserModel.fromJson(mockUserJson);

  // Auth Model Mock Data
  static final mockLoginResponseJson = {
    'access_token': 'test_access_token_123',
    'refresh_token': 'test_refresh_token_456',
    'token_type': 'Bearer',
    'user': {
      'id': 'user123',
      'email': 'test@example.com',
      'firebase_uid': 'firebase123',
    },
  };

  static LoginResponse get mockLoginResponse =>
      LoginResponse.fromJson(mockLoginResponseJson);

  static final mockGoogleAuthRequest = GoogleAuthRequest(
    idToken: 'test_id_token',
  );

  // Appointment Model Mock Data
  static final mockAppointmentJson = {
    'id': 'appointment123',
    'patient_id': 'patient123',
    'doctor_id': 'doctor123',
    'doctor_name': 'Dr. Smith',
    'clinic_id': 'clinic123',
    'clinic_name': 'Test Clinic',
    'appointment_at': '2024-01-15T10:00:00Z',
    'appointment_end_at': '2024-01-15T10:30:00Z',
    'reason': 'Regular checkup',
    'contact_phone': '+1234567890',
    'notes': 'Patient has no allergies',
    'status': 'scheduled',
    'source': 'patient_app',
    'created_at': '2024-01-01T12:00:00Z',
    'updated_at': '2024-01-01T12:00:00Z',
  };

  static AppointmentModel get mockAppointment =>
      AppointmentModel.fromJson(mockAppointmentJson);

  static final mockAppointmentListJson = [
    mockAppointmentJson,
    {
      'id': 'appointment456',
      'patient_id': 'patient123',
      'doctor_name': 'Dr. Jones',
      'appointment_at': '2024-01-20T14:00:00Z',
      'reason': 'Follow-up',
      'contact_phone': '+1234567890',
      'status': 'confirmed',
      'source': 'patient_app',
      'created_at': '2024-01-02T12:00:00Z',
      'updated_at': '2024-01-02T12:00:00Z',
    },
  ];

  // Pharmacy Model Mock Data
  static final mockPharmacyLocationJson = {
    'id': 'location123',
    'pharmacy_id': 'pharmacy123',
    'address_line': '123 Main St',
    'city': 'Test City',
    'state': 'Test State',
    'country': 'Test Country',
    'pincode': '12345',
    'latitude': 40.7128,
    'longitude': -74.0060,
    'created_at': '2024-01-01T12:00:00Z',
  };

  static PharmacyLocationModel get mockPharmacyLocation =>
      PharmacyLocationModel.fromJson(mockPharmacyLocationJson);

  static final mockPharmacyHoursJson = {
    'id': 'hours123',
    'pharmacy_id': 'pharmacy123',
    'day_of_week': 1,
    'open_time': '09:00:00',
    'close_time': '18:00:00',
    'is_closed': false,
  };

  static PharmacyHoursModel get mockPharmacyHours =>
      PharmacyHoursModel.fromJson(mockPharmacyHoursJson);

  static final mockPharmacyJson = {
    'id': 'pharmacy123',
    'name': 'Test Pharmacy',
    'description': 'A test pharmacy',
    'phone': '+1234567890',
    'email': 'pharmacy@example.com',
    'is_verified': true,
    'is_active': true,
    'rating': 4.5,
    'rating_count': 100,
    'supports_delivery': true,
    'supports_pickup': true,
    'created_at': '2024-01-01T12:00:00Z',
    'updated_at': '2024-01-01T12:00:00Z',
    'location': mockPharmacyLocationJson,
    'hours': [mockPharmacyHoursJson],
  };

  static PharmacyModel get mockPharmacy =>
      PharmacyModel.fromJson(mockPharmacyJson);

  static final mockPharmacyListJson = [
    mockPharmacyJson,
    {
      'id': 'pharmacy456',
      'name': 'Another Pharmacy',
      'is_verified': true,
      'is_active': true,
      'rating': 4.2,
      'rating_count': 50,
      'supports_delivery': false,
      'supports_pickup': true,
      'created_at': '2024-01-02T12:00:00Z',
      'updated_at': '2024-01-02T12:00:00Z',
      'location': {
        'id': 'location456',
        'pharmacy_id': 'pharmacy456',
        'address_line': '456 Oak St',
        'city': 'Another City',
        'country': 'Test Country',
        'latitude': 40.7580,
        'longitude': -73.9855,
        'created_at': '2024-01-02T12:00:00Z',
      },
      'hours': [],
    },
  ];

  // Notification Mock Data
  static final mockRegisterTokenResponse = {
    'id': 'token123',
    'fcm_token': 'test_fcm_token',
    'platform': 'android',
    'is_active': true,
  };

  // Environment Model Mock Data
  static final mockEnvironmentConditionsJson = {
    'aqi': 35,
    'aqi_category': 'Good',
    'temperature': 21.3,
    'condition': 'Clear sky',
  };

  static EnvironmentConditionsModel get mockEnvironmentConditions =>
      EnvironmentConditionsModel.fromJson(mockEnvironmentConditionsJson);
}
