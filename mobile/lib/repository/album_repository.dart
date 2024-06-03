import 'package:mobile/model/album_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/song_model.dart';

class AlbumRepository {
  final String baseUrl = "http://localhost:8000/api/album";

  //get list album by genre
  Future<List<Album>> getAlbumsByGenre(int genreId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/album-by-genre/$genreId"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return albumFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load albums!');
    }
  }

  // get songs by album id
  Future<List<Song>> getSongsByAlbum(int? albumId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$albumId/songs"),
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
