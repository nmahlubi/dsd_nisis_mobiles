// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_ea_segments.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteEASegmentsModelAdapter extends TypeAdapter<SiteEASegmentsModel> {
  @override
  final int typeId = 19;

  @override
  SiteEASegmentsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteEASegmentsModel(
      modifiedBy: fields[8] as String?,
      dateCreated: fields[5] as String?,
      isDeleted: fields[10] as String?,
      dateLastModified: fields[7] as String?,
      isActive: fields[9] as String?,
      createdBy: fields[6] as String?,
      segmentId: fields[0] as int?,
      boundaryDescription: fields[2] as String?,
      listingRoute: fields[4] as String?,
      listingStartPointDescription: fields[3] as String?,
      segmentNumber: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SiteEASegmentsModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.segmentId)
      ..writeByte(1)
      ..write(obj.segmentNumber)
      ..writeByte(2)
      ..write(obj.boundaryDescription)
      ..writeByte(3)
      ..write(obj.listingStartPointDescription)
      ..writeByte(4)
      ..write(obj.listingRoute)
      ..writeByte(5)
      ..write(obj.dateCreated)
      ..writeByte(6)
      ..write(obj.createdBy)
      ..writeByte(7)
      ..write(obj.dateLastModified)
      ..writeByte(8)
      ..write(obj.modifiedBy)
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
      other is SiteEASegmentsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
