// site_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;


//Get data for the site

class ProvinceService {
Future<List<dynamic>> fetchSites() async {
    var url = 'https://testportal.dsd.gov.za/msnisis/api/Site/userprovinceId/3';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> sites = json.decode(response.body);
      return sites;
    } else {
      throw Exception('Failed to load sites');
    }
  }

  List<dynamic> extractDistricts(List<dynamic> sites) {
    List<dynamic> districts = [];
    for (var site in sites) {
      districts.addAll(site['provinces']['districts']);
    }
    return districts;
  }

List<String> extractLocalMunicipalities(List<dynamic> districts, String selectedDistrictDescription) {
    var selectedDistrict = districts.firstWhere(
      (district) => district['description'] == selectedDistrictDescription,
      orElse: () => null,
    );
    if (selectedDistrict != null) {
      return List<String>.from(selectedDistrict['localMunicipalities'].map((localMunicipality) {
        return localMunicipality['description'].trim() as String; // Explicit casting to String
      }));
    } else {
      return [];
    }
  }

List<String> extractWards(List<dynamic> localMunicipalities, String selectedLocalMunicipalityDescription) {
  for (var district in localMunicipalities) {
    for (var localMunicipality in district['localMunicipalities']) {
      if (localMunicipality['description'].trim() == selectedLocalMunicipalityDescription.trim()) {
        if (localMunicipality.containsKey('ward') && localMunicipality['ward'] != null) {
          var ward = localMunicipality['ward'];
          var wardNumber = ward['wardNumber']; // Keep wardNumber as an integer
          if (wardNumber is int) { 
            var wardNumberStr = wardNumber.toString(); // Convert wardNumber to String
            return [wardNumberStr]; // Return as a list of String
          }
        }
      }
    }
  }
  return []; // Return an empty list if no match is found
}




}

// Search for sites
class SiteService {
  Future<http.Response> searchSite({
    required String municipality,
    required String localMunicipality,
    required String ward,
    required String siteName,
    required String startDate,
    required String endDate,
  }) async {
    final Uri apiUri = Uri.parse('https://testportal.dsd.gov.za/msnisis/api/Site/provinceId/3?sitename=test&wardnumber=1198&Municipality=City%20of%20Johannesburg&localmunicipality=City%20of%20Johannesburg&selectonly_myrecords=true');
    final response = await http.post(
      apiUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'municipality': municipality,
        'localMunicipality': localMunicipality,
        'ward': ward,
        'siteName': siteName,
        'startDate': startDate,
        'endDate': endDate,
      }),
    );

    return response;
  }
}
