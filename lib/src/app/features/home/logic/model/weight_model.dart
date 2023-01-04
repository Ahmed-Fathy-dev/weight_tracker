import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weight_model.g.dart';

@JsonSerializable()
class WeightModel extends Equatable {
  final String id;
  final String weight;
  @TimestampConverter()
  final DateTime time;

  const WeightModel({
    required this.id,
    required this.weight,
    required this.time,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json) =>
      _$WeightModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeightModelToJson(this);

  factory WeightModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return WeightModel(
      id: data?['id'] as String,
      weight: data?['weight'] as String,
      time: data?['time'] as DateTime,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'weight': weight,
      'time': time,
    };
  }

  // static DateTime _fromJson(int int) =>
  //     DateTime.fromMillisecondsSinceEpoch(int);
  // static int _toJson(DateTime time) => time.millisecondsSinceEpoch;

  @override
  List<Object?> get props => [
        id,
        weight,
        time,
      ];
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
