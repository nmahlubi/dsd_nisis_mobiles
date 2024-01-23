



import '../intake/person_dto.dart';
import '../site/site_dto.dart';
import '../site/site_profiling_methodsDto.dart';
import '../site/site_profiling_toolsDto.dart';
import 'house_dto.dart';


class HouseHoldDetailsDto{
  HouseHoldDetailsDto({
    int? profilingInstanceId,
    String? profilingDate,
    int? capturedByUserId,
    int? siteId,
    int? profilingToolId,
    int? profilingMethodId,
    int? personId,
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
    String? dateCreated,
    String?   createdBy,
    String? dateLastModified,
    String? modifiedBy,
    int? provinceId,
    String? profilingDateCaptured,
    SiteDto? siteDto,
    SiteProfilingToolsDto? siteProfilingToolsDto,
    SiteProfilingMethodDto? siteProfilingMethodDto,
    PersonDto? personDto,
    HouseHoldDto? houseHoldDto,

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
    _siteDto = siteDto;
    _siteProfilingToolsDto = siteProfilingToolsDto;
    _siteProfilingMethodDto = siteProfilingMethodDto;
    _personDto = personDto;
    _houseHoldDto = houseHoldDto;



  }

  HouseHoldDetailsDto.fromJson(dynamic json) {
    _profilingInstanceId = json['profilingInstanceId'] ?? 0;
    _profilingDate = json['profilingDate'];
    // Handle other properties similarly with proper null checks or default values

    print('Parsed Instance ID: $_profilingInstanceId');
    _profilingInstanceId = json['profilingInstanceId'];
    _profilingDate = json['profilingDate'];
    _profilingToolId = json['profilingToolId'];
    _profilingMethodId = json['profilingMethodId'];
    _capturedByUserId = json['capturedByUserId'];
    _HHID = json['HHID'];
    _NISISSiteEAId= json['NISISSiteEAId'];
    _dwellingUnitNumber = json['dwellingUnitNumber'];
    _householdNumber = json['householdNumber'];
    _householdNumberOfMales = json['householdNumberOfMales'];
    _householdNumberOfFemales = json['householdNumberOfFemales'];
    _dwellingUnitAddress= json['dwellingUnitAddress'];
    _dwellingUnitDescription= json['dwellingUnitDescription'];
    _qAStatusItemId = json['qAStatusItemId'];
    _isActive= json['isActive'];
    _isDeleted= json['isDeleted'];
    _dateCreate = json['dateCreated'];
    _createdBy= json['createdBy'];
    _dateLastModified = json['dateLastModified '];
    _modifiedBy= json['modifiedBy'];
    _provinceId= json['provinceId'];
    _siteDto = json['siteDto'] != null
        ? SiteDto.fromJson(json['siteDto'])
        : null;
    _siteProfilingToolsDto = json['siteProfilingToolsDto'] != null
        ? SiteProfilingToolsDto.fromJson(json['siteProfilingToolsDto'])
        : null;
    _siteProfilingMethodDto = json['siteProfilingMethodDto'] != null
        ? SiteProfilingMethodDto.fromJson(json['siteProfilingMethodDto'])
        : null;
    _personDto = json['personDto'] != null
        ? PersonDto.fromJson(json['personDto'])
        : null;
    _houseHoldDto = json['houseHoldDto'] != null
        ? HouseHoldDto.fromJson(json['houseHoldDto'])
        : null;


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
  SiteDto? _siteDto;
  SiteProfilingToolsDto? _siteProfilingToolsDto;
  SiteProfilingMethodDto? _siteProfilingMethodDto;
  PersonDto? _personDto;
  HouseHoldDto? _houseHoldDto;



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
  String? get dateCreated => dateCreated;
  String? get dateModified => dateModified;
  SiteDto? get siteDto => _siteDto;
  SiteProfilingToolsDto? get siteProfilingToolsDto => _siteProfilingToolsDto;
  SiteProfilingMethodDto? get siteProfilingMethodDto => _siteProfilingMethodDto;
  PersonDto? get personDto =>_personDto;
  HouseHoldDto? get houseHoldDto =>_houseHoldDto;





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
    if (_siteProfilingToolsDto != null) {
      map['siteProfilingToolsDto'] = _siteProfilingToolsDto?.toJson();
    }
    if (_siteProfilingMethodDto != null) {
      map['siteProfilingMethodDto'] = _siteProfilingMethodDto?.toJson();
    }
    if (_personDto != null) {
      map['personDto'] = _personDto?.toJson();
    }
    if (_houseHoldDto != null) {
      map['houseHoldDto'] = _houseHoldDto?.toJson();
    }

    return map;
  }
}

