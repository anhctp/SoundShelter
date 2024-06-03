import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/recommend_repository.dart';

class RecommendService {
  RecommendRepository recommendRepository = RecommendRepository();

  //get recommendation
  Future<List<Song>> getRecommendation(int? userId) async {
    try {
      return await recommendRepository.getRecommendation(userId);
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }
}
