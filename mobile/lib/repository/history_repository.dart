import 'dart:convert';

import 'package:mobile/model/history_model.dart';
import 'package:mobile/model/song_model.dart';
import 'package:http/http.dart' as http;

class HistoryRepository {
  final String baseUrl = "http://localhost:8000/api/history";

  //create heard song
  Future<dynamic> createHistory(History newHistory) async {
    final response = await http.post(Uri.parse("$baseUrl/create-heard-song"),
        headers: {'Content-Type': 'application/json'},
        body: historyToJson(newHistory));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create history!');
    }
  }

  //get recently heard songs by user
  Future<List<Song>> getHistory(int userId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/recently-heard-songs/$userId"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode == 200) {
      return songFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load songs!');
    }
  }
}
