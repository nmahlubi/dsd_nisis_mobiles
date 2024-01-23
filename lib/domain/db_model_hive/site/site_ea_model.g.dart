// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_ea_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteEAModelAdapter extends TypeAdapter<SiteEAModel> {
  @override
  final int typeId = 51;

  @override
  SiteEAModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteEAModel(
      createdBy: fields[5] as String?,
      isActive: fields[2] as String?,
      dateLastModified: fields[6] as String?,
      isDeleted: fields[3] as String?,
      dateCreated: fields[4] as DateTime?,
      modifiedBy: fields[7] as String?,
      communityName: fields[1] as String?,
      eaCode: fields[0] as String?,
      siteDto: fields[8] as SiteDto?,
    );
  }

  @override
  void write(BinaryWriter writer, SiteEAModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.eaCode)
      ..writeByte(1)
      ..write(obj.communityName)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.isDeleted)
      ..writeByte(4)
      ..write(obj.dateCreated)
      ..writeByte(5)
      ..write(obj.createdBy)
      ..writeByte(6)
      ..write(obj.dateLastModified)
      ..writeByte(7)
      ..write(obj.modifiedBy)
      ..writeByte(8)
      ..write(obj.siteDto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteEAModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
