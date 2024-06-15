import 'dart:io';
import 'package:mobile/model/song_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/upload_song_model.dart';

class UploadRepository {
  final String baseUrl = "http://localhost:8000/api";

  Future<dynamic> uploadSong(UploadSong uploadSong, String token) async {
    final uri = Uri.parse('$baseUrl/upload_song');
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.fields['title'] = uploadSong.title;
    request.files.add(
        await http.MultipartFile.fromPath('mp3_file', uploadSong.mp3File.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      return songFromJsonString(res.body);
    } else {
      throw Exception('Failed to upload song!');
    }
  }

  Future<List<Song>> getAllUploadSong(int userId) async {
    Uri uri = Uri.parse(baseUrl)
        .replace(path: 'api/get_uploaded_song', queryParameters: {
      'user_id': userId.toString(),
    });
    final response = await http.get(uri, headers: {
      'Accept': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      return songFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load songs!');
    }
  }
}
