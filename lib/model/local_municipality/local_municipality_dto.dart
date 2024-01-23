

class LocalMunicipalityDto{
  LocalMunicipalityDto({
    int? local_Municipality_Id,
    int? districtMunicipalityId,
    String? description,

  }) {
    _localMunicipalityId = localMunicipalityId;
    _districtMunicipalityId = districtMunicipalityId;
    _description = description;
  }

  LocalMunicipalityDto.fromJson(dynamic json) {
    _localMunicipalityId = json['localMunicipalityId '];
    _districtMunicipalityId = json['districtMunicipalityId'];
    _description = json['description'];

  }
  int?  _localMunicipalityId;
  int?  _districtMunicipalityId;
  String? _description;


  int? get localMunicipalityId => _localMunicipalityId;
  int? get districtMunicipalityId => _districtMunicipalityId;
  String? get description => _description;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['localMunicipalityId'] = _localMunicipalityId;
    map['districtMunicipalityId'] = _districtMunicipalityId;
    map['description'] = _description;

    return map;
  }
}