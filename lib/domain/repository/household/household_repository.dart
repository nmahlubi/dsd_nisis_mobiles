import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../model/household/house_dto.dart';
import '../../../model/household/household_details_dto.dart';
import '../../db_model_hive/household/household.details.model.dart';
import '../../db_model_hive/household/household.model.dart';

const String householdBox = 'householdBox';

class HouseholdRepository{
  HouseholdRepository._constructor();

  static final HouseholdRepository _instance = HouseholdRepository._constructor();

  factory HouseholdRepository() => _instance;

  late Box<HouseholdModel> _householdModelBox;
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter<HouseholdModel>(
        HouseholdModelAdapter());
    _householdModelBox =
    await Hive.openBox<HouseholdModel>(householdBox);
  }

  HouseholdModel householdToDb(
      HouseHoldDto? houseHoldDto) =>
      HouseholdModel(
        profilingInstanceId: houseHoldDto?.profilingInstanceId,
        profilingDateCaptured: houseHoldDto?.profilingDate,
        profilingToolId: houseHoldDto?.profilingToolId,
        profilingMethodId: houseHoldDto?.profilingMethodId,
        capturedByUserId: houseHoldDto?.capturedByUserId,
        hHID: houseHoldDto?.HHID,
        nISISSiteEAId: houseHoldDto?.NISISSiteEAId,
        householdNumber: houseHoldDto?.householdNumber,
        householdNumberOfFemales: houseHoldDto?.householdNumberOfMales,
        householdNumberOfMales: houseHoldDto?.householdNumberOfMales,
        dwellingUnitDescription: houseHoldDto?.dwellingUnitDescription,
        qAStatusItemId: houseHoldDto?.qAStatusItemId,
        isActive: houseHoldDto?.isDeleted,
         isDeleted: houseHoldDto?.isDeleted,
        dateCreated: houseHoldDto?.dateCreated,
          dateLastModified: houseHoldDto?.dateModified,
        modifiedBy: houseHoldDto?.modifiedBy,
        profilingDate: houseHoldDto?.profilingDate,
        provinceId: houseHoldDto?.capturedByUserId,
        //personId: houseHoldDto?.personId
      );

  HouseholdModel householdFromDb(
      HouseHoldDto? houseHoldDto) =>
      HouseholdModel(
          profilingInstanceId: houseHoldDto?.profilingInstanceId,
          profilingDateCaptured: houseHoldDto?.profilingDate,
          profilingToolId: houseHoldDto?.profilingToolId,
          profilingMethodId: houseHoldDto?.profilingMethodId,
          capturedByUserId: houseHoldDto?.capturedByUserId,
          hHID: houseHoldDto?.HHID,
          nISISSiteEAId: houseHoldDto?.NISISSiteEAId,
          householdNumber: houseHoldDto?.householdNumber,
          householdNumberOfFemales: houseHoldDto?.householdNumberOfMales,
          householdNumberOfMales: houseHoldDto?.householdNumberOfMales,
          dwellingUnitDescription: houseHoldDto?.dwellingUnitDescription,
          qAStatusItemId: houseHoldDto?.qAStatusItemId,
          isActive: houseHoldDto?.isDeleted,
          isDeleted: houseHoldDto?.isDeleted,
          dateCreated: houseHoldDto?.dateCreated,
          dateLastModified: houseHoldDto?.dateModified,
          modifiedBy: houseHoldDto?.modifiedBy,
          profilingDate: houseHoldDto?.profilingDate,
          provinceId: houseHoldDto?.capturedByUserId,
        //personId: capturedByUserId?.personId
      );



  Future<void> saveHousehold(HouseHoldDto houseHoldDto, int? profilingInstanceId) async {
    await _householdModelBox.put(
        houseHoldDto.profilingInstanceId,
        HouseholdModel(
            profilingInstanceId: houseHoldDto.profilingInstanceId,
            profilingDateCaptured: houseHoldDto.profilingDate,
            profilingToolId: houseHoldDto.profilingToolId,
            profilingMethodId: houseHoldDto.profilingMethodId,
            capturedByUserId: houseHoldDto.capturedByUserId,
            hHID: houseHoldDto.HHID,
            nISISSiteEAId: houseHoldDto.NISISSiteEAId,
            householdNumber: houseHoldDto.householdNumber,
            householdNumberOfFemales: houseHoldDto.householdNumberOfMales,
            householdNumberOfMales: houseHoldDto.householdNumberOfMales,
            dwellingUnitDescription: houseHoldDto.dwellingUnitDescription,
            qAStatusItemId: houseHoldDto.qAStatusItemId,
            isActive: houseHoldDto.isDeleted,
            isDeleted: houseHoldDto.isDeleted,
            dateCreated: houseHoldDto.dateCreated,
            dateLastModified: houseHoldDto.dateModified,
            modifiedBy: houseHoldDto.modifiedBy,
            profilingDate: houseHoldDto.profilingDate,
            provinceId: houseHoldDto.capturedByUserId,
          //personId: capturedByUserId?.personId
        ));
  }


  HouseholdModel? getProfilingInstanceById(int id) {
    final bookDb = _householdModelBox.get(id);
    if (bookDb != null) {
      return householdFromDb(bookDb as HouseHoldDto?);
    }
    return null;
  }



}

