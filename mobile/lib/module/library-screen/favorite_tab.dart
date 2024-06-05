import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/favorite_screen.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getFavorite(userProvider.currentUser?.token ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabName(
                    onPressed: () {
                      if (userProvider.currentUser != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteScreen(
                              songs: songProvider.favoriteSongs,
                            ),
                          ),
                        );
                      }
                    },
                    name: "Bài hát yêu thích"),
                Container(
                  constraints: BoxConstraints(
                      minHeight: 0,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: 300),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: (userProvider.currentUser != null)
                      ? ((songProvider.historySongs.isNotEmpty)
                          ? ListView.separated(
                              padding: EdgeInsets.all(10.0),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: songProvider.favoriteSongs.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final song = songProvider.favoriteSongs[index];
                                return MusicItem(
                                  name: song.title,
                                  imgFilePath: song.imageFilePath,
                                  artist: song.artist,
                                  onTap: () {
                                    songProvider.getRecommendation(
                                        userProvider.currentUser!.id);
                                    songProvider.createHistory(
                                        userProvider.currentUser!.id, song.id!);
                                    songProvider.setPlayingSongs(
                                        songProvider.favoriteSongs);
                                    //update current song index
                                    songProvider.currentSongIndex = index;

                                    //navigate to song page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FullPlayingView()),
                                    );
                                  },
                                );
                              },
                            )
                          : Text(
                              "Bạn chưa có bài hát yêu thích nào.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Bạn cần đăng nhập để sử dụng tính năng này.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
