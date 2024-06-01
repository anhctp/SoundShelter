import 'package:http/http.dart' show Client;
import 'package:mobile/model/playlist_model.dart';
import 'package:mobile/model/song_model.dart';

class PlaylistRepository {
  final String baseUrl = "http://localhost:8000/api/playlist";
  Client client = Client();

  //get all playlists
  Future<List<Playlist>> getAllPlaylists() async {
    final response = await client.get(
      Uri.parse("$baseUrl/all"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode == 200) {
      return playlistFromJson(response.bodyBytes);
    } else {
      throw Exception('Failed to load playlists!');
    }
  }

  //create playlist
  Future<Playlist> createPlaylist(Playlist newPlaylist) async {
    final response = await client.post(Uri.parse("$baseUrl/all"),
        headers: {'Content-Type': 'application/json'},
        body: playlistToJson(newPlaylist));
    if (response.statusCode == 200) {
      return Playlist.fromJson(response.body);
    } else {
      throw Exception('Failed to create playlist!');
    }
  }

  //get songs by playlist id
  Future<List<Song>> getSongsByPlaylist(int playlistId) async {
    final response = await client.get(
      Uri.parse("$baseUrl/${playlistId}/songs"),
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode == 200) {
      return songFromJson(response.bodyBytes);
    } else {
      throw Exception('Failed to load songs!');
    }
  }
}
