//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/service/song_service.dart';

class SongProvider with ChangeNotifier {
  SongService songService = SongService();
  List<Song> _songs = [];
  //getter
  List<Song> get songs => _songs;
  Future<void> getSongsRank() async {
    _songs = await songService.getSongsRank();
    notifyListeners();
  }
/*
  //current song playing index
  int? _currentSongIndex;
  //getter
  int? get currentSongIndex => _currentSongIndex;
  //setter
  set currentSongIndex (int? newIndex) {
    //update current song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(); //play the new index song
    }

    //update ui
    notifyListeners();
  }
  
  /* audio player */
  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  //getter
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _currentDuration;
  
  //constructor
  SongProvider(){listenToDuration();}

  //initially not playing
  bool _isPlaying = false;
  //getter
  bool get isPlaying => _isPlaying;

  //play
  void play() async {
    final String path = _songs[_currentSongIndex!].audioFilePath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(AssetSource(path)); //play new song
    _isPlaying = true;
    notifyListeners();
  }

  //pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
     notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if(_currentSongIndex != null) {
      if (_currentSongIndex! < _songs.length - 1) {
        //go to the next song if it's not last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //last song: loop back to the first
        currentSongIndex = 0;
      }
    }
  }

  //play prev song
  void playPrevSong() async {
    //>2s load, restart the current song
    if (_currentDuration.inSeconds > 2) {

    } else { 
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //it's the first song, look back to last
        currentSongIndex = _songs.length - 1;
      }
    }
  }

  //list to duration
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) { 
      playNextSong();
    });
  }

  //dispose audio player
  */
}

