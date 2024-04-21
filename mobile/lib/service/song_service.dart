import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/song_repository.dart';

class SongService {
  SongRepository songRepository = SongRepository();

  Future<List<Song>> getSongsRank() async {
    try {
      return await songRepository.getSongsRank();
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }
}
