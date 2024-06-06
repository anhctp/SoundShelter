import 'package:mobile/model/genre_model.dart';
import 'package:http/http.dart' as http;

class GenreRepository {
  final String baseUrl = "http://localhost:8000/api/genre";

  Future<List<Genre>> getAllGenre() async {
    final response = await http.get(
      Uri.parse("$baseUrl/all"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      return genreFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load genres!');
    }
  }

  Future<Genre> getGenreById(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$id"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      return genreByIdFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load genres!');
    }
  }
}
