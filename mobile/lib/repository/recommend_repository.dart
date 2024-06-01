import 'package:mobile/model/song_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/provider/user_provider.dart';

class RecommendRepository {
  final String baseUrl =
      "http://localhost:8000/api/recommend/get_recommendation";
  UserProvider userProvider = UserProvider();

  //get recommendation
  Future<List<Song>> getRecommendation() async {
    print(userProvider.checkLoginStatus());
    final currentUser = userProvider.currentUser;
    var response;
    if (currentUser != null) {
      response = await http.get(
        Uri.parse("$baseUrl/${userProvider.currentUser!.id}"),
        headers: {'Accept': 'application/json; charset=UTF-8'},
      );
    }

    if (response.statusCode == 200) {
      print(response.body);
      return songFromJson(response.bodyBytes);
    } else {
      print(response.body);
      throw Exception('Failed to load songs!');
    }
  }
}
