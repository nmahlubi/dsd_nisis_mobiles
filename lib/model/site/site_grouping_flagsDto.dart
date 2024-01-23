
import 'package:dsd_nisis_mobile/model/site/site_dto.dart';

class SiteGroupingFlagsDto{
  SiteGroupingFlagsDto({
    int? groupingFlagId,
    String? site,
    SiteDto? siteDto,

  }) {
    _groupingFlagId = groupingFlagId;
    _site = site;
    _siteDto = siteDto;
  }

  SiteGroupingFlagsDto.fromJson(dynamic json) {
    _groupingFlagId = json['groupingFlagId '];
    _site = json['site'];
    _siteDto = json['siteDto'] != null
        ? SiteDto.fromJson(json['siteDto'])
        : null;
  }
  int?  _groupingFlagId;
  String?  _site;
  SiteDto? _siteDto;


  int? get groupingFlagId => _groupingFlagId;
  String? get site => _site;
  SiteDto? get siteDto => _siteDto;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['groupingFlagId'] = _groupingFlagId;
    map['site'] = _site;
    if (_siteDto != null) {
      map['_siteDto'] = _siteDto;
    }
    return map;
  }
}