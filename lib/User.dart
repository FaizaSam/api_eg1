import 'Address.dart';
import 'Company.dart';

class User {
  int id;
  String name, email, phone, website;
  Address address;
  Company company;
  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.website,
      this.address,
      this.company});
  factory User.fromJSON(Map<String, dynamic> parsedJSON) {
    return User(
        id: parsedJSON['id'],
        name: parsedJSON['name'],
        email: parsedJSON['email'],
        phone: parsedJSON['phone'],
        website: parsedJSON['website'],
        address: Address.fromJSON(parsedJSON['address']),
        company: Company.fromJSON(parsedJSON['company']));
  }
}
