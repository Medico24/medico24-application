import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/appointment_model.dart';
import 'package:medico24/core/api/services/appointment_api_service.dart';
import 'package:medico24/core/database/database.dart';

class AppointmentRepository {
  final AppointmentApiService _apiService;
  final AppDatabase _database;
  final Logger _logger = Logger();

  AppointmentRepository(this._apiService, this._database);

  /// Fetch appointments from API and cache them
  Future<List<AppointmentModel>> fetchAndCacheAppointments({
    String? status,
    String? doctorId,
    String? clinicId,
    String? fromDate,
    String? toDate,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      // Fetch from API
      final response = await _apiService.getAppointments(
        status: status,
        doctorId: doctorId,
        clinicId: clinicId,
        fromDate: fromDate,
        toDate: toDate,
        page: page,
        pageSize: pageSize,
      );

      // Cache in local database
      await _cacheAppointments(response.items);

      return response.items;
    } on DioException catch (e) {
      _logger.e('Failed to fetch appointments from API', error: e);

      // Return cached data on error
      return await getCachedAppointments(
        fromDate: fromDate != null ? DateTime.parse(fromDate) : null,
        toDate: toDate != null ? DateTime.parse(toDate) : null,
      );
    } catch (e) {
      _logger.e('Unexpected error fetching appointments', error: e);
      rethrow;
    }
  }

  /// Get appointments from local cache
  Future<List<AppointmentModel>> getCachedAppointments({
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      List<Appointment> appointments;

      if (fromDate != null && toDate != null) {
        appointments = await _database.getAppointmentsByDateRange(
          fromDate,
          toDate,
        );
      } else {
        appointments = await _database.getAllAppointments();
      }

      return appointments.map((a) => _convertToModel(a)).toList();
    } catch (e) {
      _logger.e('Error getting cached appointments', error: e);
      return [];
    }
  }

  /// Create new appointment
  Future<AppointmentModel> createAppointment(
    AppointmentCreateRequest request,
  ) async {
    try {
      final appointment = await _apiService.createAppointment(request);

      // Cache the new appointment
      await _cacheAppointments([appointment]);

      return appointment;
    } catch (e) {
      _logger.e('Failed to create appointment', error: e);
      rethrow;
    }
  }

  /// Update appointment status
  Future<AppointmentModel> updateStatus(
    String appointmentId,
    String status,
  ) async {
    try {
      final appointment = await _apiService.updateAppointmentStatus(
        appointmentId,
        {'status': status},
      );

      // Update cache
      await _cacheAppointments([appointment]);

      return appointment;
    } catch (e) {
      _logger.e('Failed to update appointment status', error: e);
      rethrow;
    }
  }

  /// Delete appointment
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await _apiService.deleteAppointment(appointmentId);
      await _database.deleteAppointment(appointmentId);
    } catch (e) {
      _logger.e('Failed to delete appointment', error: e);
      rethrow;
    }
  }

  /// Cache appointments in local database
  Future<void> _cacheAppointments(List<AppointmentModel> appointments) async {
    try {
      final companions = appointments
          .map(
            (a) => AppointmentsCompanion(
              id: Value(a.id),
              patientId: Value(a.patientId),
              doctorId: Value(a.doctorId),
              doctorName: Value(a.doctorName),
              clinicId: Value(a.clinicId),
              clinicName: Value(a.clinicName),
              appointmentAt: Value(a.appointmentAt),
              appointmentEndAt: Value(a.appointmentEndAt),
              reason: Value(a.reason),
              contactPhone: Value(a.contactPhone),
              notes: Value(a.notes),
              status: Value(a.status.name),
              source: Value(a.source.name),
              createdAt: Value(a.createdAt),
              updatedAt: Value(a.updatedAt),
              cancelledAt: Value(a.cancelledAt),
              deletedAt: Value(a.deletedAt),
              lastSyncedAt: Value(DateTime.now()),
            ),
          )
          .toList();

      await _database.insertAppointments(companions);
    } catch (e) {
      _logger.e('Error caching appointments', error: e);
    }
  }

  /// Convert database model to API model
  AppointmentModel _convertToModel(Appointment a) {
    return AppointmentModel(
      id: a.id,
      patientId: a.patientId,
      doctorId: a.doctorId,
      doctorName: a.doctorName,
      clinicId: a.clinicId,
      clinicName: a.clinicName,
      appointmentAt: a.appointmentAt,
      appointmentEndAt: a.appointmentEndAt,
      reason: a.reason,
      contactPhone: a.contactPhone,
      notes: a.notes,
      status: AppointmentStatus.values.firstWhere(
        (s) => s.name == a.status,
        orElse: () => AppointmentStatus.scheduled,
      ),
      source: AppointmentSource.values.firstWhere(
        (s) => s.name == a.source,
        orElse: () => AppointmentSource.patientApp,
      ),
      createdAt: a.createdAt,
      updatedAt: a.updatedAt,
      cancelledAt: a.cancelledAt,
      deletedAt: a.deletedAt,
    );
  }
}
