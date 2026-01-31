// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvironmentConditionsModel _$EnvironmentConditionsModelFromJson(
  Map<String, dynamic> json,
) => EnvironmentConditionsModel(
  aqi: (json['aqi'] as num).toInt(),
  aqiCategory: json['aqi_category'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  condition: json['condition'] as String,
);

Map<String, dynamic> _$EnvironmentConditionsModelToJson(
  EnvironmentConditionsModel instance,
) => <String, dynamic>{
  'aqi': instance.aqi,
  'aqi_category': instance.aqiCategory,
  'temperature': instance.temperature,
  'condition': instance.condition,
};
