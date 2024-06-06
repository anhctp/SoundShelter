import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/favorite_screen.dart';
import 'package:mobile/provider/song_provider.dart';
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
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getFavorite();
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
              child: (songProvider.user != null)
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
                                songProvider: songProvider,
                                song: song,
                                add: false,
                                index: index,
                                playlist: songProvider.favoriteSongs);
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
  }
}
