import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

enum AppointmentStatus {
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('rescheduled')
  rescheduled,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('completed')
  completed,
  @JsonValue('no_show')
  noShow,
}

enum AppointmentSource {
  @JsonValue('patient_app')
  patientApp,
  @JsonValue('doctor_app')
  doctorApp,
  @JsonValue('admin_panel')
  adminPanel,
  @JsonValue('api')
  api,
}

@JsonSerializable()
class AppointmentModel {
  final String id;
  @JsonKey(name: 'patient_id')
  final String patientId;
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
  @JsonKey(name: 'doctor_name')
  final String doctorName;
  @JsonKey(name: 'clinic_id')
  final String? clinicId;
  @JsonKey(name: 'clinic_name')
  final String? clinicName;
  @JsonKey(name: 'appointment_at')
  final DateTime appointmentAt;
  @JsonKey(name: 'appointment_end_at')
  final DateTime? appointmentEndAt;
  final String reason;
  @JsonKey(name: 'contact_phone')
  final String contactPhone;
  final String? notes;
  final AppointmentStatus status;
  final AppointmentSource source;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    this.doctorId,
    required this.doctorName,
    this.clinicId,
    this.clinicName,
    required this.appointmentAt,
    this.appointmentEndAt,
    required this.reason,
    required this.contactPhone,
    this.notes,
    required this.status,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
    this.cancelledAt,
    this.deletedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

@JsonSerializable()
class AppointmentCreateRequest {
  @JsonKey(name: 'doctor_name')
  final String doctorName;
  @JsonKey(name: 'clinic_name')
  final String? clinicName;
  @JsonKey(name: 'appointment_at')
  final String appointmentAt;
  @JsonKey(name: 'appointment_end_at')
  final String? appointmentEndAt;
  final String reason;
  @JsonKey(name: 'contact_phone')
  final String contactPhone;
  final String? notes;
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
  @JsonKey(name: 'clinic_id')
  final String? clinicId;
  final AppointmentSource? source;

  AppointmentCreateRequest({
    required this.doctorName,
    this.clinicName,
    required this.appointmentAt,
    this.appointmentEndAt,
    required this.reason,
    required this.contactPhone,
    this.notes,
    this.doctorId,
    this.clinicId,
    this.source,
  });

  factory AppointmentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AppointmentCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentCreateRequestToJson(this);
}

@JsonSerializable()
class AppointmentListResponse {
  final List<AppointmentModel> items;
  final int total;
  final int page;
  @JsonKey(name: 'page_size')
  final int pageSize;

  AppointmentListResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentListResponseToJson(this);
}
