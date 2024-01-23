import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/household/household_details_dto.dart';
import '../../db_model_hive/household/household.details.model.dart';
import 'package:http/http.dart' as http;


const String householdDetailsBox = 'householdDetailsBox';

class HouseholdDetailsRepository {
  HouseholdDetailsRepository._constructor();

  static final HouseholdDetailsRepository _instance =
  HouseholdDetailsRepository._constructor();

  factory HouseholdDetailsRepository() => _instance;

  late Box<HouseholdDetailsModel> _householdDetailsModelBox = Hive.box<HouseholdDetailsModel>('householdDetailsBox');

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter<HouseholdDetailsModel>(HouseholdDetailsModelAdapter());
    _householdDetailsModelBox =
    await Hive.openBox<HouseholdDetailsModel>('householdDetailsBox');
    // Check if the box is already open and close it if necessary
    if (_householdDetailsModelBox != null && _householdDetailsModelBox.isOpen) {
      await _householdDetailsModelBox.close();
    }
    _householdDetailsModelBox = await Hive.openBox<HouseholdDetailsModel>('householdDetailsBox');
  }


  Future<void> saveHouseholdDetail(
      HouseHoldDetailsDto houseHoldDetailsDto) async {
    await initialize();
    await _householdDetailsModelBox.put(
      houseHoldDetailsDto.profilingInstanceId,
      HouseholdDetailsModel(
        provinceId: houseHoldDetailsDto.profilingInstanceId,
        profilingDate: houseHoldDetailsDto.profilingDate,
        modifiedBy: houseHoldDetailsDto.modifiedBy,
        dateLastModified: houseHoldDetailsDto.dateModified,
        dateCreated: houseHoldDetailsDto.dateCreated,
        isDeleted: houseHoldDetailsDto.isDeleted,
        isActive: houseHoldDetailsDto.isActive,
        qAStatusItemId: houseHoldDetailsDto.qAStatusItemId,
        dwellingUnitDescription: houseHoldDetailsDto.dwellingUnitDescription,
        profilingToolId: houseHoldDetailsDto.profilingToolId,
        householdNumberOfMales: houseHoldDetailsDto.householdNumberOfMales,
        householdNumberOfFemales: houseHoldDetailsDto.householdNumberOfMales,
        householdNumber: houseHoldDetailsDto.householdNumber,
        nISISSiteEAId: houseHoldDetailsDto.NISISSiteEAId,
        hHID: houseHoldDetailsDto.HHID,
        capturedByUserId: houseHoldDetailsDto.capturedByUserId,
        profilingDateCaptured: houseHoldDetailsDto.profilingDate, HouseholdModel: houseHoldDetailsDto.houseHoldDto,
      ),
    );
  }

  HouseHoldDetailsDto householdDetailFromDb(
      HouseholdDetailsModel householdDetailsModel) {
    return HouseHoldDetailsDto(
      profilingInstanceId: householdDetailsModel.profilingInstanceId,
    );
  }

  HouseHoldDetailsDto? getHouseholdDetailsById(int id) {
    final householdDetailDb = _householdDetailsModelBox.get(id);
    if (householdDetailDb != null) {
      return householdDetailFromDb(householdDetailDb);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> displayStoredData() async {
    if (_householdDetailsModelBox == null || !_householdDetailsModelBox.isOpen) {
      // Handle the case where the box is not open
      return [];
    }

    final records = _householdDetailsModelBox.values.toList();
    final dataList = records.map((record) => record as Map<String, dynamic>).toList();
    return dataList;
  }
  Future<void> closeBox() async {
    if (_householdDetailsModelBox != null && _householdDetailsModelBox.isOpen) {
      await _householdDetailsModelBox.close();
    }
  }
}
