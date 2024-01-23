
import 'package:hive/hive.dart';
import '../../../model/site/site_dto.dart';
part 'site_groupingflags.model.g.dart';

@HiveType(typeId: 10)
class SiteGroupingFlagsModel{
  @HiveField(0)
  int? groupingFlagId;
  @HiveField(1)
  String? site;
  @HiveField(2)
  SiteDto? siteDto;

  SiteGroupingFlagsModel({
    this.groupingFlagId,
    this.siteDto,
    this.site
});
}