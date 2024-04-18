import 'dart:convert';

class Playlist {
  int id;
  String code;
  String name;
  String imageFilePath;
  int? userId;
  Playlist(
      {this.id = 0,
      required this.code,
      required this.name,
      required this.imageFilePath,
      required this.userId});
  factory Playlist.fromJson(String jsonData) {
    Map<String, dynamic> map = json.decode(jsonData);
    return Playlist(
        id: map["id"],
        code: map["code"],
        name: map["name"],
        imageFilePath: map["image_file_path"],
        userId: map["user_id"]);
  }
  factory Playlist.fromJsonMap(Map<String, dynamic> map) {
    return Playlist(
        id: map["id"],
        code: map["code"],
        name: map["name"],
        imageFilePath: map["image_file_path"],
        userId: map["user_id"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "name": name,
      "image_file_path": imageFilePath,
      "user_id": userId,
    };
  }
}

List<Playlist> playlistFromJson(List<int> jsonData) {
  final data = json.decode(utf8.decode(jsonData));
  return List<Playlist>.from(data.map((item) => Playlist.fromJsonMap(item)));
}

String playlistToJson(Playlist data) {
  return json.encode(data.toJson());
}
