// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_profiling_tools.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteProfilingToolsModelAdapter
    extends TypeAdapter<SiteProfilingToolsModel> {
  @override
  final int typeId = 10;

  @override
  SiteProfilingToolsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteProfilingToolsModel(
      profilingToolId: fields[0] as int?,
      siteDto: fields[2] as SiteDto?,
      site: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SiteProfilingToolsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.profilingToolId)
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
      other is SiteProfilingToolsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
