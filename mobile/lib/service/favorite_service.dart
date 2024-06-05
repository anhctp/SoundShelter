import 'package:mobile/model/favorite_model.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/favorite_repository.dart';

class FavoriteService {
  FavoriteRepository favoriteRepository = FavoriteRepository();

  //create favorite song
  Future<dynamic> createFavorite(Favorite favorite) async {
    try {
      if (favorite.userId <= 0 || favorite.songId <= 0) {
        throw Exception('Favorite song is invalid!');
      }
      return await favoriteRepository.createFavorite(favorite);
    } catch (e) {
      print(e);
      throw Exception('Failed to create history!');
    }
  }

  //get favorites by user id
  Future<List<Song>> getFavorite(String token) async {
    try {
      return await favoriteRepository.getFavorite(token);
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }

  //delete favorite
  Future<dynamic> delelteFavorite(int songId, String token) async {
    try {
      return await favoriteRepository.deleteFavorite(songId, token);
    } catch (e) {
      print(e);
      throw Exception('Failed to delete favorite!');
    }
  }
}
