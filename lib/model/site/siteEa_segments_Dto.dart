

import 'site_dto.dart';

class SiteEASegmentsDto{
  SiteEASegmentsDto({
    int? segmentId,
    String? segmentNumber,
    String? boundaryDescription,
    String? listingStartPointDescription,
    String? listingRoute,
    String? dateCreated,
    String? createdBy,
    String? dateLastModified,
    String? modifiedBy,
    String? isActive,
    String? isDeleted,

  }) {
    _segmentId = segmentId;
    _segmentNumber = segmentNumber;
    _boundaryDescription= boundaryDescription;
    _listingStartPointDescription = listingStartPointDescription;
    _listingRoute = listingRoute;
    _dateCreated = dateCreated;
    _createdBy = createdBy;
    _dateLastModified = dateLastModified;
    _modifiedBy = modifiedBy;
    _isActive = isActive;
    _isDeleted = isDeleted;
  }

  SiteEASegmentsDto.fromJson(dynamic json) {
    _segmentId = json['segmentId '];
    _segmentNumber = json['segmentNumber'];
    _boundaryDescription = json['boundaryDescription'];
    _listingStartPointDescription = json['listingStartPointDescription '];
    _listingRoute = json['listingRoute'];
    _dateCreated = json['dateCreated'];
    _createdBy = json['createdBy '];
    _dateLastModified = json['dateLastModified'];
    _modifiedBy = json['modifiedBy'];
    _isActive = json['isActive '];
    _isDeleted = json['isDeleted'];

  }
  int?  _segmentId;
  String? _segmentNumber;
  String? _boundaryDescription;
  String? _listingStartPointDescription;
  String? _listingRoute;
  String? _dateCreated;
  String? _createdBy;
  String? _dateLastModified;
  String?  _modifiedBy;
  String? _isActive;
  String? _isDeleted;


  int? get segmentId => _segmentId;
  String? get segmentNumber => _segmentNumber;
  String? get boundaryDescription => _boundaryDescription;
  String? get listingStartPointDescription => _listingStartPointDescription;
  String? get listingRoute => _listingRoute;
  String? get dateCreated => _dateCreated;
  String? get createdBy => _createdBy;
  String? get dateLastModified => _dateLastModified;
  String? get modifiedBy => _modifiedBy;
  String? get isActive => _isActive;
  String? get isDeleted => _isDeleted;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['segmentId'] = _segmentId;
    map['segmentNumber'] = _segmentNumber;
    map['boundaryDescription'] = _boundaryDescription;
    map['listingStartPointDescription'] = _listingStartPointDescription;
    map['listingRoute'] = _listingRoute;
    map['dateCreated'] = _dateCreated;
    map['createdBy'] = _createdBy;
    map['dateLastModified'] = _dateLastModified;
    map['modifiedBy'] = _modifiedBy;
    map['isActive'] = _isActive;
    map['isDeleted'] = _isDeleted;
    return map;
  }
}