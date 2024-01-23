// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProvinceModelAdapter extends TypeAdapter<ProvinceModel> {
  @override
  final int typeId = 35;

  @override
  ProvinceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProvinceModel(
      countryId: fields[1] as int?,
      provinceId: fields[0] as int?,
      description: fields[2] as String?,
      abbreviation: fields[3] as String?,
      countryDto: fields[4] as CountryDto?,
    );
  }

  @override
  void write(BinaryWriter writer, ProvinceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.provinceId)
      ..writeByte(1)
      ..write(obj.countryId)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.abbreviation)
      ..writeByte(4)
      ..write(obj.countryDto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
