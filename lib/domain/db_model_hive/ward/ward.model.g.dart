// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WardModelAdapter extends TypeAdapter<WardModel> {
  @override
  final int typeId = 61;

  @override
  WardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WardModel(
      createdBy: fields[7] as String?,
      isActive: fields[9] as String?,
      dateLastModified: fields[5] as String?,
      isDeleted: fields[10] as String?,
      dateCreated: fields[4] as String?,
      modifiedBy: fields[6] as String?,
      description: fields[3] as String?,
      wardId: fields[0] as int?,
      lastModifiedBy: fields[8] as String?,
      wardCode: fields[1] as String?,
      wardNumber: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WardModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.wardId)
      ..writeByte(1)
      ..write(obj.wardCode)
      ..writeByte(2)
      ..write(obj.wardNumber)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.dateCreated)
      ..writeByte(5)
      ..write(obj.dateLastModified)
      ..writeByte(6)
      ..write(obj.modifiedBy)
      ..writeByte(7)
      ..write(obj.createdBy)
      ..writeByte(8)
      ..write(obj.lastModifiedBy)
      ..writeByte(9)
      ..write(obj.isActive)
      ..writeByte(10)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
