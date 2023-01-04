// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightModel _$WeightModelFromJson(Map<String, dynamic> json) => WeightModel(
      id: json['id'] as String,
      weight: json['weight'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$WeightModelToJson(WeightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'time': instance.time.toIso8601String(),
    };
