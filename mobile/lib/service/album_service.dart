import 'package:mobile/model/album_model.dart';
import 'package:mobile/repository/album_repository.dart';

class AlbumService {
  AlbumRepository albumRepository = AlbumRepository();

  Future<List<Album>> getAlbumsByGenre(int genreId) async {
    try {
      return await albumRepository.getAlbumsByGenre(genreId);
    } catch (e) {
      print(e);
      throw Exception('Failed to load albums!');
    }
  }
}
