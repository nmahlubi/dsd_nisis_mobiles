

import 'package:dsd_nisis_mobile/model/site/site_dto.dart';

class SiteProfilingToolsDto{
  SiteProfilingToolsDto({
    int? profilingToolId,
    String? site,
    SiteDto? siteDto,

  }) {
    _profilingToolId = profilingToolId;
    _site = site;
    _siteDto = siteDto;
  }

  SiteProfilingToolsDto.fromJson(dynamic json) {
    _profilingToolId = json['profilingToolId '];
    _site = json['site'];
    _siteDto = json['siteDto'] != null
        ? SiteDto.fromJson(json['siteDto'])
        : null;
  }
  int?  _profilingToolId;
  String?  _site;
  SiteDto? _siteDto;


  int? get profilingToolId => _profilingToolId;
  String? get site => _site;
  SiteDto? get siteDto => _siteDto;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profilingToolId'] = _profilingToolId;
    map['site'] = _site;
    if (_siteDto != null) {
      map['_siteDto'] = _siteDto;
    }
    return map;
  }
}