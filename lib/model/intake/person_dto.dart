

class PersonDto {
  PersonDto({
    int? personId,
    String? firstName,
    String? lastName,
    String? knownAs,
    int? identificationTypeId,
    String? identificationNumber,
    bool? isPivaValidated,
    String? pivaTransactionId,
    String? dateOfBirth,
    int? age,
    bool? isEstimatedAge,
    bool? isActive,
    bool? isDeleted,
    int? sexualOrientationId,
    int? languageId,
    int? genderId,
    int? maritalStatusId,
    int? preferredContactTypeId,
    int? religionId,
    String? phoneNumber,
    String? mobilePhoneNumber,
    String? emailAddress,
    int? populationGroupId,
    int? nationalityId,
    int? disabilityTypeId,
    // int? disabilityId,
    int? citizenshipId,
    String? dateLastModified,
    String? modifiedBy,
    String? createdBy,
    String? dateCreated,
  }) {
    _personId = personId;
    _firstName = firstName;
    _lastName = lastName;
    _knownAs = knownAs;
    _identificationTypeId = identificationTypeId;
    _identificationNumber = identificationNumber;
    _isPivaValidated = isPivaValidated;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _pivaTransactionId = pivaTransactionId;
    _dateOfBirth = dateOfBirth;
    _age = age;
    _isEstimatedAge = isEstimatedAge;
    _sexualOrientationId = sexualOrientationId;
    _languageId = languageId;
    _genderId = genderId;
    _maritalStatusId = maritalStatusId;
    _preferredContactTypeId = preferredContactTypeId;
    _religionId = religionId;
    _phoneNumber = phoneNumber;
    _mobilePhoneNumber = mobilePhoneNumber;
    _emailAddress = emailAddress;
    _populationGroupId = populationGroupId;
    _nationalityId = nationalityId;
    _disabilityTypeId = disabilityTypeId;
    // _disabilityId = disabilityId;
    _citizenshipId = citizenshipId;
    _dateLastModified = dateLastModified;
    _modifiedBy = modifiedBy;
    _createdBy = createdBy;
    _dateCreated = dateCreated;

  }

  PersonDto.fromJson(dynamic json) {
    _personId = json['personId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _knownAs = json['knownAs'];
    _identificationTypeId = json['identificationTypeId'];
    _identificationNumber = json['identificationNumber'];
    _isPivaValidated = json['isPivaValidated'];
    _isActive = json['isPivaValidated'];
    _isDeleted = json['isDeleted'];
    _pivaTransactionId = json['pivaTransactionId'];
    _dateOfBirth = json['dateOfBirth'];
    _age = json['age'];
    _isEstimatedAge = json['isEstimatedAge'];
    _sexualOrientationId = json['sexualOrientationId'];
    _languageId = json['languageId'];
    _genderId = json['genderId'];
    _maritalStatusId = json['maritalStatusId'];
    _preferredContactTypeId = json['preferredContactTypeId'];
    _religionId = json['religionId'];
    _phoneNumber = json['phoneNumber'];
    _mobilePhoneNumber = json['mobilePhoneNumber'];
    _emailAddress = json['emailAddress'];
    _populationGroupId = json['populationGroupId'];
    _nationalityId = json['nationalityId'];
    _disabilityTypeId = json['disabilityTypeId'];
    // _disabilityId = json['disabilityId'];
    _citizenshipId = json['citizenshipId'];
    _dateLastModified = json['dateLastModified'];
    _modifiedBy = json['modifiedBy'];
    _createdBy = json['createdBy'];
    _dateCreated = json['dateCreated'];
  }

  int? _personId;
  String? _firstName;
  String? _lastName;
  String? _knownAs;
  int? _identificationTypeId;
  String? _identificationNumber;
  bool? _isPivaValidated;
  String? _pivaTransactionId;
  String? _dateOfBirth;
  int? _age;
  bool? _isEstimatedAge;
  bool? _isActive;
  bool? _isDeleted;
  int? _sexualOrientationId;
  int? _languageId;
  int? _genderId;
  int? _maritalStatusId;
  int? _preferredContactTypeId;
  int? _religionId;
  String? _phoneNumber;
  String? _mobilePhoneNumber;
  String? _emailAddress;
  int? _populationGroupId;
  int? _nationalityId;
  int? _disabilityTypeId;
  // int? _disabilityId;
  int? _citizenshipId;
  String? _dateLastModified;
  String? _modifiedBy;
  String? _createdBy;
  String? _dateCreated;


  int? get personId => _personId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get knownAs => _knownAs;
  int? get identificationTypeId => _identificationTypeId;
  String? get identificationNumber => _identificationNumber;
  bool? get isPivaValidated => _isPivaValidated;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  String? get pivaTransactionId => _pivaTransactionId;
  String? get dateOfBirth => _dateOfBirth;
  int? get age => _age;
  bool? get isEstimatedAge => _isEstimatedAge;
  int? get sexualOrientationId => _sexualOrientationId;
  int? get languageId => _languageId;
  int? get genderId => _genderId;
  int? get maritalStatusId => _maritalStatusId;
  int? get preferredContactTypeId => _preferredContactTypeId;
  int? get religionId => _religionId;
  String? get phoneNumber => _phoneNumber;
  String? get mobilePhoneNumber => _mobilePhoneNumber;
  String? get emailAddress => _emailAddress;
  int? get populationGroupId => _populationGroupId;
  int? get nationalityId => _nationalityId;
  int? get disabilityTypeId => _disabilityTypeId;
  // int? get disabilityId => _disabilityTypeId;
  int? get citizenshipId => _citizenshipId;
  String? get dateLastModified => _dateLastModified;
  String? get modifiedBy => _modifiedBy;
  String? get createdBy => _createdBy;
  String? get dateCreated => _dateCreated;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['personId'] = _personId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['knownAs'] = _knownAs;
    map['identificationTypeId'] = _identificationTypeId;
    map['identificationNumber'] = _identificationNumber;
    map['isPivaValidated'] = _isPivaValidated;
    map['pivaTransactionId'] = _pivaTransactionId;
    map['dateOfBirth'] = _dateOfBirth;
    map['age'] = _age;
    map['isEstimatedAge'] = _isEstimatedAge;
    map['isActive'] = _isActive;
    map['isDeleted'] = _isDeleted;
    map['sexualOrientationId'] = _sexualOrientationId;
    map['languageId'] = _languageId;
    map['genderId'] = _genderId;
    map['maritalStatusId'] = _maritalStatusId;
    map['preferredContactTypeId'] = _preferredContactTypeId;
    map['religionId'] = _religionId;
    map['phoneNumber'] = _phoneNumber;
    map['mobilePhoneNumber'] = _mobilePhoneNumber;
    map['emailAddress'] = _emailAddress;
    map['populationGroupId'] = _populationGroupId;
    map['nationalityId'] = _nationalityId;
    map['disabilityTypeId'] = _disabilityTypeId;
    // map['disabilityId'] = _disabilityId;
    map['citizenshipId'] = _citizenshipId;
    map['dateLastModified'] = _dateLastModified;
    map['modifiedBy'] = _modifiedBy;
    map['createdBy'] = _createdBy;
    map['dateCreated'] = _dateCreated;
    return map;
  }
}
