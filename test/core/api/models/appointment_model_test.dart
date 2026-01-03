import 'package:flutter_test/flutter_test.dart';
import 'package:medico24/core/api/models/appointment_model.dart';
import '../../../helpers/mock_data.dart';

void main() {
  group('AppointmentModel', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Act
        final appointment = AppointmentModel.fromJson(
          MockData.mockAppointmentJson,
        );

        // Assert
        expect(appointment.id, 'appointment123');
        expect(appointment.patientId, 'patient123');
        expect(appointment.doctorId, 'doctor123');
        expect(appointment.doctorName, 'Dr. Smith');
        expect(appointment.clinicId, 'clinic123');
        expect(appointment.clinicName, 'Test Clinic');
        expect(appointment.appointmentAt, isA<DateTime>());
        expect(appointment.appointmentEndAt, isA<DateTime>());
        expect(appointment.reason, 'Regular checkup');
        expect(appointment.contactPhone, '+1234567890');
        expect(appointment.notes, 'Patient has no allergies');
        expect(appointment.status, AppointmentStatus.scheduled);
        expect(appointment.source, AppointmentSource.patientApp);
        expect(appointment.createdAt, isA<DateTime>());
        expect(appointment.updatedAt, isA<DateTime>());
      });

      test('should handle null optional fields', () {
        // Arrange
        final jsonWithNulls = {
          'id': 'appointment123',
          'patient_id': 'patient123',
          'doctor_name': 'Dr. Smith',
          'appointment_at': '2024-01-15T10:00:00Z',
          'reason': 'Regular checkup',
          'contact_phone': '+1234567890',
          'status': 'scheduled',
          'source': 'patient_app',
          'created_at': '2024-01-01T12:00:00Z',
          'updated_at': '2024-01-01T12:00:00Z',
        };

        // Act
        final appointment = AppointmentModel.fromJson(jsonWithNulls);

        // Assert
        expect(appointment.doctorId, isNull);
        expect(appointment.clinicId, isNull);
        expect(appointment.clinicName, isNull);
        expect(appointment.appointmentEndAt, isNull);
        expect(appointment.notes, isNull);
        expect(appointment.cancelledAt, isNull);
        expect(appointment.deletedAt, isNull);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final appointment = MockData.mockAppointment;

        // Act
        final json = appointment.toJson();

        // Assert
        expect(json['id'], 'appointment123');
        expect(json['patient_id'], 'patient123');
        expect(json['doctor_id'], 'doctor123');
        expect(json['doctor_name'], 'Dr. Smith');
        expect(json['clinic_id'], 'clinic123');
        expect(json['clinic_name'], 'Test Clinic');
        expect(json['reason'], 'Regular checkup');
        expect(json['contact_phone'], '+1234567890');
        expect(json['notes'], 'Patient has no allergies');
        expect(json['status'], 'scheduled');
        expect(json['source'], 'patient_app');
      });
    });

    group('AppointmentStatus enum', () {
      test('should serialize correctly', () {
        expect(AppointmentStatus.scheduled.toString(), contains('scheduled'));
        expect(AppointmentStatus.confirmed.toString(), contains('confirmed'));
        expect(AppointmentStatus.cancelled.toString(), contains('cancelled'));
        expect(AppointmentStatus.completed.toString(), contains('completed'));
      });
    });

    group('AppointmentSource enum', () {
      test('should serialize correctly', () {
        expect(AppointmentSource.patientApp.toString(), contains('patientApp'));
        expect(AppointmentSource.doctorApp.toString(), contains('doctorApp'));
        expect(AppointmentSource.adminPanel.toString(), contains('adminPanel'));
        expect(AppointmentSource.api.toString(), contains('api'));
      });
    });
  });
}
