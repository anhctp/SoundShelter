import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/components/box/neu_box.dart';
import 'package:mobile/components/title/custom_appbar.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:mobile/provider/user_provider.dart';
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
          return Consumer<UserProvider>(
            builder: (context, userProvider, child) {
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
                            if (userProvider.currentUser != null) {
                              songProvider.getRecommendation(
                                  userProvider.currentUser!.id);
                              songProvider.createHistory(
                                  userProvider.currentUser!.id, song.id!);
                            }
                            ;
                            goToSong(index);
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
                        )
                      //rest of list
                      : Container(
                          child: GestureDetector(
                            onTap: () {
                              if (userProvider.currentUser != null) {
                                songProvider.getRecommendation(
                                    userProvider.currentUser!.id);
                                songProvider.createHistory(
                                    userProvider.currentUser!.id, song.id!);
                              }
                              ;
                              goToSong(index);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 70,
                                  //insert img
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        //darker shadow on bottom right
                                        BoxShadow(
                                          color: Colors.grey.shade500,
                                          blurRadius: 15,
                                          offset: const Offset(4, 4),
                                        ),

                                        //lighter shadow on top left
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 15,
                                          offset: const Offset(-4, -4),
                                        ),
                                      ],
                                    ),
                                    child: Image.network(song.imageFilePath),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        song.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        song.artist,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print('more');
                                  },
                                  icon: Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              );
            },
          );
        },
      ),
    );
  }
}
