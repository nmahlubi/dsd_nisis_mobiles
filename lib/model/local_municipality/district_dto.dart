

import '../intake/province_dto.dart';

class DistrictDto{
  DistrictDto({
    int? districtId,
    String? description,
    String? localMunicipalities,
    ProvinceDto? provinceDto,

  }) {
    _districtId = districtId;
    _description = description;
    _localMunicipalities = localMunicipalities;
    _provinceDto = provinceDto;
  }

  DistrictDto.fromJson(dynamic json) {
    _districtId = json['districtId '];
    _description = json['description'];
    _localMunicipalities = json['localMunicipalities'];
    _provinceDto = json['provinceDto'] != null
        ? ProvinceDto.fromJson(json['provinceDto'])
        : null;

  }
  int?  _districtId;
  String?  _description;
  String? _localMunicipalities;
  ProvinceDto? _provinceDto;


  int? get districtId => _districtId;
  String? get description => _description;
  String? get localMunicipalities => _localMunicipalities;
  ProvinceDto? get provinceDto => _provinceDto;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['districtId'] = _districtId;
    map['description'] = _description;
    map['localMunicipalities'] = _localMunicipalities;
    if (_provinceDto != null) {
      map['countryDto'] = _provinceDto?.toJson();
    }

    return map;
  }
}