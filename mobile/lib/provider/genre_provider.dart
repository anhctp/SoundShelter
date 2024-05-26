import 'package:flutter/material.dart';
import 'package:mobile/model/genre_model.dart';
import 'package:mobile/service/album_service.dart';
import 'package:mobile/service/genre_service.dart';

class GenreProvider with ChangeNotifier {
  GenreService genreService = GenreService();
  List<Genre> _genres = [];
  List<Map<String, dynamic>> _albums = [];
  //getter
  List<Genre> get genres => _genres;
  List<Map<String, dynamic>> get albums => _albums;

  Future<void> getAllGenre() async {
    _genres = await genreService.getAllGenre();
    notifyListeners();
  }

  Future<void> getAlbums() async {
    _genres = await genreService.getAllGenre();
    _albums = [];
    AlbumService albumService = AlbumService();
    for (var genreItem in _genres) {
      final album = await albumService.getAlbumsByGenre(genreItem.id);
      if (album.isNotEmpty) {
        _albums.add({
          'genre': genreItem,
          'album': album,
        });
      }
    }
    notifyListeners();
  }
}
