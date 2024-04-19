import 'package:flutter/widgets.dart';
import 'package:mobile/model/playlist_model.dart';
import 'package:mobile/service/playlist_service.dart';

class PlaylistProvider with ChangeNotifier {
  PlaylistService playlistService = PlaylistService();
  List<Playlist> _playlists = [];
  List<Playlist> get playlists => _playlists;
  Future<void> getAllPlaylists() async {
    _playlists = await playlistService.getAllPlaylists();
    notifyListeners();
  }

  Future<void> createPlaylist(Playlist playlist) async {
    Playlist newPlaylist = await playlistService.createPlaylist(playlist);
    _playlists.add(newPlaylist);
    notifyListeners();
  }

  // void updatePlaylist(int id, String code) async {
  //   _playlists[_playlists.indexWhere((item) => item.id == id)].code = code;
  //   notifyListeners();
  // }

  // void deletePlaylist(int id) async {
  //   _playlists.removeWhere((item) => item.id == id);
  //   notifyListeners();
  // }
}
