

import 'package:hive/hive.dart';

import '../../../model/site/site_dto.dart';

part 'site_profiling_tools.model.g.dart';

@HiveType(typeId: 10)
class SiteProfilingToolsModel{
  @HiveField(0)
  int? profilingToolId;
  @HiveField(1)
  String? site;
  @HiveField(2)
  SiteDto? siteDto;

  SiteProfilingToolsModel({
    this.profilingToolId,
    this.siteDto,
    this.site
  });
}