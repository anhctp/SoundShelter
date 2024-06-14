import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/components/box/neu_box.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/custom_appbar.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/playlist-screen/create_playlist_modal.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChartScreenState();
  }
}

class ChartScreenState extends State<ChartScreen>
    with SingleTickerProviderStateMixin {
  late final dynamic songProvider;
  @override
  void initState() {
    super.initState();
    songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getSongsRank();
  }

  void goToSong(int songIndex) {
    songProvider.setPlayingSongs(songProvider.songs);
    //update current song index
    songProvider.currentSongIndex = songIndex;

    //navigate to song page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FullPlayingView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Bảng xếp hạng",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          return ListView.separated(
            padding: EdgeInsets.all(10.0),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: songProvider.songs.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final Song song = songProvider.songs[index];
              return index == 0
                  ? GestureDetector(
                      onTap: () {
                        goToSong(index);
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => CreatePlaylistModal(
                            currentSong: song,
                            songProvider: songProvider,
                            add: true,
                          ),
                        );
                      },
                      child: Neubox(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Text(
                                "Bài hát được nghe nhiều nhất",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            //img
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(song.imageFilePath),
                            ),

                            //song and artist name and icon
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //song and artist name
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(song.artist),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            CreatePlaylistModal(
                                          currentSong: song,
                                          songProvider: songProvider,
                                          add: true,
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  //rest of list
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: 35,
                          alignment: Alignment.center,
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MusicItem(
                              songProvider: songProvider,
                              song: song,
                              add: true,
                              index: index,
                              playlist: songProvider.songs),
                        )
                      ],
                    );
            },
          );
        },
      ),
    );
  }
}
