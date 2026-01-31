import 'package:json_annotation/json_annotation.dart';

part 'environment_model.g.dart';

@JsonSerializable()
class EnvironmentConditionsModel {
  EnvironmentConditionsModel({
    required this.aqi,
    required this.aqiCategory,
    required this.temperature,
    required this.condition,
  });

  factory EnvironmentConditionsModel.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentConditionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentConditionsModelToJson(this);

  final int aqi;
  @JsonKey(name: 'aqi_category')
  final String aqiCategory;
  @JsonKey(name: 'temperature')
  final double temperature;
  final String condition;
}
