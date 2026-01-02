import 'package:json_annotation/json_annotation.dart';

part 'pharmacy_model.g.dart';

/// Custom converter to handle rating as either String or num from API
class RatingConverter implements JsonConverter<double, dynamic> {
  const RatingConverter();

  @override
  double fromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  dynamic toJson(double value) => value;
}

@JsonSerializable()
class PharmacyLocationModel {
  PharmacyLocationModel({
    required this.id,
    required this.pharmacyId,
    required this.addressLine,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.state,
    this.pincode,
  });

  factory PharmacyLocationModel.fromJson(Map<String, dynamic> json) =>
      _$PharmacyLocationModelFromJson(json);
  final String id;
  @JsonKey(name: 'pharmacy_id')
  final String pharmacyId;
  @JsonKey(name: 'address_line')
  final String addressLine;
  final String city;
  final String? state;
  final String country;
  final String? pincode;
  final double latitude;
  final double longitude;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$PharmacyLocationModelToJson(this);
}

@JsonSerializable()
class PharmacyHoursModel {
  PharmacyHoursModel({
    required this.id,
    required this.pharmacyId,
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
  });

  factory PharmacyHoursModel.fromJson(Map<String, dynamic> json) =>
      _$PharmacyHoursModelFromJson(json);
  final String id;
  @JsonKey(name: 'pharmacy_id')
  final String pharmacyId;
  @JsonKey(name: 'day_of_week')
  final int dayOfWeek;
  @JsonKey(name: 'open_time')
  final String openTime;
  @JsonKey(name: 'close_time')
  final String closeTime;
  @JsonKey(name: 'is_closed')
  final bool isClosed;

  Map<String, dynamic> toJson() => _$PharmacyHoursModelToJson(this);

  String get dayName {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[dayOfWeek - 1];
  }
}

@JsonSerializable()
class PharmacyModel {
  PharmacyModel({
    required this.id,
    required this.name,
    required this.isVerified,
    required this.isActive,
    required this.rating,
    required this.ratingCount,
    required this.supportsDelivery,
    required this.supportsPickup,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.phone,
    this.email,
    this.location,
    this.hours,
    this.distanceKm,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) =>
      _$PharmacyModelFromJson(json);
  final String id;
  final String name;
  final String? description;
  final String? phone;
  final String? email;
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @RatingConverter()
  final double rating;
  @JsonKey(name: 'rating_count')
  final int ratingCount;
  @JsonKey(name: 'supports_delivery')
  final bool supportsDelivery;
  @JsonKey(name: 'supports_pickup')
  final bool supportsPickup;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final PharmacyLocationModel? location;
  final List<PharmacyHoursModel>? hours;
  @JsonKey(name: 'distance_km')
  final double? distanceKm;

  Map<String, dynamic> toJson() => _$PharmacyModelToJson(this);

  String get fullAddress {
    if (location == null) return '';
    return '${location!.addressLine}, ${location!.city}${location!.state != null ? ', ${location!.state}' : ''}, ${location!.country}';
  }

  bool get isOpen {
    if (hours == null || hours!.isEmpty) return false;
    final now = DateTime.now();
    final today = now.weekday; // 1 = Monday, 7 = Sunday
    final currentHours = hours!.firstWhere(
      (h) => h.dayOfWeek == today,
      orElse: () => PharmacyHoursModel(
        id: '',
        pharmacyId: id,
        dayOfWeek: today,
        openTime: '00:00:00',
        closeTime: '00:00:00',
        isClosed: true,
      ),
    );

    if (currentHours.isClosed) return false;

    final openParts = currentHours.openTime.split(':');
    final closeParts = currentHours.closeTime.split(':');
    final openTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(openParts[0]),
      int.parse(openParts[1]),
    );
    final closeTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(closeParts[0]),
      int.parse(closeParts[1]),
    );

    return now.isAfter(openTime) && now.isBefore(closeTime);
  }
}

@JsonSerializable()
class PharmacyCreateRequest {
  PharmacyCreateRequest({
    required this.name,
    required this.supportsDelivery,
    required this.supportsPickup,
    required this.location,
    this.description,
    this.phone,
    this.email,
    this.hours,
  });

  factory PharmacyCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PharmacyCreateRequestFromJson(json);
  final String name;
  final String? description;
  final String? phone;
  final String? email;
  @JsonKey(name: 'supports_delivery')
  final bool supportsDelivery;
  @JsonKey(name: 'supports_pickup')
  final bool supportsPickup;
  final PharmacyLocationCreateRequest location;
  final List<PharmacyHoursCreateRequest>? hours;

  Map<String, dynamic> toJson() => _$PharmacyCreateRequestToJson(this);
}

@JsonSerializable()
class PharmacyLocationCreateRequest {
  PharmacyLocationCreateRequest({
    required this.addressLine,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.state,
    this.pincode,
  });

  factory PharmacyLocationCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PharmacyLocationCreateRequestFromJson(json);
  @JsonKey(name: 'address_line')
  final String addressLine;
  final String city;
  final String? state;
  final String country;
  final String? pincode;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => _$PharmacyLocationCreateRequestToJson(this);
}

@JsonSerializable()
class PharmacyHoursCreateRequest {
  PharmacyHoursCreateRequest({
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    this.isClosed = false,
  });

  factory PharmacyHoursCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PharmacyHoursCreateRequestFromJson(json);
  @JsonKey(name: 'day_of_week')
  final int dayOfWeek;
  @JsonKey(name: 'open_time')
  final String openTime;
  @JsonKey(name: 'close_time')
  final String closeTime;
  @JsonKey(name: 'is_closed')
  final bool isClosed;

  Map<String, dynamic> toJson() => _$PharmacyHoursCreateRequestToJson(this);
}
