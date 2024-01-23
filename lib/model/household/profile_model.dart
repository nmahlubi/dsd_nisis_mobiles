

class ProfilingInstance {
  final int profilingInstanceId;
  final String profilingDate;
  final int profilingToolId;
  final int profilingMethodId;
  final int capturedByUserId;
  final String hhid;
  final int nisiSSiteEAId;
  final int dwellingUnitNumber;
  final int householdNumber;
  final int? householdNumberOfMales;
  final int? householdNumberOfFemales;
  final String dwellingUnitAddress;
  final String dwellingUnitDescription;
  final int qAStatusItemId;
  final bool isActive;
  final bool isDeleted;
  final String dateCreated;
  final String createdBy;
  final String? dateLastModified;
  final String? modifiedBy;
  final int? provinceId;
  final int? personId;
  final String? profilingDateCaptured;
  final SiteEaDto? siteEaDto;

  ProfilingInstance({
    required this.profilingInstanceId,
    required this.profilingDate,
    required this.profilingToolId,
    required this.profilingMethodId,
    required this.capturedByUserId,
    required this.hhid,
    required this.nisiSSiteEAId,
    required this.dwellingUnitNumber,
    required this.householdNumber,
    this.householdNumberOfMales,
    this.householdNumberOfFemales,
    required this.dwellingUnitAddress,
    required this.dwellingUnitDescription,
    required this.qAStatusItemId,
    required this.isActive,
    required this.isDeleted,
    required this.dateCreated,
    required this.createdBy,
    this.dateLastModified,
    this.modifiedBy,
    this.provinceId,
    this.personId,
    this.profilingDateCaptured,
    this.siteEaDto,
  });

  factory ProfilingInstance.fromJson(Map<String, dynamic> json) {
    return ProfilingInstance(
      profilingInstanceId: json['profiling_Instance_Id'],
      profilingDate: json['profiling_Date'],
      profilingToolId: json['profiling_Tool_Id'],
      profilingMethodId: json['profiling_Method_Id'],
      capturedByUserId: json['captured_By_UserId'],
      hhid: json['hhid'],
      nisiSSiteEAId: json['nisiS_Site_EA_Id'],
      dwellingUnitNumber: json['dwelling_Unit_Number'],
      householdNumber: json['household_Number'],
      householdNumberOfMales: json['household_Number_Of_Males'],
      householdNumberOfFemales: json['household_Number_Of_Females'],
      dwellingUnitAddress: json['dwelling_Unit_Address'],
      dwellingUnitDescription: json['dwelling_Unit_Description'],
      qAStatusItemId: json['qA_Status_Item_Id'],
      isActive: json['is_Active'],
      isDeleted: json['is_Deleted'],
      dateCreated: json['date_Created'],
      createdBy: json['created_By'],
      dateLastModified: json['date_Last_Modified'],
      modifiedBy: json['modified_By'],
      provinceId: json['province_Id'],
      personId: json['person_Id'],
      profilingDateCaptured: json['profiling_Date_Captured'],
      // siteEaDto: json['siteEaDto'] != null
      //     ? SiteEaDto.fromJson(json['siteEaDto'])
      //     : null,
    );
  }
}

class SiteEaDto {
  final int siteEaId;
  final int siteId;
  final String eaCode;
  final String communityName;
  final String dateCreated;
  final String createdBy;
  final String dateLastModified;
  final String modifiedBy;
  final bool isActive;
  final bool isDeleted;
  final Site site;

  SiteEaDto({
    required this.siteEaId,
    required this.siteId,
    required this.eaCode,
    required this.communityName,
    required this.dateCreated,
    required this.createdBy,
    required this.dateLastModified,
    required this.modifiedBy,
    required this.isActive,
    required this.isDeleted,
    required this.site,
  });

  factory SiteEaDto.fromJson(Map<String, dynamic> json) {
    return SiteEaDto(
      siteEaId: json['siteEaId'],
      siteId: json['siteId'],
      eaCode: json['eaCode'],
      communityName: json['communityName'],
      dateCreated: json['dateCreated'],
      createdBy: json['createdBy'],
      dateLastModified: json['dateLastModified'],
      modifiedBy: json['modifiedBy'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      site: Site.fromJson(json['site']),
    );
  }
}

class Site {
  final int siteId;
  final int wardId;
  final String siteName;
  final String siteAlternativeName;
  final double? gpsCoordinatesLat;
  final double? gpsCoordinatesLong;
  final int? registeredProgrammeId;
  final int registeredProgrammeStatusId;
  final String responsibleOrganization;
  final String? prioritizationGroup;
  final String targetStartDate;
  final String targetEndDate;
  final String primaryContact;
  final int listingMethodId;
  final int responsibleProgrammeId;
  final int estimatedPopulation;
  final String sourceOfPopulationEstimate;
  final double? budgetCommitted;
  final int qAStatusItemId;
  final bool isActive;
  final bool isDeleted;
  final String createdBy;
  final String createdDate;
  final String modifiedBy;
  final String modifiedDate;
  final int? provinceId;
  final dynamic provinces;
  final List<dynamic>? siteEas;

  Site({
    required this.siteId,
    required this.wardId,
    required this.siteName,
    required this.siteAlternativeName,
    required this.gpsCoordinatesLat,
    required this.gpsCoordinatesLong,
    required this.registeredProgrammeId,
    required this.registeredProgrammeStatusId,
    required this.responsibleOrganization,
    required this.prioritizationGroup,
    required this.targetStartDate,
    required this.targetEndDate,
    required this.primaryContact,
    required this.listingMethodId,
    required this.responsibleProgrammeId,
    required this.estimatedPopulation,
    required this.sourceOfPopulationEstimate,
    required this.budgetCommitted,
    required this.qAStatusItemId,
    required this.isActive,
    required this.isDeleted,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
    required this.provinceId,
    required this.provinces,
    required this.siteEas,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
        siteId: json['siteId'],
        wardId: json['wardId'],
        siteName: json['siteName'],
        siteAlternativeName: json['siteAlternativeName'],
        gpsCoordinatesLat: json['gpsCoordinatesLat'],
        gpsCoordinatesLong: json['gpsCoordinatesLong'],
        registeredProgrammeId: json['registeredProgrammeId'],
        registeredProgrammeStatusId: json['registeredProgrammeStatusId'],
        responsibleOrganization: json['responsibleOrganization'],
        prioritizationGroup: json['prioritizationGroup'],
        targetStartDate: json['targetStartDate'],
        targetEndDate: json['targetEndDate'],
        primaryContact: json['primaryContact'],
        listingMethodId: json['listingMethodId'],
        responsibleProgrammeId: json['responsibleProgrammeId'],
      estimatedPopulation: json['estimatedPopulation'],
      sourceOfPopulationEstimate: json['sourceOfPopulationEstimate'],
      budgetCommitted: json['budgetCommitted'],
      qAStatusItemId: json['qAStatusItemId'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      modifiedBy: json['modifiedBy'],
      modifiedDate: json['modifiedDate'],
      provinceId: json['province_Id'],
      provinces: json['provinces'],
      siteEas: json['siteEas'] != null
          ? List<dynamic>.from(json['siteEas'].map((x) => x))
          : null,
    );
  }
}

