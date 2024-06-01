import 'package:mobile/model/album_model.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/album_repository.dart';

class AlbumService {
  AlbumRepository albumRepository = AlbumRepository();

  //get list albums by genre id
  Future<List<Album>> getAlbumsByGenre(int genreId) async {
    try {
      return await albumRepository.getAlbumsByGenre(genreId);
    } catch (e) {
      print(e);
      throw Exception('Failed to load albums!');
    }
  }

  //get songs by album id
  Future<List<Song>> getSongsByAlbum(int? albumId) async {
    try {
      return await albumRepository.getSongsByAlbum(albumId);
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }
}
