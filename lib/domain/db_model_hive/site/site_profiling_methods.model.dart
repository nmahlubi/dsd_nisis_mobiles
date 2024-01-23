

import 'package:hive/hive.dart';

import '../../../model/site/site_dto.dart';
part 'site_profiling_methods.model.g.dart';

@HiveType(typeId: 10)
class SiteProfilingMethodsModel{
  @HiveField(0)
  int? profilingMethodId;
  @HiveField(1)
  String? site;
  @HiveField(2)
  SiteDto? siteDto;

  SiteProfilingMethodsModel({
    this.profilingMethodId,
    this.siteDto,
    this.site
  });
}