class Municipality {
  final int localMunicipalityId;
  final int districtMunicipalityId;
  final String description;
  final Ward ward;

  Municipality({
    required this.localMunicipalityId,
    required this.districtMunicipalityId,
    required this.description,
    required this.ward,
  });

  factory Municipality.fromJson(Map<String, dynamic> json) {
    return Municipality(
      localMunicipalityId: json['local_Municipality_Id'],
      districtMunicipalityId: json['district_Municipality_Id'],
      description: json['description'],
      ward: Ward.fromJson(json['ward']),
    );
  }
}

class Ward {
  final int wardId;
  final int localMunicipalityId;
  final String wardCode;
  final String wardNumber;
  final String description;
  final DateTime? dateCreated;
  final String? createdBy;
  final DateTime? dateLastModified;
  final String? lastModifiedBy;
  final bool isActive;
  final bool isDeleted;

  Ward({
    required this.wardId,
    required this.localMunicipalityId,
    required this.wardCode,
    required this.wardNumber,
    required this.description,
    required this.dateCreated,
    required this.createdBy,
    required this.dateLastModified,
    required this.lastModifiedBy,
    required this.isActive,
    required this.isDeleted,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      wardId: json['wardId'],
      localMunicipalityId: json['localMunicipalityId'],
      wardCode: json['wardCode'],
      wardNumber: json['wardNumber'],
      description: json['description'],
      dateCreated: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
      createdBy: json['createdBy'],
      dateLastModified: json['dateLastModified'] != null ? DateTime.parse(json['dateLastModified']) : null,
      lastModifiedBy: json['lastModifiedBy'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
    );
  }
}
