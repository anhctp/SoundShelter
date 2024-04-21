import 'package:flutter/material.dart';
import 'package:mobile/model/genre_model.dart';
import 'package:mobile/service/genre_service.dart';

class GenreProvider with ChangeNotifier {
  GenreService genreService = GenreService();
  List<Genre> _genres = [];
  //getter
  List<Genre> get genres => _genres;
  Future<void> getAllGenre() async {
    _genres = await genreService.getAllGenre();
    notifyListeners();
  }

  Future<void> getGenreById(int id) async {
    await genreService.getGenreById(id);
    notifyListeners();
  }
}
