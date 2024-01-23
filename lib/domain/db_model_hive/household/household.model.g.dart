// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseholdModelAdapter extends TypeAdapter<HouseholdModel> {
  @override
  final int typeId = 20;

  @override
  HouseholdModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HouseholdModel(
      profilingInstanceId: fields[0] as int?,
      profilingDate: fields[1] as String?,
      profilingToolId: fields[2] as int?,
      profilingMethodId: fields[3] as int?,
      capturedByUserId: fields[4] as int?,
      hHID: fields[5] as int?,
      modifiedBy: fields[16] as String?,
      nISISSiteEAId: fields[6] as int?,
      householdNumber: fields[7] as int?,
      householdNumberOfMales: fields[8] as int?,
      householdNumberOfFemales: fields[9] as int?,
      dwellingUnitDescription: fields[10] as String?,
      qAStatusItemId: fields[11] as int?,
      isActive: fields[12] as String?,
      isDeleted: fields[13] as String?,
      dateCreated: fields[14] as String?,
      dateLastModified: fields[15] as String?,
      provinceId: fields[17] as int?,
      profilingDateCaptured: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HouseholdModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.profilingInstanceId)
      ..writeByte(1)
      ..write(obj.profilingDate)
      ..writeByte(2)
      ..write(obj.profilingToolId)
      ..writeByte(3)
      ..write(obj.profilingMethodId)
      ..writeByte(4)
      ..write(obj.capturedByUserId)
      ..writeByte(5)
      ..write(obj.hHID)
      ..writeByte(6)
      ..write(obj.nISISSiteEAId)
      ..writeByte(7)
      ..write(obj.householdNumber)
      ..writeByte(8)
      ..write(obj.householdNumberOfMales)
      ..writeByte(9)
      ..write(obj.householdNumberOfFemales)
      ..writeByte(10)
      ..write(obj.dwellingUnitDescription)
      ..writeByte(11)
      ..write(obj.qAStatusItemId)
      ..writeByte(12)
      ..write(obj.isActive)
      ..writeByte(13)
      ..write(obj.isDeleted)
      ..writeByte(14)
      ..write(obj.dateCreated)
      ..writeByte(15)
      ..write(obj.dateLastModified)
      ..writeByte(16)
      ..write(obj.modifiedBy)
      ..writeByte(17)
      ..write(obj.provinceId)
      ..writeByte(18)
      ..write(obj.profilingDateCaptured);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseholdModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
