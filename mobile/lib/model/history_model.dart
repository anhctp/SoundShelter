import 'dart:convert';

class History {
  int userId;
  int songId;
  String playDate;

  History({
    required this.userId,
    required this.songId,
    required this.playDate,
  });

  Map<String, dynamic> toJson() {
    return {"user_id": userId, "song_id": songId, "play_date": playDate};
  }
}

String historyToJson(History data) {
  return json.encode(data.toJson());
}
