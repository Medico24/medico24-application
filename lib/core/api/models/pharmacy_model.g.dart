// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PharmacyLocationModel _$PharmacyLocationModelFromJson(
  Map<String, dynamic> json,
) => PharmacyLocationModel(
  id: json['id'] as String,
  pharmacyId: json['pharmacy_id'] as String,
  addressLine: json['address_line'] as String,
  city: json['city'] as String,
  state: json['state'] as String?,
  country: json['country'] as String,
  pincode: json['pincode'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$PharmacyLocationModelToJson(
  PharmacyLocationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'pharmacy_id': instance.pharmacyId,
  'address_line': instance.addressLine,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'pincode': instance.pincode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'created_at': instance.createdAt.toIso8601String(),
};

PharmacyHoursModel _$PharmacyHoursModelFromJson(Map<String, dynamic> json) =>
    PharmacyHoursModel(
      id: json['id'] as String,
      pharmacyId: json['pharmacy_id'] as String,
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      openTime: json['open_time'] as String,
      closeTime: json['close_time'] as String,
      isClosed: json['is_closed'] as bool,
    );

Map<String, dynamic> _$PharmacyHoursModelToJson(PharmacyHoursModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pharmacy_id': instance.pharmacyId,
      'day_of_week': instance.dayOfWeek,
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
      'is_closed': instance.isClosed,
    };

PharmacyModel _$PharmacyModelFromJson(Map<String, dynamic> json) =>
    PharmacyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      isVerified: json['is_verified'] as bool,
      isActive: json['is_active'] as bool,
      rating: const RatingConverter().fromJson(json['rating']),
      ratingCount: (json['rating_count'] as num).toInt(),
      supportsDelivery: json['supports_delivery'] as bool,
      supportsPickup: json['supports_pickup'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      location: json['location'] == null
          ? null
          : PharmacyLocationModel.fromJson(
              json['location'] as Map<String, dynamic>,
            ),
      hours: (json['hours'] as List<dynamic>?)
          ?.map((e) => PharmacyHoursModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PharmacyModelToJson(PharmacyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'phone': instance.phone,
      'email': instance.email,
      'is_verified': instance.isVerified,
      'is_active': instance.isActive,
      'rating': const RatingConverter().toJson(instance.rating),
      'rating_count': instance.ratingCount,
      'supports_delivery': instance.supportsDelivery,
      'supports_pickup': instance.supportsPickup,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'location': instance.location,
      'hours': instance.hours,
      'distance_km': instance.distanceKm,
    };

PharmacyCreateRequest _$PharmacyCreateRequestFromJson(
  Map<String, dynamic> json,
) => PharmacyCreateRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  supportsDelivery: json['supports_delivery'] as bool,
  supportsPickup: json['supports_pickup'] as bool,
  location: PharmacyLocationCreateRequest.fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  hours: (json['hours'] as List<dynamic>?)
      ?.map(
        (e) => PharmacyHoursCreateRequest.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$PharmacyCreateRequestToJson(
  PharmacyCreateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'phone': instance.phone,
  'email': instance.email,
  'supports_delivery': instance.supportsDelivery,
  'supports_pickup': instance.supportsPickup,
  'location': instance.location,
  'hours': instance.hours,
};

PharmacyLocationCreateRequest _$PharmacyLocationCreateRequestFromJson(
  Map<String, dynamic> json,
) => PharmacyLocationCreateRequest(
  addressLine: json['address_line'] as String,
  city: json['city'] as String,
  state: json['state'] as String?,
  country: json['country'] as String,
  pincode: json['pincode'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$PharmacyLocationCreateRequestToJson(
  PharmacyLocationCreateRequest instance,
) => <String, dynamic>{
  'address_line': instance.addressLine,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'pincode': instance.pincode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

PharmacyHoursCreateRequest _$PharmacyHoursCreateRequestFromJson(
  Map<String, dynamic> json,
) => PharmacyHoursCreateRequest(
  dayOfWeek: (json['day_of_week'] as num).toInt(),
  openTime: json['open_time'] as String,
  closeTime: json['close_time'] as String,
  isClosed: json['is_closed'] as bool? ?? false,
);

Map<String, dynamic> _$PharmacyHoursCreateRequestToJson(
  PharmacyHoursCreateRequest instance,
) => <String, dynamic>{
  'day_of_week': instance.dayOfWeek,
  'open_time': instance.openTime,
  'close_time': instance.closeTime,
  'is_closed': instance.isClosed,
};
