import 'package:flutter/material.dart';
import 'package:mobile/components/button/see_all_button.dart';
import 'package:mobile/components/card/big_square_card.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/recommend_screen.dart';
import 'package:mobile/provider/song_provider.dart';
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
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getRecommendation();
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
                  if (songProvider.user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendScreen(
                          songs: songProvider.recommendSongs,
                        ),
                      ),
                    );
                  }
                },
                name: "Gợi ý cho bạn"),
            Container(
              constraints: BoxConstraints(
                  minHeight: 0,
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.width / 2 + 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: (songProvider.user != null)
                  ? ((songProvider.recommendSongs.isNotEmpty)
                      ? Container(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 15,
                              );
                            },
                            itemBuilder: (context, index) {
                              final song = songProvider.recommendSongs[index];
                              return Row(
                                children: [
                                  (index < 5)
                                      ? FittedBox(
                                          child: BigSquareCard(
                                            song: song,
                                            songProvider: songProvider,
                                            index: index,
                                            playlist:
                                                songProvider.recommendSongs,
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
  }
}
