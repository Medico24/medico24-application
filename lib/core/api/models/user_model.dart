import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final String? city;
  final String? state;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @JsonKey(name: 'emergency_contact')
  final String? emergencyContact;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  final List<String>? allergies;
  @JsonKey(name: 'medical_conditions')
  final List<String>? medicalConditions;
  @JsonKey(name: 'is_onboarded')
  final bool isOnboarded;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.emergencyContact,
    this.bloodGroup,
    this.allergies,
    this.medicalConditions,
    required this.isOnboarded,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserUpdateRequest {
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final String? city;
  final String? state;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @JsonKey(name: 'emergency_contact')
  final String? emergencyContact;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  final List<String>? allergies;
  @JsonKey(name: 'medical_conditions')
  final List<String>? medicalConditions;

  UserUpdateRequest({
    this.displayName,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.emergencyContact,
    this.bloodGroup,
    this.allergies,
    this.medicalConditions,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
