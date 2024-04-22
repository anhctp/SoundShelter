import 'package:flutter/material.dart';
import 'package:mobile/components/box/neu_box.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  //convert duratiob into min:sec 
  String formatTime (Duration duration) {
    String twoDigiSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigiSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(builder: (context, value, child) {
      //get playlist
      final songs = value.songs;

      //get current song index
      final currentSong = songs[value.currentSongIndex ?? 0];
      
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back)),
                    Text('Top Song'),
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                //artist
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
                          children: [
                            //song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(currentSong.artist),
                              ],
                            ),

                            //heart icon
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
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

                              //shuffle icon
                              Icon(Icons.shuffle),

                              //repeat icon
                              Icon(Icons.repeat),

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
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor: Colors.green,
                              onChanged: (double double) {
                                //during when user is sliding around
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
                          child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
