import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/service/album_service.dart';
import 'package:mobile/service/playlist_service.dart';
import 'package:mobile/service/recommend_service.dart';
import 'package:mobile/service/song_service.dart';

class SongProvider with ChangeNotifier {
  SongService songService = SongService();
  AlbumService albumService = AlbumService();
  PlaylistService playlistService = PlaylistService();
  RecommendService recommendService = RecommendService();

  List<Song> _songs = [];
  List<Song> _playingSongs = [];
  //getter
  List<Song> get songs => _songs;
  List<Song> get playingSongs => _playingSongs;

  //setter
  List<Song> setPlayingSongs() {
    if (songs.isNotEmpty) _playingSongs = _songs;
    return _playingSongs;
  }

  //find song by name
  Future<void> findSong(String text) async {
    _songs = await songService.findSong(text);
    notifyListeners();
  }

  //rank songs by views
  Future<void> getSongsRank() async {
    _songs = await songService.getSongsRank();
    notifyListeners();
  }

  //get newest songs
  Future<void> getNewestSongs() async {
    _songs = await songService.getNewestSongs();
    notifyListeners();
  }

  //get songs by album id
  Future<void> getSongsByAlbum(int? albumId) async {
    _songs = await albumService.getSongsByAlbum(albumId);
    notifyListeners();
  }

  //get songs by playlist id
  Future<void> getSongsByPlaylist(int playlistId) async {
    _songs = await playlistService.getSongsByPlaylist(playlistId);
    notifyListeners();
  }

  //get recommendation
  Future<void> getRecommendation() async {
    _songs = await recommendService.getRecommendation();
    notifyListeners();
  }

  // create or delete favorite
  void favorites() async {
    _isFavorite = !_isFavorite;
    if (_isFavorite) {
    } else {}
    notifyListeners();
  }

  //current song playing index
  int? _currentSongIndex;
  //getter
  int? get currentSongIndex => _currentSongIndex;
  //setter
  set currentSongIndex(int? newIndex) {
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
  Duration get totalDuration => _totalDuration;

  //constructor
  SongProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;
  //getter
  bool get isPlaying => _isPlaying;

  //initially not repeat
  bool _isRepeat = false;
  //getter
  bool get isRepeat => _isRepeat;

  //initially not favorite
  bool _isFavorite = false;
  //getter
  bool get isFavorite => _isFavorite;

  //play
  void play() async {
    _isRepeat = false;
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    final String path = _playingSongs[_currentSongIndex!].audioFilePath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(UrlSource(path)); //play new song
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

  //shuffle
  void shuffle() {
    Random r = new Random();
    currentSongIndex = r.nextInt(_playingSongs.length);
    notifyListeners();
  }

  //repeat
  void repeat() {
    // Toggle repeat mode
    _isRepeat = !_isRepeat;
    if (_isRepeat) {
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else {
      _isRepeat = false;
      _audioPlayer.setReleaseMode(ReleaseMode.stop);
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playingSongs.length - 1) {
        //go to the next song if it's not last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //last song: loop back to the first
        currentSongIndex = 0;
      }
    }
  }

  //playNextSong or repeat
  void nextOrRepeat() {
    if (_isRepeat) {
    } else {
      playNextSong();
    }
  }

  //play prev song
  void playPrevSong() async {
    //>2s load, restart the current song
    if (_currentDuration.inSeconds > 2) {
      currentSongIndex = _currentSongIndex!;
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //it's the first song, look back to last
        currentSongIndex = _playingSongs.length - 1;
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
      nextOrRepeat();
    });
  }

  //dispose audio player
}
