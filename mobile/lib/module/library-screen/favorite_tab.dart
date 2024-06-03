import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/tab_name.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabName(onPressed: () {}, name: "Bài hát yêu thích"),
        Container(
          height: 300,
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              padding: EdgeInsets.all(10.0),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              scrollDirection: Axis.vertical,
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return MusicItem(
                  name: "Music ${index}",
                  imgFilePath:
                      "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
                  artist: "artist",
                  onTap: () {},
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
