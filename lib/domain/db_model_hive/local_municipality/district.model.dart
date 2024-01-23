
import 'package:hive/hive.dart';

import '../../../model/intake/province_dto.dart';



part 'district.model.g.dart';

@HiveType(typeId: 36)
class DistrictModel{
  @HiveField(0)
  int? districtId;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? localMunicipalities;
  @HiveField(3)
  ProvinceDto? provinceDto;

  DistrictModel({
    this.districtId,
    this.description,
    this.provinceDto,
    this.localMunicipalities
});
}