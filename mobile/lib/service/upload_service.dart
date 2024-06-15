import 'package:mobile/model/song_model.dart';
import 'package:mobile/model/upload_song_model.dart';
import 'package:mobile/repository/upload_repository.dart';

class UploadService {
  UploadRepository uploadRepository = UploadRepository();

  Future<dynamic> uploadSong(UploadSong uploadSong, String token) async {
    try {
      if (uploadSong.title.isEmpty) {
        throw Exception('Upload song is invalid!');
      }
      return await uploadRepository.uploadSong(uploadSong, token);
    } catch (e) {
      print(e);
      throw Exception('Failed to create history!');
    }
  }

  Future<List<Song>> getAllUploadSong(int userId) async {
    try {
      return await uploadRepository.getAllUploadSong(userId);
    } catch (e) {
      print(e);
      throw Exception('Failed to load songs!');
    }
  }
}
