// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      doctorId: json['doctor_id'] as String?,
      clinicId: json['clinic_id'] as String?,
      appointmentDate: DateTime.parse(json['appointment_date'] as String),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String?,
      status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
      reason: json['reason'] as String?,
      symptoms: json['symptoms'] as String?,
      notes: json['notes'] as String?,
      isEmergency: json['is_emergency'] as bool,
      source: $enumDecode(_$AppointmentSourceEnumMap, json['source']),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'doctor_id': instance.doctorId,
      'clinic_id': instance.clinicId,
      'appointment_date': instance.appointmentDate.toIso8601String(),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'reason': instance.reason,
      'symptoms': instance.symptoms,
      'notes': instance.notes,
      'is_emergency': instance.isEmergency,
      'source': _$AppointmentSourceEnumMap[instance.source]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.pending: 'pending',
  AppointmentStatus.confirmed: 'confirmed',
  AppointmentStatus.cancelled: 'cancelled',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.noShow: 'no_show',
};

const _$AppointmentSourceEnumMap = {
  AppointmentSource.mobileApp: 'mobile_app',
  AppointmentSource.webPortal: 'web_portal',
  AppointmentSource.phoneCall: 'phone_call',
  AppointmentSource.walkIn: 'walk_in',
};

AppointmentCreateRequest _$AppointmentCreateRequestFromJson(
  Map<String, dynamic> json,
) => AppointmentCreateRequest(
  doctorId: json['doctor_id'] as String?,
  clinicId: json['clinic_id'] as String?,
  appointmentDate: json['appointment_date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String?,
  reason: json['reason'] as String?,
  symptoms: json['symptoms'] as String?,
  notes: json['notes'] as String?,
  isEmergency: json['is_emergency'] as bool?,
  source: $enumDecodeNullable(_$AppointmentSourceEnumMap, json['source']),
);

Map<String, dynamic> _$AppointmentCreateRequestToJson(
  AppointmentCreateRequest instance,
) => <String, dynamic>{
  'doctor_id': instance.doctorId,
  'clinic_id': instance.clinicId,
  'appointment_date': instance.appointmentDate,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'reason': instance.reason,
  'symptoms': instance.symptoms,
  'notes': instance.notes,
  'is_emergency': instance.isEmergency,
  'source': _$AppointmentSourceEnumMap[instance.source],
};

AppointmentListResponse _$AppointmentListResponseFromJson(
  Map<String, dynamic> json,
) => AppointmentListResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  pages: (json['pages'] as num).toInt(),
);

Map<String, dynamic> _$AppointmentListResponseToJson(
  AppointmentListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
  'pages': instance.pages,
};
