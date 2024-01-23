



import 'package:hive/hive.dart';
import '../../../model/intake/province_dto.dart';
import '../../../model/ward/ward_dto.dart';


part 'site.model.g.dart';

@HiveType(typeId: 50)
class SiteModel extends HiveObject{
  @HiveField(0)
  int? siteId;
  @HiveField(1)
  String? siteName;
  @HiveField(2)
  String? siteAlternativeName;
  @HiveField(3)
  String? gpsCoordinatesLat;
  @HiveField(4)
  String? gpsCoordinatesLong;
  @HiveField(5)
  int? registeredProgrammeId;
  @HiveField(6)
  int? registeredProgrammeStatusId;
  @HiveField(7)
  String? responsibleOrganization;
  @HiveField(8)
  String? siteEas;
  @HiveField(9)
  String? prioritizationGroup;
  @HiveField(10)
  String? targetStartDate;
  @HiveField(11)
  String? targetEndDate;
  @HiveField(12)
  String? primaryContact;
  @HiveField(13)
  int? listingMethodId;
  @HiveField(14)
  int? responsibleProgrammeId;
  @HiveField(15)
  int? estimatedPopulation;
  @HiveField(16)
  String? sourceOfPopulationEstimate;
  @HiveField(17)
  int? budgetCommitted;
  @HiveField(18)
  int? qaStatusItemId;
  @HiveField(19)
  String? isActive;
  @HiveField(20)
  String? isDeleted;
  @HiveField(21)
  DateTime? dateCreated;
  @HiveField(22)
  String? createdBy;
  @HiveField(23)
  String? dateLastModified;
  @HiveField(24)
  String? modifiedBy;
  @HiveField(25)
  ProvinceDto? provinceDto;
  @HiveField(26)
  WardDto? wardDto;
  SiteModel(
      {
    this.siteId,
        this.modifiedBy,
        this.dateCreated,
        this.isDeleted,
        this.dateLastModified,
        this.isActive,
        this.budgetCommitted,
        this.createdBy,
        this.estimatedPopulation,
        this.gpsCoordinatesLat,
        this.gpsCoordinatesLong,
        this.listingMethodId,
        this.primaryContact,
        this.prioritizationGroup,
        this.provinceDto,
        this.qaStatusItemId,
        this.registeredProgrammeId,
        this.registeredProgrammeStatusId,
        this.responsibleOrganization,
        this.responsibleProgrammeId,
        this.siteAlternativeName,
        this.siteEas,
        this.siteName,
        this.sourceOfPopulationEstimate,
        this.targetEndDate,
        this.targetStartDate,
        this.wardDto
      });
}

