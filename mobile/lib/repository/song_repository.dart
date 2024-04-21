import 'package:http/http.dart' as http;
import 'package:mobile/model/song_model.dart';

class SongRepository {
  final String baseUrl = "http://localhost:8000/api/song";

  Future<List<Song>> getSongsRank() async {
    final response = await http.get(
      Uri.parse("$baseUrl/rank"),
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

