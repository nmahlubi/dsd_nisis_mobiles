

import 'dart:convert';

import 'package:http_interceptor/http/intercepted_client.dart';

import '../../auth_intercept/authorization_interceptor.dart';
import '../../domain/repository/household/household_repository.dart';
import '../../domain/repository/intake/person_repository.dart';
import '../../model/site/site_dto.dart';
import '../../util/http_client_service.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:http/http.dart' as http;

class SiteService {
  final String apiUrl =
      'https://testportal.dsd.gov.za/msnisis/api/HouseholdProfiling/GetAll';

  Future<List<SiteDto>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('HTTP Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<SiteDto> data = (json.decode(response.body) as List)
            .map((item) => SiteDto.fromJson(item))
            .toList();
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
