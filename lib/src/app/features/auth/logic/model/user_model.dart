import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../home/logic/model/weight_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String name;
  final String? token;
  @JsonKey(name: 'weight')
  final WeightModel? weightModel;
  const UserModel({
    required this.id,
    required this.name,
    this.token,
    this.weightModel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: data?['id'] as String,
      name: data?['name'] as String,
      token: data?['token'] as String,
      weightModel: data?['weight'] == null
          ? null
          : WeightModel.fromJson(data?['weight'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      if (token != null) 'token': token,
      if (weightModel != null) 'weight': weightModel?.toFirestore(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        token,
        weightModel,
      ];
}
