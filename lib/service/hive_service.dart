import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../domain/db_model_hive/household/household.details.model.dart';
import '../model/household/household_details_dto.dart';

class HiveService {
  Future<void> initializeHive() async {
    await Hive.initFlutter();
    // Register adapters for your model classes
    Hive.registerAdapter<HouseholdDetailsModel>(HouseholdDetailsModelAdapter());
    // Open your Hive boxes here
    // ...
  }

  Future<void> saveToHive(HouseHoldDetailsDto data) async {
    final box = await Hive.openBox<HouseHoldDetailsDto>('household_details');
    await box.put(data.profilingInstanceId, data);
  }

  Future<HouseHoldDetailsDto?> getFromHive(int id) async {
    final box = await Hive.openBox<HouseHoldDetailsDto>('household_details');
    return box.get(id);
  }
}
