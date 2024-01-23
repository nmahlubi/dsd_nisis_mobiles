import 'dart:convert';

import 'package:http/http.dart' as http;

class Coordinates{
  String displayedCoordinates = '';

  Future<void> getWeatherCoordinates() async {
    final apiKey = '0cebbf25b4c56494893333e85f2f9f39';
    final city = 'Johannesburg';

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=imperial&appid=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final double latitude = data['coord']['lat'];
      final double longitude = data['coord']['lon'];

    //   setState(() {
    //     displayedCoordinates =
    //     'Latitude: ${latitude.toStringAsFixed(4)}, Longitude: ${longitude.toStringAsFixed(4)}';
    //   });
    // } else {
    //   setState(() {
    //     displayedCoordinates = 'Failed to fetch coordinates';
    //   });
    // }

  }}
}