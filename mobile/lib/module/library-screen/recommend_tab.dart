import 'package:flutter/material.dart';
import 'package:mobile/components/button/see_all_button.dart';
import 'package:mobile/components/card/big_square_card.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/recommend_screen.dart';
import 'package:mobile/module/sign-in-screen/sign_in_screen.dart';
import 'package:mobile/module/song-screen/song_screen.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RecommendTab extends StatefulWidget {
  const RecommendTab({super.key});

  @override
  State<RecommendTab> createState() => _RecommendTabState();
}

class _RecommendTabState extends State<RecommendTab> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getRecommendation(userProvider.currentUser?.id ?? 0);
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
                            builder: (context) => RecommendScreen(
                              songs: songProvider.recommendSongs,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        ).then((value) => songProvider
                            .getRecommendation(userProvider.currentUser!.id));
                      }
                    },
                    name: "Gợi ý cho bạn"),
                Container(
                  height: MediaQuery.of(context).size.width / 2 + 20,
                  width: MediaQuery.of(context).size.width,
                  child: (userProvider.currentUser != null)
                      ? ((songProvider.recommendSongs.isNotEmpty)
                          ? Container(
                              height: 180,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 15,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final song = songProvider.songs[index];
                                  return Row(
                                    children: [
                                      (index < 5)
                                          ? FittedBox(
                                              child: BigSquareCard(
                                                imgFilePath: song.imageFilePath,
                                                title: song.title,
                                                subtitle: song.artist,
                                                subtext: false,
                                                onTap: () {
                                                  songProvider.setPlayingSongs(
                                                      songProvider
                                                          .recommendSongs);
                                                  songProvider
                                                      .currentSongIndex = index;
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SongScreen(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : SeeAllButton(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RecommendScreen(
                                                            songs: songProvider
                                                                .recommendSongs),
                                                  ),
                                                );
                                              },
                                            ),
                                    ],
                                  );
                                },
                                itemCount: 5 + 1,
                              ),
                            )
                          : Text(
                              "Chưa thể đưa ra gợi ý.",
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

  Widget _buildListCard(SongProvider songProvider, bool seeAll, int count,
      {bool subtext = false}) {
    return Container(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 15,
          );
        },
        itemBuilder: (context, index) {
          return Row(
            children: [
              if (index < count)
                BigSquareCard(
                  imgFilePath: songProvider.songs[index].imageFilePath,
                  title: songProvider.songs[index].title,
                  subtitle: songProvider.songs[index].artist,
                  subtext: subtext,
                  onTap: () {
                    songProvider.setPlayingSongs(songProvider.recommendSongs);
                    songProvider.currentSongIndex = index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongScreen(),
                      ),
                    );
                  },
                ),
              if (seeAll == true && index == count)
                SeeAllButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecommendScreen(songs: songProvider.recommendSongs),
                      ),
                    );
                  },
                ),
            ],
          );
        },
        itemCount: count + 1,
      ),
    );
  }
}
