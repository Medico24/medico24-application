// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['display_name'] as String?,
  photoUrl: json['photo_url'] as String?,
  phoneNumber: json['phone_number'] as String?,
  dateOfBirth: json['date_of_birth'] as String?,
  gender: json['gender'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  postalCode: json['postal_code'] as String?,
  emergencyContact: json['emergency_contact'] as String?,
  bloodGroup: json['blood_group'] as String?,
  allergies: (json['allergies'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  medicalConditions: (json['medical_conditions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isOnboarded: json['is_onboarded'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'display_name': instance.displayName,
  'photo_url': instance.photoUrl,
  'phone_number': instance.phoneNumber,
  'date_of_birth': instance.dateOfBirth,
  'gender': instance.gender,
  'address': instance.address,
  'city': instance.city,
  'state': instance.state,
  'postal_code': instance.postalCode,
  'emergency_contact': instance.emergencyContact,
  'blood_group': instance.bloodGroup,
  'allergies': instance.allergies,
  'medical_conditions': instance.medicalConditions,
  'is_onboarded': instance.isOnboarded,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

UserUpdateRequest _$UserUpdateRequestFromJson(Map<String, dynamic> json) =>
    UserUpdateRequest(
      displayName: json['display_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postal_code'] as String?,
      emergencyContact: json['emergency_contact'] as String?,
      bloodGroup: json['blood_group'] as String?,
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      medicalConditions: (json['medical_conditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserUpdateRequestToJson(UserUpdateRequest instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'phone_number': instance.phoneNumber,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'postal_code': instance.postalCode,
      'emergency_contact': instance.emergencyContact,
      'blood_group': instance.bloodGroup,
      'allergies': instance.allergies,
      'medical_conditions': instance.medicalConditions,
    };
