import 'dart:convert';

class Album {
  String title;
  String code;
  String imageFilePath;
  String releaseDate;
  String artist;
  int genreId;

  Album({
    required this.title,
    required this.code,
    required this.imageFilePath,
    required this.releaseDate,
    required this.artist, 
    required this.genreId,
  });

  factory Album.fromJsonMap(Map<String, dynamic> map) {
    return Album(
      title: map["title"],
      code: map["code"],
      imageFilePath: map["image_file_path"],
      releaseDate: map["release_date"],
      artist: map["artist"],
      genreId: map["genre_id"]
    );
  }
}

List<Album> albumFromJson(List<int> jsonData) {
  final data = json.decode(utf8.decode(jsonData));
  return List<Album>.from(data.map((item) => Album.fromJsonMap(item)));
}