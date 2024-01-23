
import 'package:hive/hive.dart';

part 'household.member.model.g.dart';

@HiveType(typeId: 97)

class MemberData extends HiveObject{
  @HiveField(0)
  final int? personId;
  @HiveField(2)
  final String? firstName;
  @HiveField(3)
  final String? lastName;
  @HiveField(4)
  final String? knownAs;
  @HiveField(5)
  final int? identificationTypeId;
  @HiveField(6)
  final String? identificationNumber;
  @HiveField(7)
  final bool? isPivaValidated;
  @HiveField(8)
  final String? pivaTransactionId;
  @HiveField(9)
  final DateTime dateOfBirth;
  @HiveField(10)
  final int? age;
  @HiveField(11)
  final bool? isEstimatedAge;
  @HiveField(12)
  final int? sexualOrientationId;
  @HiveField(13)
  final int? languageId;
  @HiveField(14)
  final int? genderId;
  @HiveField(15)
  final int? maritalStatusId;
  @HiveField(16)
  final int? preferredContactTypeId;
  @HiveField(17)
  final int ?religionId;
  @HiveField(18)
  final String? phoneNumber;
  @HiveField(19)
  final String? mobilePhoneNumber;
  @HiveField(20)
  final String? emailAddress;
  @HiveField(21)
  final int? populationGroupId;
  @HiveField(22)
  final int? nationalityId;
  @HiveField(23)
  final int? disabilityTypeId;
  @HiveField(24)
  final int? citizenshipId;
  @HiveField(25)
  final DateTime? dateCreated;
  @HiveField(26)
  final String? createdBy;
  @HiveField(27)
  final DateTime? dateLastModified;
  @HiveField(28)
  final String ?modifiedBy;
  @HiveField(29)
  final bool isActive;
  @HiveField(30)
  final bool isDeleted;
  @HiveField(31)
  final Map<String, dynamic>? relativeHouseholdmemberDto;
  @HiveField(32)
  final Map<String, dynamic>? genderDto;
  @HiveField(33)
  final Map<String, dynamic>? maritalstatusDto;
  @HiveField(34)
  final Map<String, dynamic>? nationalityDto;

  MemberData({
    required this.personId,
    required this.firstName,
    required this.lastName,
    required this.knownAs,
    required this.identificationTypeId,
    required this.identificationNumber,
    required this.isPivaValidated,
    required this.pivaTransactionId,
    required this.dateOfBirth,
    required this.age,
    required this.isEstimatedAge,
    required this.sexualOrientationId,
    required this.languageId,
    required this.genderId,
    required this.maritalStatusId,
    required this.preferredContactTypeId,
    required this.religionId,
    required this.phoneNumber,
    required this.mobilePhoneNumber,
    required this.emailAddress,
    required this.populationGroupId,
    required this.nationalityId,
    required this.disabilityTypeId,
    required this.citizenshipId,
    required this.dateCreated,
    required this.createdBy,
    required this.dateLastModified,
    required this.modifiedBy,
    required this.isActive,
    required this.isDeleted,
    required this.relativeHouseholdmemberDto,
    required this.genderDto,
    required this.maritalstatusDto,
    required this.nationalityDto,
  });

  factory MemberData.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDateOfBirth;
    if (json['date_Of_Birth'] != null && json['date_Of_Birth'].isNotEmpty) {
      parsedDateOfBirth = DateTime.tryParse(json['date_Of_Birth'] as String);
    }

    return MemberData(
      dateOfBirth: parsedDateOfBirth ?? DateTime.now(),
      personId: json['person_Id'] as int,
      firstName: json['first_Name'] as String,
      lastName: json['last_Name'] as String,
      knownAs: json['known_As'] as String?,
      identificationTypeId: json['identification_Type_Id'] as int,
      identificationNumber: json['identification_Number'] as String?,
      isPivaValidated: json['is_Piva_Validated'] as bool?,
      pivaTransactionId: json['piva_Transaction_Id'] as String?,
      //dateOfBirth: json['date_Of_Birth'],
      age: json['age'] as int?,
      isEstimatedAge: json['is_Estimated_Age'] as bool?,
      sexualOrientationId: json['sexual_Orientation_Id'] as int?,
      languageId: json['language_Id'] as int?,
      genderId: json['gender_Id'] as int?,
      maritalStatusId: json['marital_Status_Id'] as int?,
      preferredContactTypeId: json['preferred_Contact_Type_Id'] as int?,
      religionId: json['religion_Id'] as int?,
      phoneNumber: json['phone_Number'] as String?,
      mobilePhoneNumber: json['mobile_Phone_Number'] as String?,
      emailAddress: json['email_Address'] as String?,
      populationGroupId: json['population_Group_Id'] as int?,
      nationalityId: json['nationality_Id'] as int?,
      disabilityTypeId: json['disability_Type_Id'] as int?,
      citizenshipId: json['citizenship_Id'] as int?,
      //dateCreated: json['date_Created'],
      createdBy: json['created_By'] as String?,
      //dateLastModified: json['date_Last_Modified'] != null ? DateTime.tryParse(json['date_Last_Modified']) : null,
      modifiedBy: json['modified_By'] as String?,
      isActive: json['is_Active'] == 'true',
      isDeleted: json['is_Deleted'] == 'true',

      dateCreated: json['date_Created'] != null ? DateTime.tryParse(json['date_Created'] as String) ?? DateTime.now() : null,
      dateLastModified: json['date_Last_Modified'] != null ? DateTime.tryParse(json['date_Last_Modified'] as String) ?? DateTime.now() : null,
      relativeHouseholdmemberDto: json['relativeHouseholdmemberDto'] as Map<String, dynamic>?,
      genderDto: json['genderDto'] as Map<String, dynamic>?,
      maritalstatusDto: json['maritalstatusDto'] as Map<String, dynamic>?,
      nationalityDto: json['nationalityDto'] as Map<String, dynamic>?,

    );
  }

}
