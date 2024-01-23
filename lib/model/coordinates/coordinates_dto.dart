
class Weather {
  var stationID;
  var obsTimeUtc;
  var obsTimeLocal;
  String neighborhood;
  var softwareType;
  var country;
//  Null solarRadiation;
  double lon;
//  Null realtimeFrequency;
  var epoch;
  var lat;
  // Null uv;
  var winddir;
  var humidity;
  var qcStatus;
  var temp;
  // Imperial imperial;

  Weather(
      {this.stationID,
        this.obsTimeUtc,
        this.obsTimeLocal,
        required this.neighborhood,
        this.softwareType,
        this.country,
        //  this.solarRadiation,
        required this.lon,
        //  this.realtimeFrequency,
        this.epoch,
        this.lat,
        //  this.uv,
        this.winddir,
        this.humidity,
        this.qcStatus,
        this.temp
        //   this.imperial
      });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      stationID: json['stationID'] ?? "",
      // obsTimeUtc = json['observations']['obsTimeUtc'] ?? "";
      // obsTimeLocal = json['observations']['obsTimeLocal'] ?? "";
      neighborhood: json['neighborhood'] as String ?? "",
      softwareType: json['softwareType'] ?? "",
      country: json['country'] ?? "",
      // solarRadiation = json['solarRadiation'];
      lon: json['lon'] as double ?? 0.0,
      temp: json['imperial']['temp'],
      //  realtimeFrequency = json['realtimeFrequency'];
      epoch: json['epoch'] ?? "",
      lat: json['lat'] ?? "",
      //  uv = json['uv'];
      // winddir = json['observations']['winddir'] ?? "";
      // humidity = json['observations']['humidity'] ?? "";
      // qcStatus = json['observations']['qcStatus'] ?? "";
      // imperial = json['imperial'] != null
      //     ? new Imperial.fromJson(
      //         json['imperial'],
      //       )
      //     : null;
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationID'] = this.stationID;
    data['obsTimeUtc'] = this.obsTimeUtc;
    data['obsTimeLocal'] = this.obsTimeLocal;
    data['neighborhood'] = this.neighborhood;
    data['softwareType'] = this.softwareType;
    data['country'] = this.country;
    // data['solarRadiation'] = this.solarRadiation;
    data['lon'] = this.lon;
    //   data['realtimeFrequency'] = this.realtimeFrequency;
    data['epoch'] = this.epoch;
    data['lat'] = this.lat;
    // data['uv'] = this.uv;
    data['winddir'] = this.winddir;
    data['humidity'] = this.humidity;
    data['qcStatus'] = this.qcStatus;
    // if (this.imperial != null) {
    //   data['imperial'] = this.imperial.toJson();
    // }
    return data;
  }
}