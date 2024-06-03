import 'package:mobile/model/song_model.dart';
import 'package:http/http.dart' as http;

class RecommendRepository {
  final String baseUrl =
      "http://localhost:8000/api/recommend/get_recommendation";

  //get recommendation
  Future<List<Song>> getRecommendation(int? userId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$userId"),
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
