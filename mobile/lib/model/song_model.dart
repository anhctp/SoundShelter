import 'dart:convert';

class Song {
  int? id;
  int? albumId;
  int? playlistId;
  String title;
  String artist;
  String audioFilePath;
  String imageFilePath;
  String releaseDate;
  int? view;
  String albumsTitle;

  Song(
      {this.id,
      this.albumId,
      this.playlistId,
      required this.title,
      required this.artist,
      required this.audioFilePath,
      required this.imageFilePath,
      required this.releaseDate,
      this.view,
      required this.albumsTitle});

  factory Song.fromJsonMap(Map<String, dynamic> map) {
    return Song(
        id: map["id"],
        albumId: map["album_id"],
        playlistId: map["playlist_id"],
        title: map["title"],
        artist: map["artist"],
        audioFilePath: map["audio_file_path"],
        imageFilePath: map["image_file_path"],
        releaseDate: map["release_date"],
        view: map["view"],
        albumsTitle: map["albums_title"]);
  }
}

List<Song> songFromJson(List<int> jsonData) {
  final data = json.decode(utf8.decode(jsonData));
  return List<Song>.from(data.map((item) => Song.fromJsonMap(item)));
}
