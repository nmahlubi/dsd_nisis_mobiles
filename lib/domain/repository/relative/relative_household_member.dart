

//
// class RelativeMemberRepository {
//   late final RelativeMemberService _apiService;
//   final String _boxName = 'relativeMembers'; // Hive box name
//
//
//
//
//
//
//   // Future<List<RelativeMember>> getAllRelativeMembers() async {
//   //   // Try fetching from local Hive box
//   //   final localData = await _getLocalData();
//   //
//   //   if (localData.isNotEmpty) {
//   //     return localData;
//   //   } else {
//   //     final apiData = await _apiService.getAllRelativeMembers();
//   //     await _saveToLocal(apiData);
//   //
//   //     return apiData;
//   //   }
//   // }
//
//   Future<List<RelativeMember>> _getLocalData() async {
//     final box = await Hive.openBox<RelativeMember>(_boxName);
//     return box.values.toList();
//   }
//
//   Future<void> _saveToLocal(List<RelativeMember> data) async {
//     final box = await Hive.openBox<RelativeMember>(_boxName);
//     await box.clear();
//     await box.addAll(data);
//   }
// }
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../../model/realtive/relative_dto.dart';

class RelativeMemberRepository {
  // Replace the URL with the actual endpoint for your API
  static const String apiUrl = 'https://example.com/api/relative-members';

  Future<List<RelativeMemberDto>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {

        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => RelativeMemberDto.fromJson(item)).toList();

      } else {
        // Handle errors, maybe throw an exception or return an empty list
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle network errors
      throw Exception('Failed to connect to the server');
    }
  }
}