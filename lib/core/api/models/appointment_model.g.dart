// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      doctorName: json['doctor_name'] as String,
      appointmentAt: DateTime.parse(json['appointment_at'] as String),
      reason: json['reason'] as String,
      contactPhone: json['contact_phone'] as String,
      status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
      source: $enumDecode(_$AppointmentSourceEnumMap, json['source']),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      doctorId: json['doctor_id'] as String?,
      clinicId: json['clinic_id'] as String?,
      clinicName: json['clinic_name'] as String?,
      appointmentEndAt: json['appointment_end_at'] == null
          ? null
          : DateTime.parse(json['appointment_end_at'] as String),
      notes: json['notes'] as String?,
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patientId,
      'doctor_id': instance.doctorId,
      'doctor_name': instance.doctorName,
      'clinic_id': instance.clinicId,
      'clinic_name': instance.clinicName,
      'appointment_at': instance.appointmentAt.toIso8601String(),
      'appointment_end_at': instance.appointmentEndAt?.toIso8601String(),
      'reason': instance.reason,
      'contact_phone': instance.contactPhone,
      'notes': instance.notes,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'source': _$AppointmentSourceEnumMap[instance.source]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.scheduled: 'scheduled',
  AppointmentStatus.confirmed: 'confirmed',
  AppointmentStatus.rescheduled: 'rescheduled',
  AppointmentStatus.cancelled: 'cancelled',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.noShow: 'no_show',
};

const _$AppointmentSourceEnumMap = {
  AppointmentSource.patientApp: 'patient_app',
  AppointmentSource.doctorApp: 'doctor_app',
  AppointmentSource.adminPanel: 'admin_panel',
  AppointmentSource.api: 'api',
};

AppointmentCreateRequest _$AppointmentCreateRequestFromJson(
  Map<String, dynamic> json,
) => AppointmentCreateRequest(
  doctorName: json['doctor_name'] as String,
  appointmentAt: json['appointment_at'] as String,
  reason: json['reason'] as String,
  contactPhone: json['contact_phone'] as String,
  clinicName: json['clinic_name'] as String?,
  appointmentEndAt: json['appointment_end_at'] as String?,
  notes: json['notes'] as String?,
  doctorId: json['doctor_id'] as String?,
  clinicId: json['clinic_id'] as String?,
  source: $enumDecodeNullable(_$AppointmentSourceEnumMap, json['source']),
);

Map<String, dynamic> _$AppointmentCreateRequestToJson(
  AppointmentCreateRequest instance,
) => <String, dynamic>{
  'doctor_name': instance.doctorName,
  'clinic_name': instance.clinicName,
  'appointment_at': instance.appointmentAt,
  'appointment_end_at': instance.appointmentEndAt,
  'reason': instance.reason,
  'contact_phone': instance.contactPhone,
  'notes': instance.notes,
  'doctor_id': instance.doctorId,
  'clinic_id': instance.clinicId,
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
);

Map<String, dynamic> _$AppointmentListResponseToJson(
  AppointmentListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'total': instance.total,
  'page': instance.page,
  'page_size': instance.pageSize,
};
