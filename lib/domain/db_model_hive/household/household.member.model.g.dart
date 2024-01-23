// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.member.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberDataAdapter extends TypeAdapter<MemberData> {
  @override
  final int typeId = 97;

  @override
  MemberData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberData(
      personId: fields[0] as int?,
      firstName: fields[2] as String?,
      lastName: fields[3] as String?,
      knownAs: fields[4] as String?,
      identificationTypeId: fields[5] as int?,
      identificationNumber: fields[6] as String?,
      isPivaValidated: fields[7] as bool?,
      pivaTransactionId: fields[8] as String?,
      dateOfBirth: fields[9] as DateTime,
      age: fields[10] as int?,
      isEstimatedAge: fields[11] as bool?,
      sexualOrientationId: fields[12] as int?,
      languageId: fields[13] as int?,
      genderId: fields[14] as int?,
      maritalStatusId: fields[15] as int?,
      preferredContactTypeId: fields[16] as int?,
      religionId: fields[17] as int?,
      phoneNumber: fields[18] as String?,
      mobilePhoneNumber: fields[19] as String?,
      emailAddress: fields[20] as String?,
      populationGroupId: fields[21] as int?,
      nationalityId: fields[22] as int?,
      disabilityTypeId: fields[23] as int?,
      citizenshipId: fields[24] as int?,
      dateCreated: fields[25] as DateTime?,
      createdBy: fields[26] as String?,
      dateLastModified: fields[27] as DateTime?,
      modifiedBy: fields[28] as String?,
      isActive: fields[29] as bool,
      isDeleted: fields[30] as bool,
      relativeHouseholdmemberDto: (fields[31] as Map?)?.cast<String, dynamic>(),
      genderDto: (fields[32] as Map?)?.cast<String, dynamic>(),
      maritalstatusDto: (fields[33] as Map?)?.cast<String, dynamic>(),
      nationalityDto: (fields[34] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, MemberData obj) {
    writer
      ..writeByte(34)
      ..writeByte(0)
      ..write(obj.personId)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.knownAs)
      ..writeByte(5)
      ..write(obj.identificationTypeId)
      ..writeByte(6)
      ..write(obj.identificationNumber)
      ..writeByte(7)
      ..write(obj.isPivaValidated)
      ..writeByte(8)
      ..write(obj.pivaTransactionId)
      ..writeByte(9)
      ..write(obj.dateOfBirth)
      ..writeByte(10)
      ..write(obj.age)
      ..writeByte(11)
      ..write(obj.isEstimatedAge)
      ..writeByte(12)
      ..write(obj.sexualOrientationId)
      ..writeByte(13)
      ..write(obj.languageId)
      ..writeByte(14)
      ..write(obj.genderId)
      ..writeByte(15)
      ..write(obj.maritalStatusId)
      ..writeByte(16)
      ..write(obj.preferredContactTypeId)
      ..writeByte(17)
      ..write(obj.religionId)
      ..writeByte(18)
      ..write(obj.phoneNumber)
      ..writeByte(19)
      ..write(obj.mobilePhoneNumber)
      ..writeByte(20)
      ..write(obj.emailAddress)
      ..writeByte(21)
      ..write(obj.populationGroupId)
      ..writeByte(22)
      ..write(obj.nationalityId)
      ..writeByte(23)
      ..write(obj.disabilityTypeId)
      ..writeByte(24)
      ..write(obj.citizenshipId)
      ..writeByte(25)
      ..write(obj.dateCreated)
      ..writeByte(26)
      ..write(obj.createdBy)
      ..writeByte(27)
      ..write(obj.dateLastModified)
      ..writeByte(28)
      ..write(obj.modifiedBy)
      ..writeByte(29)
      ..write(obj.isActive)
      ..writeByte(30)
      ..write(obj.isDeleted)
      ..writeByte(31)
      ..write(obj.relativeHouseholdmemberDto)
      ..writeByte(32)
      ..write(obj.genderDto)
      ..writeByte(33)
      ..write(obj.maritalstatusDto)
      ..writeByte(34)
      ..write(obj.nationalityDto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
