import 'package:dio/dio.dart';
import '../models/appointment_model.dart';

class AppointmentApiService {
  final Dio _dio;

  AppointmentApiService(this._dio);

  Future<AppointmentListResponse> getAppointments({
    String? status,
    String? doctorId,
    String? clinicId,
    String? fromDate,
    String? toDate,
    int? page,
    int? pageSize,
  }) async {
    final response = await _dio.get(
      '/api/v1/appointments/',
      queryParameters: {
        if (status != null) 'status': status,
        if (doctorId != null) 'doctor_id': doctorId,
        if (clinicId != null) 'clinic_id': clinicId,
        if (fromDate != null) 'from_date': fromDate,
        if (toDate != null) 'to_date': toDate,
        if (page != null) 'page': page,
        if (pageSize != null) 'page_size': pageSize,
      },
    );
    return AppointmentListResponse.fromJson(response.data);
  }

  Future<AppointmentModel> createAppointment(
    AppointmentCreateRequest request,
  ) async {
    final response = await _dio.post(
      '/api/v1/appointments/',
      data: request.toJson(),
    );
    return AppointmentModel.fromJson(response.data);
  }

  Future<AppointmentModel> getAppointment(String appointmentId) async {
    final response = await _dio.get('/api/v1/appointments/$appointmentId');
    return AppointmentModel.fromJson(response.data);
  }

  Future<AppointmentModel> updateAppointment(
    String appointmentId,
    AppointmentCreateRequest request,
  ) async {
    final response = await _dio.put(
      '/api/v1/appointments/$appointmentId',
      data: request.toJson(),
    );
    return AppointmentModel.fromJson(response.data);
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _dio.delete('/api/v1/appointments/$appointmentId');
  }

  Future<AppointmentModel> updateAppointmentStatus(
    String appointmentId,
    Map<String, dynamic> statusUpdate,
  ) async {
    final response = await _dio.patch(
      '/api/v1/appointments/$appointmentId/status',
      data: statusUpdate,
    );
    return AppointmentModel.fromJson(response.data);
  }
}
