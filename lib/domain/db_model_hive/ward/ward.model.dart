
import 'package:hive/hive.dart';
import '../../../model/local_municipality/local_municipality_dto.dart';
part 'ward.model.g.dart';

@HiveType(typeId: 61)
class WardModel{
  @HiveField(0)
  int? wardId;
  @HiveField(1)
  String? wardCode;
  @HiveField(2)
  String? wardNumber;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? dateCreated;
  @HiveField(5)
  String? dateLastModified;
  @HiveField(6)
  String? modifiedBy;
  @HiveField(7)
  String? createdBy;
  @HiveField(8)
  String? lastModifiedBy;
  @HiveField(9)
  String? isActive;
  @HiveField(10)
  String? isDeleted;
  @HiveField(11)
  //LocalMunicipalityDto? localMunicipalityDto;

  WardModel({
   this.createdBy,
    this.isActive,
    this.dateLastModified,
    this.isDeleted,
    this.dateCreated,
    this.modifiedBy,
    this.description,
    this.wardId,
    this.lastModifiedBy,
    //this.localMunicipalityDto,
    this.wardCode,
    this.wardNumber,
  });
}