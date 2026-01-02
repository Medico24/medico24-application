import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    required this.firebaseUid,
    required this.email,
    required this.emailVerified,
    required this.authProvider,
    required this.role,
    required this.isActive,
    required this.isOnboarded,
    required this.createdAt,
    required this.updatedAt,
    this.fullName,
    this.givenName,
    this.familyName,
    this.photoUrl,
    this.phone,
    this.lastLoginAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  final String id;
  @JsonKey(name: 'firebase_uid')
  final String firebaseUid;
  final String email;
  @JsonKey(name: 'email_verified')
  final bool emailVerified;
  @JsonKey(name: 'auth_provider')
  final String authProvider;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'given_name')
  final String? givenName;
  @JsonKey(name: 'family_name')
  final String? familyName;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  final String? phone;
  final String role;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_onboarded')
  final bool isOnboarded;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'last_login_at')
  final DateTime? lastLoginAt;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserUpdateRequest {
  UserUpdateRequest({
    this.fullName,
    this.givenName,
    this.familyName,
    this.photoUrl,
    this.phone,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'given_name')
  final String? givenName;
  @JsonKey(name: 'family_name')
  final String? familyName;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  final String? phone;

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
