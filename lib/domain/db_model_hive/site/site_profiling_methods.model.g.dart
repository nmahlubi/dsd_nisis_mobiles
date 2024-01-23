// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_profiling_methods.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteProfilingMethodsModelAdapter
    extends TypeAdapter<SiteProfilingMethodsModel> {
  @override
  final int typeId = 10;

  @override
  SiteProfilingMethodsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteProfilingMethodsModel(
      profilingMethodId: fields[0] as int?,
      siteDto: fields[2] as SiteDto?,
      site: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SiteProfilingMethodsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.profilingMethodId)
      ..writeByte(1)
      ..write(obj.site)
      ..writeByte(2)
      ..write(obj.siteDto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteProfilingMethodsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
