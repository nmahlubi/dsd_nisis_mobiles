// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_groupingflags.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteGroupingFlagsModelAdapter
    extends TypeAdapter<SiteGroupingFlagsModel> {
  @override
  final int typeId = 10;

  @override
  SiteGroupingFlagsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteGroupingFlagsModel(
      groupingFlagId: fields[0] as int?,
      siteDto: fields[2] as SiteDto?,
      site: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SiteGroupingFlagsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.groupingFlagId)
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
      other is SiteGroupingFlagsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
