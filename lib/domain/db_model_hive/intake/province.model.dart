

import 'package:hive/hive.dart';

import '../../../model/intake/country_dto.dart';


part 'province.model.g.dart';

@HiveType(typeId: 35)
class ProvinceModel{
  @HiveField(0)
  int? provinceId;
  @HiveField(1)
  int? countryId;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? abbreviation;
  @HiveField(4)
  CountryDto? countryDto;

  ProvinceModel({
    this.countryId,
    this.provinceId,
    this.description,
    this.abbreviation,
    this.countryDto,
});
}