import 'dart:core';
import 'package:hive/hive.dart';

part 'household.model.g.dart';

@HiveType(typeId: 20)
class HouseholdModel extends HiveObject{
  @HiveField(0)
  late final int?  profilingInstanceId;
  @HiveField(1)
  late final String? profilingDate;
  @HiveField(2)
  late final int? profilingToolId;
  @HiveField(3)
  late final int? profilingMethodId;
  @HiveField(4)
  late final int? capturedByUserId;
  @HiveField(5)
  late final int? hHID;
  @HiveField(6)
  late final int? nISISSiteEAId;
  @HiveField(7)
  late final int? householdNumber;
  @HiveField(8)
  late final int? householdNumberOfMales;
  @HiveField(9)
  late final int? householdNumberOfFemales;
  @HiveField(10)
  late final String? dwellingUnitDescription;
  @HiveField(11)
  int? qAStatusItemId;
  @HiveField(12)
  late final String? isActive;
  @HiveField(13)
  late final String? isDeleted;
  @HiveField(14)
  late final String? dateCreated;
  @HiveField(15)
  late final String? dateLastModified;
  @HiveField(16)
  late final String? modifiedBy;
  @HiveField(17)
  late final int? provinceId;
  @HiveField(18)
  late final String? profilingDateCaptured;
  HouseholdModel(
      {
        this.profilingInstanceId,
        this.profilingDate,
        this.profilingToolId,
        this.profilingMethodId,
        this.capturedByUserId,
        this.hHID,
        this.modifiedBy,
        this.nISISSiteEAId,
        this.householdNumber,
        this.householdNumberOfMales,
        this.householdNumberOfFemales,
        this.dwellingUnitDescription,
        this.qAStatusItemId,
        this.isActive,
        this.isDeleted,
        this.dateCreated,
        this.dateLastModified,
        this.provinceId,
        this.profilingDateCaptured,
      });
}


