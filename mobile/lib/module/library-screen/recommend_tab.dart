import 'package:flutter/material.dart';
import 'package:mobile/components/button/see_all_button.dart';
import 'package:mobile/components/card/big_square_card.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/detail-screen/recommend_screen.dart';
import 'package:mobile/module/sign-in-screen/sign_in_screen.dart';
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
    songProvider.getRecommendation(userProvider.currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabName(
                onPressed: () {
                  if (songProvider.recommendSongs.isNotEmpty) {
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
                    );
                  }
                },
                name: "Gợi ý cho bạn"),
            Container(
              height: MediaQuery.of(context).size.width / 2 + 20,
              width: MediaQuery.of(context).size.width,
              child: (songProvider.recommendSongs.isNotEmpty)
                  ? _buildListCard(
                      songProvider.recommendSongs,
                      true,
                      5,
                    )
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
  }

  Widget _buildListCard(List<Song> songs, bool seeAll, int count,
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
                  imgFilePath: songs[index].imageFilePath,
                  title: songs[index].title,
                  subtitle: songs[index].artist,
                  subtext: subtext,
                  onTap: () {},
                ),
              if (seeAll == true && index == count)
                SeeAllButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendScreen(songs: songs),
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
