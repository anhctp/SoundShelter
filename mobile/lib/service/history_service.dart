import 'package:mobile/model/history_model.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/history_repository.dart';

class HistoryService {
  HistoryRepository historyRepository = HistoryRepository();

  //create heard song
  Future<dynamic> createHistory(History history) async {
    try {
      if (history.userId <= 0 ||
          history.songId <= 0 ||
          history.playDate.isEmpty) {
        throw Exception('History song is invalid!');
      }
      return await historyRepository.createHistory(history);
    } catch (e) {
      print(e);
      throw Exception('Failed to create history!');
    }
  }

  //get recently heard songs
  Future<List<Song>> getHistory(int userId) async {
    try {
      return await historyRepository.getHistory(userId);
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }
}
