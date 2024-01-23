

import 'package:dsd_nisis_mobile/model/site/site_dto.dart';

class SiteProfilingMethodDto{
  SiteProfilingMethodDto({
    int? profilingMethodId,
    String? site,
    SiteDto? siteDto,

  }) {
    _profilingMethodId = profilingMethodId;
    _site = site;
    _siteDto = siteDto;
  }

  SiteProfilingMethodDto.fromJson(dynamic json) {
    _profilingMethodId = json['profilingMethodId '];
    _site = json['site'];
    _siteDto = json['siteDto'] != null
        ? SiteDto.fromJson(json['siteDto'])
        : null;
  }
  int?  _profilingMethodId;
  String?  _site;
  SiteDto? _siteDto;


  int? get profilingMethodId => _profilingMethodId;
  String? get site => _site;
  SiteDto? get siteDto => _siteDto;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profilingMethodId'] = _profilingMethodId;
    map['site'] = _site;
    if (_siteDto != null) {
      map['_siteDto'] = _siteDto;
    }
    return map;
  }
}