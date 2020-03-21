import 'location_model.dart';

class ApiModel {
  final String countryRegion;
  final String lastUpdate;
  final LocationModel location;
  final int confirmed;
  final int deaths;
  final int recovered;

  ApiModel({
    this.countryRegion,
    this.lastUpdate,
    this.location,
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      countryRegion: json['countryregion'],
      lastUpdate: json['lastupdate'],
      location: new LocationModel(
        lat: json['location']['lat'].toDouble(),
        long: json['location']['lng'].toDouble(),
      ),
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }

  static List<ApiModel> fromJSONList(List<dynamic> jsonList) {
    List<ApiModel> list = [];
    jsonList.forEach((dynamic json) {
      list.add(ApiModel.fromJson(json));
    });
    return list;
  }
}
