

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../db_model_hive/household/household.member.model.dart';

 String householdMemberBox = 'householdMemberBox';
class HouseholdMemberRepository{

  HouseholdMemberRepository._constructor();

  static final HouseholdMemberRepository _instance =
  HouseholdMemberRepository._constructor();

  factory HouseholdMemberRepository() => _instance;

  late Box<MemberData> _memberDataBox = Hive.box<MemberData>('householdMemberBox');

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter<MemberData>(MemberDataAdapter());
    _memberDataBox =
    await Hive.openBox<MemberData>('householdMemberBox');
    // Check if the box is already open and close it if necessary
    if (_memberDataBox != null && _memberDataBox.isOpen) {
      await _memberDataBox.close();
    }
    _memberDataBox = await Hive.openBox<MemberData>('householdMemberBox');
  }

}