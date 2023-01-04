// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightModel _$WeightModelFromJson(Map<String, dynamic> json) => WeightModel(
      id: json['id'] as String,
      weight: json['weight'] as String,
      time: const TimestampConverter().fromJson(json['time'] as Timestamp),
    );

Map<String, dynamic> _$WeightModelToJson(WeightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'time': const TimestampConverter().toJson(instance.time),
    };
