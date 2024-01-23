
import 'package:dsd_nisis_mobile/model/site/site_dto.dart';
import 'package:hive/hive.dart';
import '../../../model/household/house_dto.dart';
import '../../../model/intake/person_dto.dart';
import '../../../model/site/siteEa_segments_Dto.dart';
import '../../../model/site/site_ea_dto.dart';
import '../../../model/site/site_profiling_methodsDto.dart';
import '../../../model/site/site_profiling_toolsDto.dart';
import '../../../model/ward/ward_dto.dart';
import 'household.model.dart';


part 'household.details.model.g.dart';

@HiveType(typeId: 99)

class HouseholdDetailsModel extends HiveObject{
  @HiveField(0)
  int? profilingInstanceId;
  @HiveField(1)
  String? profilingDate;
  @HiveField(2)
  int? capturedByUserId;
  @HiveField(3)
  int? siteId;
  @HiveField(4)
  int? profilingToolId;
  @HiveField(5)
  int? profilingMethodId;
  @HiveField(6)
  int? personId;
  @HiveField(7)
  int? hHID;
  @HiveField(8)
  int? nISISSiteEAId;
  @HiveField(9)
  int? dwellingUnitNumber;
  @HiveField(10)
  int? householdNumber;
  @HiveField(11)
  int? householdNumberOfMales;
  @HiveField(12)
  int? householdNumberOfFemales;
  @HiveField(13)
  String? dwellingUnitAddress;
  @HiveField(14)
  String? dwellingUnitDescription;
  @HiveField(15)
  int? qAStatusItemId;
  @HiveField(16)
  String? isActive;
  @HiveField(17)
  String? isDeleted;
  @HiveField(18)
  String? dateCreated;
  @HiveField(19)
  String? createdBy;
  @HiveField(20)
  String? dateLastModified;
  @HiveField(21)
  String? modifiedBy;
  @HiveField(22)
  int? provinceId;
  @HiveField(23)
  String? profilingDateCaptured;
  @HiveField(24)
  SiteDto? siteDto;
  @HiveField(25)
  SiteProfilingToolsDto? siteProfilingToolsDto;
  @HiveField(26)
  SiteProfilingMethodDto? siteProfilingMethodDto;
  @HiveField(27)
  PersonDto? personDto;
  @HiveField(28)
  HouseHoldDto? houseHoldDto;

  HouseholdDetailsModel({
    this.profilingInstanceId,
    this.profilingDate,
    this.capturedByUserId,
    this.siteId,
    this.profilingToolId,
    this.profilingMethodId,
    this.personId,
    this.hHID,
    this.nISISSiteEAId,
    this.dwellingUnitNumber,
    this.householdNumber,
    this.householdNumberOfMales,
    this.householdNumberOfFemales,
    this.dwellingUnitAddress,
    this.dwellingUnitDescription,
    this.qAStatusItemId,
    this.isActive,
    this.isDeleted,
    this.dateCreated,
    this.createdBy,
    this.dateLastModified,
    this.modifiedBy,
    this.provinceId,
    this.profilingDateCaptured,
    this.siteDto,
    this.siteProfilingToolsDto,
    this.siteProfilingMethodDto,
    this.personDto,
    this.houseHoldDto, HouseHoldDto? HouseholdModel,
  });

  HouseholdDetailsModel.fromJson(Map<String, dynamic> json) {
    profilingInstanceId = json['profilingInstanceId'];
    profilingDate = json['profilingDate'];
    capturedByUserId = json['capturedByUserId'];
    siteId = json['siteId'];
    profilingToolId = json['profilingToolId'];
    profilingMethodId = json['profilingMethodId'];
    personId = json['personId'];
    hHID = json['hHID'];
    nISISSiteEAId = json['nISISSiteEAId'];
    dwellingUnitNumber = json['dwellingUnitNumber'];
    householdNumber = json['householdNumber'];
    householdNumberOfMales = json['householdNumberOfMales'];
    householdNumberOfFemales = json['householdNumberOfFemales'];
    dwellingUnitAddress = json['dwellingUnitAddress'];
    dwellingUnitDescription = json['dwellingUnitDescription'];
    qAStatusItemId = json['qAStatusItemId'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    dateCreated = json['dateCreated'];
    createdBy = json['createdBy'];
    dateLastModified = json['dateLastModified'];
    modifiedBy = json['modifiedBy'];
    provinceId = json['provinceId'];
    profilingDateCaptured = json['profilingDateCaptured'];
    siteDto = json['siteDto'] != null ? SiteDto.fromJson(json['siteDto']) : null;
    siteProfilingToolsDto = json['siteProfilingToolsDto'] != null
        ? SiteProfilingToolsDto.fromJson(json['siteProfilingToolsDto'])
        : null;
    siteProfilingMethodDto = json['siteProfilingMethodDto'] != null
        ? SiteProfilingMethodDto.fromJson(json['siteProfilingMethodDto'])
        : null;
    personDto = json['personDto'] != null
        ? PersonDto.fromJson(json['personDto'])
        : null;
    houseHoldDto = json['houseHoldDto'] != null
        ? HouseHoldDto.fromJson(json['houseHoldDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'profilingInstanceId': profilingInstanceId,
      'profilingDate': profilingDate,
      'capturedByUserId': capturedByUserId,
      'siteId': siteId,
      'profilingToolId': profilingToolId,
      'profilingMethodId': profilingMethodId,
      'personId': personId,
      'hHID': hHID,
      'nISISSiteEAId': nISISSiteEAId,
      'dwellingUnitNumber': dwellingUnitNumber,
      'householdNumber': householdNumber,
      'householdNumberOfMales': householdNumberOfMales,
      'householdNumberOfFemales': householdNumberOfFemales,
      'dwellingUnitAddress': dwellingUnitAddress,
      'dwellingUnitDescription': dwellingUnitDescription,
      'qAStatusItemId': qAStatusItemId,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'dateCreated': dateCreated,
      'createdBy': createdBy,
      'dateLastModified': dateLastModified,
      'modifiedBy': modifiedBy,
      'provinceId': provinceId,
      'profilingDateCaptured': profilingDateCaptured,
      'siteDto': siteDto != null ? siteDto!.toJson() : null,
      'siteProfilingToolsDto':
      siteProfilingToolsDto != null ? siteProfilingToolsDto!.toJson() : null,
      'siteProfilingMethodDto':
      siteProfilingMethodDto != null ? siteProfilingMethodDto!.toJson() : null,
      'personDto': personDto != null ? personDto!.toJson() : null,
      'houseHoldDto': houseHoldDto != null ? houseHoldDto!.toJson() : null,
    };
    return data;
  }
}
