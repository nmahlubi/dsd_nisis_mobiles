// Place this in a file named site_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/intake/site_listing.dart';


class SiteService {
  final SharedPreferences preferences;

  SiteService({required this.preferences});

  Future<List<Site>> fetchSites() async {
    final String username = preferences.getString('username') ?? 'cswarts';
    final String apiUrl = 'https://testportal.dsd.gov.za/msnisis/api/Site/username/$username';
    final String sitesKey = 'sites_data';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        await preferences.setString(sitesKey, response.body);
        List<dynamic> siteList = json.decode(response.body);
        return siteList.map((data) => Site.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load sites');
      }
    } catch (e) {
      var storedData = preferences.getString(sitesKey);
      if (storedData != null) {
        List<dynamic> siteList = json.decode(storedData);
        return siteList.map((data) => Site.fromJson(data)).toList();
      } else {
        throw Exception('No data found');
      }
    }
  }
}
