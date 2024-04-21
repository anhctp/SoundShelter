import 'package:flutter/material.dart';
import 'package:mobile/model/album_model.dart';
import 'package:mobile/service/album_service.dart';

class AlbumProvider with ChangeNotifier {
  AlbumService albumService = AlbumService();
  List<Album> _albums = [];
  //getter
  List<Album> get albums => _albums;
  Future<void> getAlbumsByGenre(int genreId) async {
    _albums = await albumService.getAlbumsByGenre(genreId);
    notifyListeners();
  }
}