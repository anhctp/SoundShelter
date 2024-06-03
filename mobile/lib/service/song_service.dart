import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/song_repository.dart';

class SongService {
  SongRepository songRepository = SongRepository();

  //rank song by views
  Future<List<Song>> getSongsRank() async {
    try {
      return await songRepository.getSongsRank();
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }

  //get newest songs
  Future<List<Song>> getNewestSongs() async {
    try {
      return await songRepository.getNewestSongs();
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }

  //find song by name
  Future<List<Song>> findSong(String text) async {
    try {
      return await songRepository.findSong(text);
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }
}
