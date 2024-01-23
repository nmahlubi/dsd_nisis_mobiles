class HouseHoldDetailsDtoo {
  final int? segmentId;
    int? siteEaId;
  final int? segmentNumber;
  final String? boundaryDescription;
    String? listingStartPointDescription;
  final String? listingRoute;
  final DateTime? dateCreated;
  final String? createdBy;
  final DateTime? dateLastModified;
  final String? modifiedBy;
  final String? isActive;
  final String? isDeleted;
  final String? siteEa;

  HouseHoldDetailsDtoo({
    this.segmentId,
    this.siteEaId,
    this.segmentNumber,
    this.boundaryDescription,
    this.listingStartPointDescription,
    this.listingRoute,
    this.dateCreated,
    this.createdBy,
    this.dateLastModified,
    this.modifiedBy,
    this.isActive,
    this.isDeleted,
    this.siteEa,
  });

  Map<String, dynamic> toJson() {
    return {
      'segmentId': segmentId,
      'siteEaId': siteEaId,
      'segmentNumber': segmentNumber,
      'boundaryDescription': boundaryDescription,
      'listingStartPointDescription': listingStartPointDescription,
      'listingRoute': listingRoute,
      'dateCreated': dateCreated?.toIso8601String(),
      'createdBy': createdBy,
      'dateLastModified': dateLastModified?.toIso8601String(),
      'modifiedBy': modifiedBy,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'siteEa': siteEa,
    };
  }

  factory HouseHoldDetailsDtoo.fromJson(Map<String, dynamic> json) {
    return HouseHoldDetailsDtoo(
      segmentId: json['segmentId'] as int?,
      siteEaId: json['siteEaId'] as int?,
      segmentNumber: json['segmentNumber'] as int?,
      boundaryDescription: json['boundaryDescription'] as String?,
      listingStartPointDescription: json['listingStartPointDescription'] as String?,
      listingRoute: json['listingRoute'] as String?,
      dateCreated: json['dateCreated'] != null ? DateTime.tryParse(json['dateCreated']) : null,
      createdBy: json['createdBy'] as String?,
      dateLastModified: json['dateLastModified'] != null ? DateTime.tryParse(json['dateLastModified']) : null,
      modifiedBy: json['modifiedBy'] as String?,
      isActive: json['isActive'] as String?,
      isDeleted: json['isDeleted'] as String?,
      siteEa: json['siteEa'] as String?,
    );
  }
}
