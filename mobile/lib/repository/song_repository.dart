import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/model/song_model.dart';

class SongRepository {
  final String baseUrl = "http://localhost:8000/api/song";

  //rank song by views
  Future<List<Song>> getSongsRank() async {
    final response = await http.get(
      Uri.parse("$baseUrl/rank"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      return songFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load songs!');
    }
  }

  //get newest songs
  Future<List<Song>> getNewestSongs() async {
    final response = await http.get(
      Uri.parse("$baseUrl/newest-songs"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var data = jsonResponse['newest_songs'];
      return List<Song>.from(data.map((item) => Song.fromJsonMap(item)));
    } else {
      print(response.body);
      throw Exception('Failed to load songs!');
    }
  }

  //find song by name
  Future<List<Song>> findSong(String text) async {
    final response = await http.get(
      Uri.parse("$baseUrl/find?name=${text}"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return songFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load songs!');
    }
  }
}
