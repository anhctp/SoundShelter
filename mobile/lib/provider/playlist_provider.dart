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
}
