import 'package:mobile/model/genre_model.dart';
import 'package:mobile/repository/genre_repository.dart';

class GenreService {
  GenreRepository genreRepository = GenreRepository();

  Future<List<Genre>> getAllGenre() async {
    try {
      return await genreRepository.getAllGenre();
    } catch (e) {
      print(e);
      throw Exception('Failed to load genres!');
    }
  }

  Future<Genre> getGenreById(int id) async {
    try {
      return await genreRepository.getGenreById(id);
    } catch (e) {
      print(e);
      throw Exception('Failed to load genres!');
    }
  }
}