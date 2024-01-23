

import 'package:hive/hive.dart';

part 'site_ea_segments.model.g.dart';

@HiveType(typeId: 19)
class SiteEASegmentsModel{
  @HiveField(0)
  int? segmentId;
  @HiveField(1)
  String? segmentNumber;
  @HiveField(2)
  String? boundaryDescription;
  @HiveField(3)
  String? listingStartPointDescription;
  @HiveField(4)
  String? listingRoute;
  @HiveField(5)
  String? dateCreated;
  @HiveField(6)
  String? createdBy;
  @HiveField(7)
  String? dateLastModified;
  @HiveField(8)
  String? modifiedBy;
  @HiveField(9)
  String? isActive;
  @HiveField(10)
  String? isDeleted;

  SiteEASegmentsModel({
    this.modifiedBy,
    this.dateCreated,
    this.isDeleted,
    this.dateLastModified,
    this.isActive,
    this.createdBy,
    this.segmentId,
    this.boundaryDescription,
    this.listingRoute,
    this.listingStartPointDescription,
    this.segmentNumber,
});


}