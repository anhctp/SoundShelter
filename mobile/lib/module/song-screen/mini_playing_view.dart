import 'package:flutter/material.dart';
import 'package:mobile/module/song-screen/song_screen.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class MiniPlayingView extends StatefulWidget {
  const MiniPlayingView({super.key});

  @override
  State<MiniPlayingView> createState() => _MiniPlayingViewState();
}

class _MiniPlayingViewState extends State<MiniPlayingView> {
  //convert duratiob into min:sec
  String formatTime(Duration duration) {
    String twoDigiSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigiSeconds";

    return formattedTime;
  }

  //playing music
  void showSheetMusicPlayingLayout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(builder: (context, value, child) {
      if (value.currentSongIndex != null) {
        //get playlist
        final songs = value.songs;

        //get current song index
        final currentSong = songs[value.currentSongIndex ?? 0];

        return Container(
          height: 58,
          color: Theme.of(context).colorScheme.onSecondary,
          child: Column(
            children: [
              Container(
                height: 3,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                      3), // Optional: to add rounded corners
                ),
                child: LinearProgressIndicator(
                  value: value.totalDuration.inSeconds > 0
                      ? (value.currentDuration.inSeconds.toDouble().clamp(
                                0,
                                value.totalDuration.inSeconds.toDouble(),
                              ) /
                          value.totalDuration.inSeconds.toDouble())
                      : 0.0, // Handle division by zero
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      showSheetMusicPlayingLayout();
                    },
                    child: Container(
                      color: Colors.white.withOpacity(0),
                      child: Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(45)),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(currentSong.imageFilePath),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      currentSong.artist,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                  //heart icon
                  IconButton(
                    onPressed: value.favorites,
                    icon: (value.isFavorite)
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border),
                  ),
                  //play pause
                  IconButton(
                    icon: Icon(
                      value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: value.pauseOrResume,
                  ),
                  //skip forward
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 30,
                    ),
                    onPressed: value.playNextSong,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              )
            ],
          ),
        );
      } else
        return Container();
    });
  }
}
