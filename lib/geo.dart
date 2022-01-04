class Geo {
  String lat, lng;
  Geo({this.lat, this.lng});
  factory Geo.fromJSON(Map<String, dynamic> parsedJSON) {
    return Geo(
      lat: parsedJSON['lat'],
      lng: parsedJSON['lng'],
    );
  }
}
