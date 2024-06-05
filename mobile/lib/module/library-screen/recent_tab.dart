import 'package:flutter/material.dart';
import 'package:mobile/components/button/see_all_button.dart';
import 'package:mobile/components/card/circle_card.dart';
import 'package:mobile/components/card/small_square_card.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/recent_screen.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RecentTab extends StatefulWidget {
  const RecentTab({super.key});

  @override
  State<RecentTab> createState() => _RecentTabState();
}

class _RecentTabState extends State<RecentTab> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getHistory(userProvider.currentUser?.id ?? 0);
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
                            builder: (context) => RecentScreen(
                              songs: songProvider.historySongs,
                            ),
                          ),
                        );
                      }
                    },
                    name: "Nghe gần đây"),
                Container(
                  constraints: BoxConstraints(
                      minHeight: 0,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: 130),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: (userProvider.currentUser != null)
                      ? ((songProvider.historySongs.isNotEmpty)
                          ? ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                final song = songProvider.historySongs[index];
                                return FittedBox(
                                  child: Row(
                                    children: [
                                      if (index % 2 != 0 && index < 6)
                                        SmallSquareCard(
                                          title: song.title,
                                          imgFilePath: song.imageFilePath,
                                          onTap: () {
                                            songProvider.getRecommendation(
                                                userProvider.currentUser!.id);
                                            songProvider.createHistory(
                                                userProvider.currentUser!.id,
                                                song.id!);
                                            songProvider.setPlayingSongs(
                                                songProvider.historySongs);
                                            songProvider.currentSongIndex =
                                                index;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullPlayingView(),
                                              ),
                                            );
                                          },
                                        ),
                                      if (index % 2 == 0 && index < 6)
                                        CircleCard(
                                          title: song.title,
                                          imgFilePath: song.imageFilePath,
                                          onTap: () {
                                            songProvider.getRecommendation(
                                                userProvider.currentUser!.id);
                                            songProvider.createHistory(
                                                userProvider.currentUser!.id,
                                                song.id!);
                                            songProvider.setPlayingSongs(
                                                songProvider.historySongs);
                                            songProvider.currentSongIndex =
                                                index;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullPlayingView(),
                                              ),
                                            );
                                          },
                                        ),
                                      if (index == 6)
                                        SeeAllButton(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RecentScreen(
                                                        songs: songProvider
                                                            .historySongs),
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: (songProvider.historySongs.length > 7)
                                  ? 7
                                  : songProvider.historySongs.length,
                            )
                          : Text(
                              "Bạn chưa nghe bài hát nào gần đây.",
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
