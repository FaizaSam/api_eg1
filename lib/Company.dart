class Company {
  String name, catchPhrase, bs;
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });
  factory Company.fromJSON(Map<String, dynamic> parsedJSON) {
    return Company(
        name: parsedJSON['name'],
        catchPhrase: parsedJSON['catchPhrase'],
        bs: parsedJSON['bs']);
  }
}
