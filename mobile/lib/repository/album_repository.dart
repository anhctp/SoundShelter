import 'package:mobile/model/album_model.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {
  final String baseUrl = "http://localhost:8000/api/album";

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
}