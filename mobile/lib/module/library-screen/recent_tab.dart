import 'package:flutter/material.dart';
import 'package:mobile/components/button/see_all_button.dart';
import 'package:mobile/components/card/circle_card.dart';
import 'package:mobile/components/card/small_square_card.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/recent_screen.dart';
import 'package:mobile/provider/song_provider.dart';
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
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getHistory();
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
                  maxHeight: 150),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: (songProvider.user != null)
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
                            return Row(
                              children: [
                                if (index % 2 != 0 && index < 6)
                                  FittedBox(
                                    child: SmallSquareCard(
                                        song: song,
                                        songProvider: songProvider,
                                        index: index,
                                        playlist: songProvider.historySongs),
                                  ),
                                if (index % 2 == 0 && index < 6)
                                  FittedBox(
                                    child: CircleCard(
                                        song: song,
                                        songProvider: songProvider,
                                        index: index,
                                        playlist: songProvider.historySongs),
                                  ),
                                if (index == 6)
                                  SeeAllButton(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RecentScreen(
                                              songs: songProvider.historySongs),
                                        ),
                                      );
                                    },
                                  ),
                              ],
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
  }
}
