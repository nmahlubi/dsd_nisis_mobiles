

import 'package:hive/hive.dart';

part 'country.model.g.dart';

@HiveType(typeId: 40)
class CountryModel {
  @HiveField(0)
  int? countryId;
  @HiveField(1)
  String? countryName;
  @HiveField(2)
  String? countryCode;

  CountryModel(
      {this.countryId,
        this.countryName,
        this.countryCode,});
}