// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DistrictModelAdapter extends TypeAdapter<DistrictModel> {
  @override
  final int typeId = 36;

  @override
  DistrictModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DistrictModel(
      districtId: fields[0] as int?,
      description: fields[1] as String?,
      provinceDto: fields[3] as ProvinceDto?,
      localMunicipalities: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DistrictModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.districtId)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.localMunicipalities)
      ..writeByte(3)
      ..write(obj.provinceDto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistrictModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
