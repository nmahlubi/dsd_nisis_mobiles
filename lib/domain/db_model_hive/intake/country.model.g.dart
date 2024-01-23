// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryModelAdapter extends TypeAdapter<CountryModel> {
  @override
  final int typeId = 40;

  @override
  CountryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryModel(
      countryId: fields[0] as int?,
      countryName: fields[1] as String?,
      countryCode: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CountryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.countryId)
      ..writeByte(1)
      ..write(obj.countryName)
      ..writeByte(2)
      ..write(obj.countryCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
