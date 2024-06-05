import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/components/box/neu_box.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/module/timer-picker/timer_picker.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class FullPlayingView extends StatefulWidget {
  const FullPlayingView({super.key});

  @override
  State<FullPlayingView> createState() => _FullPlayingViewState();
}

class _FullPlayingViewState extends State<FullPlayingView> {
  //convert duratiob into min:sec
  String formatTime(Duration duration) {
    String twoDigiSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigiSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(builder: (context, value, child) {
      //get playlist
      final songs = value.playingSongs;

      //get current song index
      final currentSong = songs[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: ScreenHeader(title: "Bài hát đang phát"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //song detail
                Neubox(
                  child: Column(
                    children: [
                      //img
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(currentSong.imageFilePath),
                      ),

                      //song and artist name and icon
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 240,
                                  child: Text(
                                    currentSong.title,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 240,
                                  child: Text(
                                    currentSong.artist,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),

                            //more icon
                            IconButton(
                              onPressed: () {
                                print('more');
                              },
                              icon: Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //song duration progress
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //start time
                              Text(formatTime(value.currentDuration)),

                              //shuffle
                              IconButton(
                                onPressed: value.shuffle,
                                focusColor: Colors.blue,
                                icon: Icon(
                                  Icons.shuffle,
                                ),
                              ),

                              //repeat icon
                              IconButton(
                                onPressed: value.repeat,
                                icon: Icon(
                                  Icons.repeat,
                                  color: (value.isRepeat)
                                      ? Colors.blue
                                      : Colors.black,
                                ),
                              ),

                              //end time
                              Text(formatTime(value.totalDuration)),
                            ],
                          ),

                          //song duration progress
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 0),
                            ),
                            child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds
                                  .toDouble()
                                  .clamp(0,
                                      value.totalDuration.inSeconds.toDouble()),
                              activeColor: Colors.green,
                              onChanged: (double double) {
                                //during when user is sliding around
                                value.seek(Duration(seconds: double.toInt()));
                              },
                              onChangeEnd: (double double) {
                                //sliding has finished, go to the position in song duration
                                value.seek(Duration(seconds: double.toInt()));
                              },
                            ),
                          ),
                        ],
                      ),

                      //playback controls
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),

                //playback controls
                Row(
                  children: [
                    //skip prev
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPrevSong,
                        child: Neubox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    //play pause
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child: Neubox(
                          child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    //skip forward
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: Neubox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                //like,share,cmt
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //like
                        IconButton(
                          onPressed: value.favorites,
                          icon: (value.isFavorite)
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                        ),
                        Text(
                          "1",
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    //set time
                    TimerPicker(
                      value: value,
                    ),
                    //share
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share_rounded)),
                    //comment
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_outlined)),
                    /*
                    Expanded(child: Container()),
                    GestureDetector(
                      child: Row(
                        children: [
                          const Text(
                            "DANH SÁCH PHÁT",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.queue_music_rounded))
                        ],
                      ),
                    )*/
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
