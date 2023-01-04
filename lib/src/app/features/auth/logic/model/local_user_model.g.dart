// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CashedUserModelAdapter extends TypeAdapter<CashedUserModel> {
  @override
  final int typeId = 0;

  @override
  CashedUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CashedUserModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..token = fields[2] as String
      ..weightId = fields[3] as String?
      ..weight = fields[4] as String
      ..time = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, CashedUserModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.weightId)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashedUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
