


class MemberDataDto{
  final int? personId;
  final String? firstName;
  final String? lastName;
  final String? knownAs;
  final int? identificationTypeId;
  final String? identificationNumber;
  final bool? isPivaValidated;
  final String? pivaTransactionId;
  final DateTime? dateOfBirth;
  final int? age;
  final bool? isEstimatedAge;
  final int? sexualOrientationId;
  final int? languageId;
  final int? genderId;
  final int? maritalStatusId;
  final int? preferredContactTypeId;
  final int ?religionId;
  final String? phoneNumber;
  final String? mobilePhoneNumber;
  final String? emailAddress;
  final int? populationGroupId;
  final int? nationalityId;
  final int? disabilityTypeId;
  final int? citizenshipId;
  final DateTime? dateCreated;
  final String? createdBy;
  final DateTime? dateLastModified;
  final String ?modifiedBy;
  final bool? isActive;
  final bool? isDeleted;
  final Map<String, dynamic>? relativeHouseholdmemberDto;
  final Map<String, dynamic>? genderDto;
  final Map<String, dynamic>? maritalstatusDto;
  final Map<String, dynamic>? nationalityDto;

  MemberDataDto({
     this.personId,
     this.firstName,
    this.lastName,
    this.knownAs,
    this.identificationTypeId,
     this.identificationNumber,
     this.isPivaValidated,
     this.pivaTransactionId,
     this.dateOfBirth,
     this.age,
     this.isEstimatedAge,
     this.sexualOrientationId,
     this.languageId,
     this.genderId,
     this.maritalStatusId,
     this.preferredContactTypeId,
     this.religionId,
     this.phoneNumber,
     this.mobilePhoneNumber,
     this.emailAddress,
     this.populationGroupId,
     this.nationalityId,
     this.disabilityTypeId,
     this.citizenshipId,
     this.dateCreated,
     this.createdBy,
     this.dateLastModified,
     this.modifiedBy,
     this.isActive,
     this.isDeleted,
     this.relativeHouseholdmemberDto,
     this.genderDto,
     this.maritalstatusDto,
     this.nationalityDto,
  });

  factory MemberDataDto.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDateOfBirth;
    if (json['date_Of_Birth'] != null && json['date_Of_Birth'].isNotEmpty) {
      parsedDateOfBirth = DateTime.tryParse(json['date_Of_Birth'] as String);
    }

    return MemberDataDto(
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
  Map<String, dynamic> getGenderDto(int genderId, String genderDescription) {
    return {
      "gender_Id": genderId,
      "description": genderDescription,
    };
  }

  Map<String, dynamic> getNationalityDto(int nationalityId, String nationalityDescription) {
    return {
      "nationality_Id": nationalityId,
      "description": nationalityDescription,
    };
  }


}