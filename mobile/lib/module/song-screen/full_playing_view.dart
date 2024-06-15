import 'package:flutter/material.dart';
import 'package:mobile/components/box/neu_box.dart';
import 'package:mobile/components/notification/my_alert.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/module/comment/comment_modal.dart';
import 'package:mobile/module/song-screen/duration_progress.dart';
import 'package:mobile/module/song-screen/song_detail.dart';
import 'package:mobile/module/timer-picker/timer_picker.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class FullPlayingView extends StatefulWidget {
  const FullPlayingView({super.key});

  @override
  State<FullPlayingView> createState() => _FullPlayingViewState();
}

class _FullPlayingViewState extends State<FullPlayingView> {
  int i = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, value, child) {
        //get playlist
        final songs = value.playingSongs;

        //get current song index
        final currentSong = songs[value.currentSongIndex ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: ScreenHeader(title: "Bài hát đang phát"),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 25, top: 25),
              child: Column(
                children: [
                  //song detail
                  SongDetail(currentSong: currentSong, songProvider: value),
                  const SizedBox(
                    height: 25,
                  ),
                  //song duration progress
                  DurationProgress(songProvider: value),

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
                            child: Icon(value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
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
                            onPressed: () {
                              value.favorites();
                              if (value.isFavorite)
                                i++;
                              else
                                i--;
                            },
                            icon: (value.isFavorite)
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border),
                          ),
                          Text(
                            i.toString(),
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
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return MyAlert(
                                      content: 'Đã sao chép đường dẫn');
                                });
                          },
                          icon: const Icon(Icons.share_rounded)),
                      //comment
                      CommentModal(),
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
      },
    );
  }
}
