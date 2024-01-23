

import 'package:hive/hive.dart';

import '../../../model/site/site_dto.dart';

part 'site_ea_model.g.dart';

@HiveType(typeId: 51)
class SiteEAModel{
  @HiveField(0)
  String? eaCode;
  @HiveField(1)
  String? communityName;
  @HiveField(2)
  String? isActive;
  @HiveField(3)
  String? isDeleted;
  @HiveField(4)
  DateTime? dateCreated;
  @HiveField(5)
  String? createdBy;
  @HiveField(6)
  String? dateLastModified;
  @HiveField(7)
  String? modifiedBy;
  @HiveField(8)
  SiteDto? siteDto;

  SiteEAModel({
    this.createdBy,
    this.isActive,
    this.dateLastModified,
    this.isDeleted,
    this.dateCreated,
    this.modifiedBy,
    this.communityName,
    this.eaCode,
    this.siteDto,
});
}