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
  String? albumsTitle;
  bool? isUploaded;

  Song(
      {this.id,
      this.albumId,
      this.playlistId,
      this.isUploaded,
      required this.title,
      required this.artist,
      required this.audioFilePath,
      required this.imageFilePath,
      required this.releaseDate,
      this.view,
      this.albumsTitle});

  factory Song.fromJsonMap(Map<String, dynamic> map) {
    return Song(
        id: map["id"],
        albumId: map["album_id"],
        playlistId: map["playlist_id"],
        isUploaded: map["is_uploaded"],
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

Song songFromJsonString(String jsonData) {
  final data = json.decode(jsonData);
  return Song(
      id: data["id"],
      albumId: data["album_id"],
      playlistId: data["playlist_id"],
      isUploaded: data["is_uploaded"],
      title: data["title"],
      artist: data["artist"],
      audioFilePath: data["audio_file_path"],
      imageFilePath: data["image_file_path"],
      releaseDate: data["release_date"],
      view: data["view"],
      albumsTitle: data["albums_title"]);
}
