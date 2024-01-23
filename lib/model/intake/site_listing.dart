class Site {
  Site({
    int? siteId,
    int? wardId,
    String? siteName,
    String? siteAlternativeName,
    bool? isActive,
    String? dateCreated,
    String? province,
    String? district,
    String? localMunicipality,
    String? ward,
    String? createdBy,
    String? responsible,
    // ... other fields ...
  }) {
    _siteId = siteId;
    _wardId = wardId;
    _siteName = siteName;
    _siteAlternativeName = siteAlternativeName;
    _isActive = isActive;
    _dateCreated = dateCreated;
    _province = province;
    _district = district;
    _localMunicipality = localMunicipality;
    _ward = ward;
    _createdBy = createdBy;
    _responsible = responsible;
    // ... initialize other fields ...
  }

  Site.fromJson(dynamic json) {
    _siteId = json['siteId'];
    _wardId = json['wardId'];
    _siteName = json['siteName'];
    _siteAlternativeName = json['siteAlternativeName'];
    _isActive = json['isActive'];
    _dateCreated = json['createdDate'];
    _province = json['province_Id']?.toString();
    _district = json['ward']['localMunicipality']['district']['description'];
    _localMunicipality = json['ward']['localMunicipalityId']?.toString();
    _ward = json['ward']['description'];
    _createdBy = json['createdBy'];
    _responsible = json['responsibleProgrammeId']?.toString();
    // ... handle other fields similarly ...
  }

  int? _siteId;
  int? _wardId;
  String? _siteName;
  String? _siteAlternativeName;
  bool? _isActive;
  String? _dateCreated;
  String? _province;
  String? _district;
  String? _localMunicipality;
  String? _ward;
  String? _createdBy;
  String? _responsible;
  // ... other private fields ...

  int? get siteId => _siteId;
  int? get wardId => _wardId;
  String? get siteName => _siteName;
  String? get siteAlternativeName => _siteAlternativeName;
  bool? get isActive => _isActive;
  String? get dateCreated => _dateCreated;
  String? get province => _province;
  String? get district => _district;
  String? get localMunicipality => _localMunicipality;
  String? get ward => _ward;
  String? get createdBy => _createdBy;
  String? get responsible => _responsible;
  // ... other getters ...

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['siteId'] = _siteId;
    map['wardId'] = _wardId;
    map['siteName'] = _siteName;
    map['siteAlternativeName'] = _siteAlternativeName;
    map['isActive'] = _isActive;
    map['createdDate'] = _dateCreated;
    map['province_Id'] = _province;
    map['ward'] = {
      'localMunicipality': {
        'district': {'description': _district}
      },
      'localMunicipalityId': _localMunicipality,
      'description': _ward
    };
    map['createdBy'] = _createdBy;
    map['responsibleProgrammeId'] = _responsible;
    // ... serialize other fields ...
    return map;
  }
}
