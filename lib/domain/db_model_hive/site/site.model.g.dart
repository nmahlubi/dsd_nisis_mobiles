// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteModelAdapter extends TypeAdapter<SiteModel> {
  @override
  final int typeId = 50;

  @override
  SiteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteModel(
      siteId: fields[0] as int?,
      modifiedBy: fields[24] as String?,
      dateCreated: fields[21] as DateTime?,
      isDeleted: fields[20] as String?,
      dateLastModified: fields[23] as String?,
      isActive: fields[19] as String?,
      budgetCommitted: fields[17] as int?,
      createdBy: fields[22] as String?,
      estimatedPopulation: fields[15] as int?,
      gpsCoordinatesLat: fields[3] as String?,
      gpsCoordinatesLong: fields[4] as String?,
      listingMethodId: fields[13] as int?,
      primaryContact: fields[12] as String?,
      prioritizationGroup: fields[9] as String?,
      provinceDto: fields[25] as ProvinceDto?,
      qaStatusItemId: fields[18] as int?,
      registeredProgrammeId: fields[5] as int?,
      registeredProgrammeStatusId: fields[6] as int?,
      responsibleOrganization: fields[7] as String?,
      responsibleProgrammeId: fields[14] as int?,
      siteAlternativeName: fields[2] as String?,
      siteEas: fields[8] as String?,
      siteName: fields[1] as String?,
      sourceOfPopulationEstimate: fields[16] as String?,
      targetEndDate: fields[11] as String?,
      targetStartDate: fields[10] as String?,
      wardDto: fields[26] as WardDto?,
    );
  }

  @override
  void write(BinaryWriter writer, SiteModel obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.siteId)
      ..writeByte(1)
      ..write(obj.siteName)
      ..writeByte(2)
      ..write(obj.siteAlternativeName)
      ..writeByte(3)
      ..write(obj.gpsCoordinatesLat)
      ..writeByte(4)
      ..write(obj.gpsCoordinatesLong)
      ..writeByte(5)
      ..write(obj.registeredProgrammeId)
      ..writeByte(6)
      ..write(obj.registeredProgrammeStatusId)
      ..writeByte(7)
      ..write(obj.responsibleOrganization)
      ..writeByte(8)
      ..write(obj.siteEas)
      ..writeByte(9)
      ..write(obj.prioritizationGroup)
      ..writeByte(10)
      ..write(obj.targetStartDate)
      ..writeByte(11)
      ..write(obj.targetEndDate)
      ..writeByte(12)
      ..write(obj.primaryContact)
      ..writeByte(13)
      ..write(obj.listingMethodId)
      ..writeByte(14)
      ..write(obj.responsibleProgrammeId)
      ..writeByte(15)
      ..write(obj.estimatedPopulation)
      ..writeByte(16)
      ..write(obj.sourceOfPopulationEstimate)
      ..writeByte(17)
      ..write(obj.budgetCommitted)
      ..writeByte(18)
      ..write(obj.qaStatusItemId)
      ..writeByte(19)
      ..write(obj.isActive)
      ..writeByte(20)
      ..write(obj.isDeleted)
      ..writeByte(21)
      ..write(obj.dateCreated)
      ..writeByte(22)
      ..write(obj.createdBy)
      ..writeByte(23)
      ..write(obj.dateLastModified)
      ..writeByte(24)
      ..write(obj.modifiedBy)
      ..writeByte(25)
      ..write(obj.provinceDto)
      ..writeByte(26)
      ..write(obj.wardDto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
