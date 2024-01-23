

import '../site/site_dto.dart';

class HouseHoldDto{
  HouseHoldDto({
    int? profilingInstanceId,
    String? profilingDate,
    int? profilingToolId,
    int? profilingMethodId,
    int? capturedByUserId,
    int? hHID,
    int? nISISSiteEAId,
    int? dwellingUnitNumber,
    int? householdNumber,
    int? householdNumberOfMales,
    int? householdNumberOfFemales,
    String? dwellingUnitAddress,
    String? dwellingUnitDescription,
    int? qAStatusItemId,
    String? isActive,
    String? isDeleted,
    DateTime? dateCreated,
    String?   createdBy,
    String? dateLastModified,
    String? modifiedBy,
    int? provinceId,
    int? personId,
    String? profilingDateCaptured,
    SiteDto? siteDto,
  }) {

    _profilingInstanceId = profilingInstanceId;
    _profilingDate = profilingDate;
    _profilingToolId = profilingToolId;
    _profilingMethodId = profilingMethodId;
    _capturedByUserId = capturedByUserId;
    _HHID = HHID;
    _NISISSiteEAId= NISISSiteEAId;
    _dwellingUnitNumber = dwellingUnitNumber;
    _householdNumber = householdNumber;
    _householdNumberOfMales = householdNumberOfMales;
    _householdNumberOfFemales = householdNumberOfFemales;
    _dwellingUnitAddress= dwellingUnitAddress;
    _dwellingUnitDescription= dwellingUnitDescription;
    _qAStatusItemId = qAStatusItemId;
    _isActive= isActive!;
    _isDeleted= isDeleted!;
    _dateCreate = dateCreated as String?;
    _createdBy= createdBy!;
    _dateLastModified = dateLastModified;
    _modifiedBy= modifiedBy!;
    _provinceId= provinceId;
    _personId = personId;
    _siteDto = siteDto;
  }

  HouseHoldDto.fromJson(dynamic json) {
      _profilingInstanceId = json['profilingInstanceId'] as int?;
      _profilingDate = json['profilingDate'] as String?;
      _profilingToolId = json['profilingToolId'] as int?;
      _profilingMethodId = json['profilingMethodId'] as int?;
      _capturedByUserId = json['capturedByUserId'] as int?;
      _HHID = json['HHID'] as int?;
      _NISISSiteEAId = json['NISISSiteEAId'] as int?;
      _dwellingUnitNumber = json['dwellingUnitNumber'] as int?;
      _householdNumber = json['householdNumber'] as int?;
      _householdNumberOfMales = json['householdNumberOfMales'] as int?;
      _householdNumberOfFemales = json['householdNumberOfFemales'] as int?;
      _dwellingUnitAddress = json['dwellingUnitAddress'] as String?;
      _dwellingUnitDescription = json['dwellingUnitDescription'] as String?;
      _qAStatusItemId = json['qAStatusItemId'] as int?;
      _isActive = json['isActive'] as String? ?? '';
      _isDeleted = json['isDeleted'] as String? ?? '';
      _dateCreate = json['dateCreated'] as String?;
      _createdBy = json['createdBy'] as String? ?? '';
      _dateLastModified = json['dateLastModified'] as String?;
      _modifiedBy = json['modifiedBy'] as String? ?? '';
      _provinceId = json['provinceId'] as int?;
      _personId = json['personId'] as int?;
      _siteDto = json['siteDto'] != null ? SiteDto.fromJson(json['siteDto']) : null;



  }
  int?  _profilingInstanceId;
  String?  _profilingDate;
  int? _profilingToolId;
  int? _profilingMethodId;
  int?_capturedByUserId;
  int? _HHID;
  int? _NISISSiteEAId;
  int?  _dwellingUnitNumber;
  int? _householdNumber;
  int? _householdNumberOfMales;
  int? _householdNumberOfFemales;
  String? _dwellingUnitAddress;
  String? _dwellingUnitDescription;
  int?  _qAStatusItemId;
  late  String _isActive;
  late String _isDeleted;
  late String?  _dateCreate;
  late  String _createdBy;
  late  String? _dateLastModified;
  late String _modifiedBy;
  late  int?_provinceId;
  late int? _personId;
  SiteDto? _siteDto;



  int? get profilingInstanceId => _profilingInstanceId;
  String? get profilingDate => _profilingDate;
  int? get profilingToolId => _profilingToolId;
  int? get profilingMethodId => _profilingMethodId;
  int? get capturedByUserId => _capturedByUserId;
  int? get HHID => _HHID;
  int? get NISISSiteEAId => _NISISSiteEAId;
  int? get dwellingUnitNumber => _dwellingUnitNumber;
  int? get householdNumber => _householdNumber;
  int? get householdNumberOfMales => _householdNumberOfMales;
  int? get householdNumberOfFemales => _householdNumberOfFemales;
  String? get dwellingUnitAddress => _dwellingUnitAddress;
  String? get dwellingUnitDescription => _dwellingUnitDescription;
  int? get qAStatusItemId => _qAStatusItemId;
  String get isActive => _isActive;
  String get isDeleted => _isDeleted;
  String get createdBy => _createdBy;
  String get modifiedBy => _modifiedBy;
  String? get dateCreated => _dateCreate;
  String? get dateModified => _dateLastModified;

  SiteDto? get siteDto => _siteDto;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['profilingInstanceId'] = _profilingInstanceId;
    map['profilingDate'] = _profilingDate;
    map['profilingToolId'] = _profilingToolId;
    map['profilingMethodId'] = _profilingMethodId;
    map['capturedByUserId'] = _capturedByUserId;
    map['HHID'] = _HHID;
    map['NISISSiteEAId'] = _NISISSiteEAId;
    map['dwellingUnitNumber'] = _dwellingUnitNumber;
    map['householdNumber'] = _householdNumber;
    map['householdNumberOfMales'] = _householdNumberOfMales;
    map['householdNumberOfFemales'] = _householdNumberOfFemales;
    map['dwellingUnitAddress'] = _dwellingUnitAddress;
    map['dwellingUnitDescription'] = _dwellingUnitDescription;
    map['qAStatusItemId'] = _qAStatusItemId;
    map['isActive'] = _isActive;
    map['isDeleted'] = _isDeleted;
    map['createdBy'] = _createdBy;
    map['modifiedBy'] = _modifiedBy;
    map['dateCreated'] = dateCreated;
    map['dateModified'] = dateModified;
    if (_siteDto != null) {
      map['siteDto'] = _siteDto;
    }
    return map;
  }
}

