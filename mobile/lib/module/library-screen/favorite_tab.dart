import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(
      children: [
        //tab bar
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              dividerColor: Theme.of(context).colorScheme.background,
              controller: tabController,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: const Color(0xFFD6ACAE),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: "Playlist"),
                Tab(text: "Album"),
              ],
            ),
          ),
        ),
        //tab bar content
        Container(
          height: 300,
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.separated(
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
                      name: "Playlist ${index}",
                      imgFilePath:
                          "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
                      artist: "artist",
                      onTap: () {},
                    );
                  },
                ),
                ListView.separated(
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
                      name: "Album ${index}",
                      imgFilePath:
                          "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
                      artist: "artist",
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
