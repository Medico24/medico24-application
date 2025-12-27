import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

enum AppointmentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('completed')
  completed,
  @JsonValue('no_show')
  noShow,
}

enum AppointmentSource {
  @JsonValue('mobile_app')
  mobileApp,
  @JsonValue('web_portal')
  webPortal,
  @JsonValue('phone_call')
  phoneCall,
  @JsonValue('walk_in')
  walkIn,
}

@JsonSerializable()
class AppointmentModel {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
  @JsonKey(name: 'clinic_id')
  final String? clinicId;
  @JsonKey(name: 'appointment_date')
  final DateTime appointmentDate;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  final AppointmentStatus status;
  final String? reason;
  final String? symptoms;
  final String? notes;
  @JsonKey(name: 'is_emergency')
  final bool isEmergency;
  final AppointmentSource source;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  AppointmentModel({
    required this.id,
    required this.userId,
    this.doctorId,
    this.clinicId,
    required this.appointmentDate,
    required this.startTime,
    this.endTime,
    required this.status,
    this.reason,
    this.symptoms,
    this.notes,
    required this.isEmergency,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

@JsonSerializable()
class AppointmentCreateRequest {
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
  @JsonKey(name: 'clinic_id')
  final String? clinicId;
  @JsonKey(name: 'appointment_date')
  final String appointmentDate;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  final String? reason;
  final String? symptoms;
  final String? notes;
  @JsonKey(name: 'is_emergency')
  final bool? isEmergency;
  final AppointmentSource? source;

  AppointmentCreateRequest({
    this.doctorId,
    this.clinicId,
    required this.appointmentDate,
    required this.startTime,
    this.endTime,
    this.reason,
    this.symptoms,
    this.notes,
    this.isEmergency,
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
  final int pages;

  AppointmentListResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.pages,
  });

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentListResponseToJson(this);
}
