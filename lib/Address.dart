import 'geo.dart';

class Address {
  String street, suite, city, zipcode;
  Geo geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  factory Address.fromJSON(Map<String, dynamic> parsedJson) {
    return Address(
        street: parsedJson['street'],
        suite: parsedJson['suite'],
        city: parsedJson['city'],
        zipcode: parsedJson['zipcode'],
        geo: Geo.fromJSON(parsedJson['geo']));
  }
}
