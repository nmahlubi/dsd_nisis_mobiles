

import '../intake/province_dto.dart';
import '../ward/ward_dto.dart';

class SiteDto {
  final int? siteId;
  final String? siteName;
  final String? siteAlternativeName;
  final String? gpsCoordinatesLat;
  final String? gpsCoordinatesLong;
  final int? registeredProgrammeId;
  final int? registeredProgrammeStatusId;
  final String? responsibleOrganization;
  final String? siteEas;
  final String? prioritizationGroup;
  final String? targetStartDate;
  final String? targetEndDate;
  final String? primaryContact;
  final int? listingMethodId;
  final int? responsibleProgrammeId;
  final int? estimatedPopulation;
  final String? sourceOfPopulationEstimate;
  final int? budgetCommitted;
  final int? qaStatusItemId;
  final String? isActive;
  final String? isDeleted;
  final DateTime? dateCreated;
  final String? createdBy;
  final DateTime? dateLastModified;
  final String? modifiedBy;
  final ProvinceDto? provinceDto;
  final WardDto? wardDto;

  SiteDto({
    this.siteId,
    this.siteName,
    this.siteAlternativeName,
    this.gpsCoordinatesLat,
    this.gpsCoordinatesLong,
    this.registeredProgrammeId,
    this.registeredProgrammeStatusId,
    this.responsibleOrganization,
    this.siteEas,
    this.prioritizationGroup,
    this.targetStartDate,
    this.targetEndDate,
    this.primaryContact,
    this.listingMethodId,
    this.responsibleProgrammeId,
    this.estimatedPopulation,
    this.sourceOfPopulationEstimate,
    this.budgetCommitted,
    this.qaStatusItemId,
    this.isActive,
    this.isDeleted,
    this.dateCreated,
    this.createdBy,
    this.dateLastModified,
    this.modifiedBy,
    this.provinceDto,
    this.wardDto,
  });

  factory SiteDto.fromJson(Map<String, dynamic> json) {
    return SiteDto(
      siteId: json['siteId'],
      siteName: json['siteName'],
      siteAlternativeName: json['siteAlternativeName'],
      gpsCoordinatesLat: json['gpsCoordinatesLat'],
      gpsCoordinatesLong: json['gpsCoordinatesLong'],
      registeredProgrammeId: json['registeredProgrammeId'],
      registeredProgrammeStatusId: json['registeredProgrammeStatusId'],
      responsibleOrganization: json['responsibleOrganization'],
      siteEas: json['siteEas'],
      prioritizationGroup: json['prioritizationGroup'],
      targetStartDate: json['targetStartDate'],
      targetEndDate: json['targetEndDate'],
      primaryContact: json['primaryContact'],
      listingMethodId: json['listingMethodId'],
      responsibleProgrammeId: json['responsibleProgrammeId'],
      estimatedPopulation: json['estimatedPopulation'],
      sourceOfPopulationEstimate: json['sourceOfPopulationEstimate'],
      budgetCommitted: json['budgetCommitted'],
      qaStatusItemId: json['qaStatusItemId'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      dateCreated: json['dateCreated'] != null
          ? DateTime.parse(json['dateCreated'])
          : null,
      createdBy: json['createdBy'],
      dateLastModified: json['dateLastModified'] != null
          ? DateTime.parse(json['dateLastModified'])
          : null,
      modifiedBy: json['modifiedBy'],
      provinceDto: json['provinceDto'] != null
          ? ProvinceDto.fromJson(json['provinceDto'])
          : null,
      wardDto: json['wardDto'] != null ? WardDto.fromJson(json['wardDto']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'siteId': siteId,
      'siteName': siteName,
      'siteAlternativeName': siteAlternativeName,
      'gpsCoordinatesLat': gpsCoordinatesLat,
      'gpsCoordinatesLong': gpsCoordinatesLong,
      'registeredProgrammeId': registeredProgrammeId,
      'registeredProgrammeStatusId': registeredProgrammeStatusId,
      'responsibleOrganization': responsibleOrganization,
      'siteEas': siteEas,
      'prioritizationGroup': prioritizationGroup,
      'targetStartDate': targetStartDate,
      'targetEndDate': targetEndDate,
      'primaryContact': primaryContact,
      'listingMethodId': listingMethodId,
      'responsibleProgrammeId': responsibleProgrammeId,
      'estimatedPopulation': estimatedPopulation,
      'sourceOfPopulationEstimate': sourceOfPopulationEstimate,
      'budgetCommitted': budgetCommitted,
      'qaStatusItemId': qaStatusItemId,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'dateCreated': dateCreated?.toIso8601String(), // Convert DateTime to string
      'createdBy': createdBy,
      'dateLastModified': dateLastModified?.toIso8601String(), // Convert DateTime to string
      'modifiedBy': modifiedBy,
      'provinceDto': provinceDto?.toJson(), // Convert nested object to JSON
      //'wardDto': wardDto != null? : ,// Convert nested object to JSON
    };
  }

}

