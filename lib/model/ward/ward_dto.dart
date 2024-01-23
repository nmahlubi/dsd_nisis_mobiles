// import '../local_municipality/local_municipality_dto.dart';
//
// class WardDto{
//   WardDto({
//     int? wardId,
//     String? wardCode,
//     String? wardNumber,
//     String? description,
//     String? dateCreated,
//     String? dateLastModified,
//     String? modifiedBy,
//   String?   createdBy,
//   String? lastModifiedBy,
//   String? isActive,
//   String? isDeleted,
//     LocalMunicipalityDto? localMunicipalityDto,
// }) {
//     _wardId = wardId;
//     _communityName = communityName;
//     _wardCode = wardCode as int?;
//     _wardNumber = wardNumber as int?;
//     _description = description;
//     _dateCreate = dateCreated;
//     _dateLastModified = dateLastModified;
//     _modifiedBy= modifiedBy!;
//     _createdBy = createdBy!;
//     _isActive = isActive!;
//     _isDeleted = isDeleted!;
//     _localMunicipalityDto = localMunicipalityDto;
//
//   }
//
//   WardDto.fromJson(dynamic json) {
//     _wardId = json['wardId '];
//     _communityName = json['communityName'];
//     _wardCode = json['wardCode '];
//     _wardNumber= json['wardNumber'];
//     _description = json['description'];
//     _isActive= json['isActive'];
//     _isDeleted= json['isDeleted'];
//     _dateCreate = json['dateCreated'];
//     _createdBy= json['createdBy'];
//     _dateLastModified = json['dateLastModified '];
//     _modifiedBy= json['modifiedBy'];
//     _localMunicipalityDto = json['localMunicipalityDto'] != null
//         ? LocalMunicipalityDto.fromJson(json['localMunicipalityDto'])
//         : null;
//   }
//   int?  _wardId;
//   int?  _localMunicipalityId;
//   String? _communityName;
//   int?  _wardCode;
//   int?  _wardNumber;
//   String? _description;
//   late  String _isActive;
//   late String _isDeleted;
//   late String?  _dateCreate;
//   late  String _createdBy;
//   late  String? _dateLastModified;
//   late String _modifiedBy;
//   LocalMunicipalityDto? _localMunicipalityDto;
//
//
//   int? get wardId => _wardId;
//   String? get communityName => _communityName;
//   int? get wardCode => _wardCode;
//   int? get wardNumber => _wardNumber;
//   String? get description => _description;
//   String get isActive => _isActive;
//   String get isDeleted => _isDeleted;
//   String get createdBy => _createdBy;
//   String get modifiedBy => _modifiedBy;
//   String? get dateCreated => dateCreated;
//   String? get dateModified => dateModified;
//   LocalMunicipalityDto? get localMunicipalityDto => _localMunicipalityDto;
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['wardId'] = _wardId;
//     map['communityName'] = _communityName;
//     map['wardCode'] = _wardCode;
//     map['wardNumber'] = _wardNumber;
//     map['description'] = _description;
//     map['isActive'] = _isActive;
//     map['isDeleted'] = _isDeleted;
//     map['createdBy'] = _createdBy;
//     map['modifiedBy'] = _modifiedBy;
//     map['dateCreated'] = dateCreated;
//     map['dateModified'] = dateModified;
//     if (_localMunicipalityDto != null) {
//       map['localMunicipalityDto'] = _localMunicipalityDto?.toJson();
//     }
//     return map;
//   }
// }
//
class WardDto {
  final int wardId;
  final int localMunicipalityId;
  final String wardCode;
  final String wardNumber;
  final String description;
  final String dateCreated;
  final String createdBy;
  final String dateLastModified;
  final String lastModifiedBy;
  final bool isActive;
  final bool isDeleted;

  WardDto({
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

  factory WardDto.fromJson(Map<String, dynamic> json) {
    return WardDto(
      wardId: json['wardId'] as int,
      localMunicipalityId: json['localMunicipalityId'] as int,
      wardCode: json['wardCode'] as String,
      wardNumber: json['wardNumber'] as String,
      description: json['description'] as String,
      dateCreated: json['dateCreated'] as String,
      createdBy: json['createdBy'] as String,
      dateLastModified: json['dateLastModified'] as String,
      lastModifiedBy: json['lastModifiedBy'] as String,
      isActive: json['isActive'] as bool,
      isDeleted: json['isDeleted'] as bool,
    );
  }
}

class LocalMunicipalityDto {
  final int localMunicipalityId;
  final int districtId;
  final String localMunicipalityName;
  // ... other properties

  LocalMunicipalityDto({
    required this.localMunicipalityId,
    required this.districtId,
    required this.localMunicipalityName,
    // ... other required properties
  });

  factory LocalMunicipalityDto.fromJson(Map<String, dynamic> json) {
    return LocalMunicipalityDto(
      localMunicipalityId: json['localMunicipalityId'] as int,
      districtId: json['districtId'] as int,
      localMunicipalityName: json['localMunicipalityName'] as String,
      // ... other properties from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localMunicipalityId': localMunicipalityId,
      'districtId': districtId,
      'localMunicipalityName': localMunicipalityName,
      // ... other properties to be converted to JSON
    };
  }
}

