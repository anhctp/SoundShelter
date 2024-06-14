import 'dart:convert';

class Favorite {
  int? id;
  int userId;
  int songId;

  Favorite({required this.userId, required this.songId, this.id});

  factory Favorite.fromJson(String jsonData) {
    Map<String, dynamic> map = json.decode(jsonData);
    return Favorite(
      id: map["id"],
      userId: map["user_id"],
      songId: map["song_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"user_id": userId, "song_id": songId};
  }
}

String favoriteToJson(Favorite data) {
  return json.encode(data.toJson());
}
