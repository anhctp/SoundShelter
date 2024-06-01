import 'package:mobile/model/song_model.dart';
import 'package:mobile/repository/recommend_repository.dart';

class RecommendService {
  RecommendRepository recommendRepository = RecommendRepository();

  //get recommendation
  Future<List<Song>> getRecommendation() async {
    try {
      return await recommendRepository.getRecommendation();
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }
}
