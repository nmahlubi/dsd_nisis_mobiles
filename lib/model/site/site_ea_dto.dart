


import 'package:dsd_nisis_mobile/model/site/site_dto.dart';

// class SiteEADto{
//   SiteEADto({
//     String? eaCode,
//     String? communityName,
//     String? isActive,
//     String? isDeleted,
//     DateTime? dateCreated,
//     String?   createdBy,
//     String? dateLastModified,
//     String? modifiedBy,
//     SiteDto? siteDto,
//   }) {
//     _siteId = siteId;
//     _eaCode = eaCode;
//     _communityName = communityName;
//     _isActive= isActive!;
//     _isDeleted= isDeleted!;
//     _dateCreate = dateCreated as String?;
//     _createdBy= createdBy!;
//     _dateLastModified = dateLastModified;
//     _modifiedBy= modifiedBy!;
//     _siteDto = siteDto;
//
//   }
//
//   SiteEADto.fromJson(dynamic json) {
//     _siteId = json['siteId '];
//     _eaCode = json['eaCode'];
//     _communityName = json['communityName'];
//     _isActive= json['isActive'];
//     _isDeleted= json['isDeleted'];
//     _dateCreate = json['dateCreated'];
//     _createdBy= json['createdBy'];
//     _dateLastModified = json['dateLastModified '];
//     _modifiedBy= json['modifiedBy'];
//     _siteDto = json['siteDto'] != null
//         ? SiteDto.fromJson(json['siteDto'])
//         : null;
//   }
//   int?  _siteId;
//   String?  _eaCode;
//   String? _communityName;
//   late  String _isActive;
//   late String _isDeleted;
//   late String?  _dateCreate;
//   late  String _createdBy;
//   late  String? _dateLastModified;
//   late String _modifiedBy;
//   SiteDto? _siteDto;
//
//   int? get siteId => _siteId;
//   String? get eaCode => _eaCode;
//   String? get communityName => _communityName;
//   String get isActive => _isActive;
//   String get isDeleted => _isDeleted;
//   String get createdBy => _createdBy;
//   String get modifiedBy => _modifiedBy;
//   String? get dateCreated => dateCreated;
//   String? get dateModified => dateModified;
//   SiteDto? get siteDto => _siteDto;
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['siteId'] = _siteId;
//     map['eaCode'] = _eaCode;
//     map['communityName'] = _communityName;
//     map['isActive'] = _isActive;
//     map['isDeleted'] = _isDeleted;
//     map['createdBy'] = _createdBy;
//     map['modifiedBy'] = _modifiedBy;
//     map['dateCreated'] = dateCreated;
//     map['dateModified'] = dateModified;
//     if (_siteDto != null) {
//       map['_iteDto'] = _siteDto;
//     }
//     return map;
//   }
// }

class SiteEADto {
  final int? siteEaId;
  final int? siteId;
  final String? eaCode;
  final String? communityName;
  final DateTime? dateCreated;
  final String? createdBy;
  final DateTime? dateLastModified;
  final String? modifiedBy;
  final bool? isActive;
  final bool? isDeleted;
  final Site? site;
  final List<SiteEaSegment> siteEaSegments;
  // Add other fields as needed

  SiteEADto({
    this.siteEaId,
    this.siteId,
    this.eaCode,
    this.communityName,
    this.dateCreated,
    this.createdBy,
    this.dateLastModified,
    this.modifiedBy,
    this.isActive,
    this.isDeleted,
    this.site,
    required this.siteEaSegments,
    // Add other fields as needed
  });

  factory SiteEADto.fromJson(Map<String, dynamic> json) {
    return SiteEADto(
      siteEaId: json['siteEaId'],
      siteId: json['siteId'],
      eaCode: json['eaCode'],
      communityName: json['communityName'],
      dateCreated: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
      createdBy: json['createdBy'],
      dateLastModified: json['dateLastModified'] != null ? DateTime.parse(json['dateLastModified']) : null,
      modifiedBy: json['modifiedBy'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      site: json['site'] != null ? Site.fromJson(json['site']) : null,
      siteEaSegments: (json['siteEaSegments'] as List<dynamic>?)
          ?.map((segmentJson) => SiteEaSegment.fromJson(segmentJson))
          .toList() ??
          [],
      // Parse other fields as needed
    );
  }
}

class Site {
  final int? siteId;
  final int? wardId;
  final String? siteName;
  final String? siteAlternativeName;
  // Add other fields as needed

  Site({
    this.siteId,
    this.wardId,
    this.siteName,
    this.siteAlternativeName,
    // Add other fields as needed
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      siteId: json['siteId'],
      wardId: json['wardId'],
      siteName: json['siteName'],
      siteAlternativeName: json['siteAlternativeName'],
      // Parse other fields as needed
    );
  }
}

class SiteEaSegment {
  final int? segmentId;
  final int? siteEaId;
  final int? segmentNumber;
  final String? boundaryDescription;
  final String? listingStartPointDescription;
  final String? listingRoute;
  final DateTime? dateCreated;
  final String? createdBy;
  final DateTime? dateLastModified;
  final String? modifiedBy;
  final bool? isActive;
  final bool? isDeleted;
  // Add other fields as needed

  SiteEaSegment({
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
    // Add other fields as needed
  });

  factory SiteEaSegment.fromJson(Map<String, dynamic> json) {
    return SiteEaSegment(
      segmentId: json['segmentId'],
      siteEaId: json['siteEaId'],
      segmentNumber: json['segmentNumber'],
      boundaryDescription: json['boundaryDescription'],
      listingStartPointDescription: json['listingStartPointDescription'],
      listingRoute: json['listingRoute'],
      dateCreated: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
      createdBy: json['createdBy'],
      dateLastModified: json['dateLastModified'] != null ? DateTime.parse(json['dateLastModified']) : null,
      modifiedBy: json['modifiedBy'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      // Parse other fields as needed
    );
  }
}




