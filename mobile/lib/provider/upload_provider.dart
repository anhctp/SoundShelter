import 'package:flutter/widgets.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/model/upload_song_model.dart';
import 'package:mobile/service/upload_service.dart';

class UploadProvider with ChangeNotifier {
  UploadService uploadService = UploadService();
  List<Song> _songs = [];
  List<Song> get songs => _songs;

  Future<bool> getAllUploadSong(int userID) async {
    try {
      _songs = await uploadService.getAllUploadSong(userID);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> uploadSong(UploadSong uploadSong, String token) async {
    try {
      Song newSong = await uploadService.uploadSong(uploadSong, token);
      _songs.add(newSong);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
