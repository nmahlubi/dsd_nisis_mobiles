// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nisis_role.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NisisRoleModelAdapter extends TypeAdapter<NisisRoleModel> {
  @override
  final int typeId = 2;

  @override
  NisisRoleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NisisRoleModel(
      dataCapture: fields[0] as bool?,
      manager: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NisisRoleModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dataCapture)
      ..writeByte(1)
      ..write(obj.manager);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NisisRoleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
