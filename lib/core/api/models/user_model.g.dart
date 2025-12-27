// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  firebaseUid: json['firebase_uid'] as String,
  email: json['email'] as String,
  emailVerified: json['email_verified'] as bool,
  authProvider: json['auth_provider'] as String,
  fullName: json['full_name'] as String?,
  givenName: json['given_name'] as String?,
  familyName: json['family_name'] as String?,
  photoUrl: json['photo_url'] as String?,
  phone: json['phone'] as String?,
  role: json['role'] as String,
  isActive: json['is_active'] as bool,
  isOnboarded: json['is_onboarded'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  lastLoginAt: json['last_login_at'] == null
      ? null
      : DateTime.parse(json['last_login_at'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'firebase_uid': instance.firebaseUid,
  'email': instance.email,
  'email_verified': instance.emailVerified,
  'auth_provider': instance.authProvider,
  'full_name': instance.fullName,
  'given_name': instance.givenName,
  'family_name': instance.familyName,
  'photo_url': instance.photoUrl,
  'phone': instance.phone,
  'role': instance.role,
  'is_active': instance.isActive,
  'is_onboarded': instance.isOnboarded,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'last_login_at': instance.lastLoginAt?.toIso8601String(),
};

UserUpdateRequest _$UserUpdateRequestFromJson(Map<String, dynamic> json) =>
    UserUpdateRequest(
      fullName: json['full_name'] as String?,
      givenName: json['given_name'] as String?,
      familyName: json['family_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserUpdateRequestToJson(UserUpdateRequest instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'given_name': instance.givenName,
      'family_name': instance.familyName,
      'photo_url': instance.photoUrl,
      'phone': instance.phone,
    };
