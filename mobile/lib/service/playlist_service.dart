import 'package:mobile/model/playlist_model.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/playlist_repository.dart';

class PlaylistService {
  PlaylistRepository playlistRepository = PlaylistRepository();

  //get all playlist
  Future<List<Playlist>> getAllPlaylists() async {
    try {
      return await playlistRepository.getAllPlaylists();
    } catch (e) {
      print(e);
      throw Exception('Failed to load playlists');
    }
  }

  //create playlist
  Future<Playlist> createPlaylist(Playlist playlist) async {
    try {
      if (playlist.code.isEmpty ||
          playlist.name.isEmpty ||
          playlist.imageFilePath.isEmpty) {
        throw Exception('Playlist cannot be empty!');
      }
      return await playlistRepository.createPlaylist(playlist);
    } catch (e) {
      print(e);
      throw Exception('Failed to create playlist!');
    }
  }

  //get sonngs by playlist id
  Future<List<Song>> getSongsByPlaylist(int playlistId) async {
    try {
      return await playlistRepository.getSongsByPlaylist(playlistId);
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs');
    }
  }
}
