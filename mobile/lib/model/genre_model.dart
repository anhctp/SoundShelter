import 'dart:convert';

class Genre {
  int id;
  String code;
  String name;

  Genre({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Genre.fromJsonMap(Map<String, dynamic> map) {
    return Genre(id: map["id"], code: map["code"], name: map["name"]);
  }
}

List<Genre> genreFromJson(List<int> jsonData) {
  final data = json.decode(utf8.decode(jsonData));
  return List<Genre>.from(data.map((item) => Genre.fromJsonMap(item)));
}

Genre genreByIdFromJson(List<int> jsonData) {
  final data = json.decode(utf8.decode(jsonData));
  return Genre.fromJsonMap(data);
}
