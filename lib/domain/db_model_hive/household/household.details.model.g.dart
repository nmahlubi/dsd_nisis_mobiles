// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.details.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseholdDetailsModelAdapter extends TypeAdapter<HouseholdDetailsModel> {
  @override
  final int typeId = 99;

  @override
  HouseholdDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HouseholdDetailsModel(
      profilingInstanceId: fields[0] as int?,
      profilingDate: fields[1] as String?,
      capturedByUserId: fields[2] as int?,
      siteId: fields[3] as int?,
      profilingToolId: fields[4] as int?,
      profilingMethodId: fields[5] as int?,
      personId: fields[6] as int?,
      hHID: fields[7] as int?,
      nISISSiteEAId: fields[8] as int?,
      dwellingUnitNumber: fields[9] as int?,
      householdNumber: fields[10] as int?,
      householdNumberOfMales: fields[11] as int?,
      householdNumberOfFemales: fields[12] as int?,
      dwellingUnitAddress: fields[13] as String?,
      dwellingUnitDescription: fields[14] as String?,
      qAStatusItemId: fields[15] as int?,
      isActive: fields[16] as String?,
      isDeleted: fields[17] as String?,
      dateCreated: fields[18] as String?,
      createdBy: fields[19] as String?,
      dateLastModified: fields[20] as String?,
      modifiedBy: fields[21] as String?,
      provinceId: fields[22] as int?,
      profilingDateCaptured: fields[23] as String?,
      siteDto: fields[24] as SiteDto?,
      siteProfilingToolsDto: fields[25] as SiteProfilingToolsDto?,
      siteProfilingMethodDto: fields[26] as SiteProfilingMethodDto?,
      personDto: fields[27] as PersonDto?,
      houseHoldDto: fields[28] as HouseHoldDto?,
    );
  }

  @override
  void write(BinaryWriter writer, HouseholdDetailsModel obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.profilingInstanceId)
      ..writeByte(1)
      ..write(obj.profilingDate)
      ..writeByte(2)
      ..write(obj.capturedByUserId)
      ..writeByte(3)
      ..write(obj.siteId)
      ..writeByte(4)
      ..write(obj.profilingToolId)
      ..writeByte(5)
      ..write(obj.profilingMethodId)
      ..writeByte(6)
      ..write(obj.personId)
      ..writeByte(7)
      ..write(obj.hHID)
      ..writeByte(8)
      ..write(obj.nISISSiteEAId)
      ..writeByte(9)
      ..write(obj.dwellingUnitNumber)
      ..writeByte(10)
      ..write(obj.householdNumber)
      ..writeByte(11)
      ..write(obj.householdNumberOfMales)
      ..writeByte(12)
      ..write(obj.householdNumberOfFemales)
      ..writeByte(13)
      ..write(obj.dwellingUnitAddress)
      ..writeByte(14)
      ..write(obj.dwellingUnitDescription)
      ..writeByte(15)
      ..write(obj.qAStatusItemId)
      ..writeByte(16)
      ..write(obj.isActive)
      ..writeByte(17)
      ..write(obj.isDeleted)
      ..writeByte(18)
      ..write(obj.dateCreated)
      ..writeByte(19)
      ..write(obj.createdBy)
      ..writeByte(20)
      ..write(obj.dateLastModified)
      ..writeByte(21)
      ..write(obj.modifiedBy)
      ..writeByte(22)
      ..write(obj.provinceId)
      ..writeByte(23)
      ..write(obj.profilingDateCaptured)
      ..writeByte(24)
      ..write(obj.siteDto)
      ..writeByte(25)
      ..write(obj.siteProfilingToolsDto)
      ..writeByte(26)
      ..write(obj.siteProfilingMethodDto)
      ..writeByte(27)
      ..write(obj.personDto)
      ..writeByte(28)
      ..write(obj.houseHoldDto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseholdDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
