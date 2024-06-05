import 'dart:convert';
import 'dart:io';

import 'package:mobile/model/favorite_model.dart';
import 'package:mobile/model/song_model.dart';
import 'package:http/http.dart' as http;

class FavoriteRepository {
  final String baseUrl = "http://localhost:8000/api";

  //create favorite song
  Future<dynamic> createFavorite(Favorite newFavorite) async {
    final response = await http.post(Uri.parse("$baseUrl/add"),
        headers: {'Content-Type': 'application/json'},
        body: favoriteToJson(newFavorite));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create favorite!');
    }
  }

  //get all favorites by user id
  Future<List<Song>> getFavorite(String token) async {
    final response = await http.get(Uri.parse("$baseUrl/all"), headers: {
      'Accept': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    if (response.statusCode == 200) {
      print(response.body);
      return songFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load songs!');
    }
  }

  //delete favorite
  Future<dynamic> deleteFavorite(int songId, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/delete/$songId"),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete favorite!');
    }
  }
}
