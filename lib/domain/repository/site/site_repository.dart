
import 'dart:convert';

import '../../../model/site/site_dto.dart';
import 'package:http/http.dart' as http;

class SiteRepository {
  static const String apiUrl = 'https://example.com/api/relative-members';

  Future<List<SiteDto>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => SiteDto.fromJson(item)).toList();
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