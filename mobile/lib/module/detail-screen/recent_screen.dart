import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/screen_header.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: ScreenHeader(
        title: "Nghe gần đây",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Column(
        children: [
          //tab bar
          Container(
            child: TabBar(
              dividerColor: Theme.of(context).colorScheme.background,
              controller: tabController,
              labelPadding: EdgeInsets.only(left: 10, right: 10),
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: const Color(0xFFD6ACAE),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: "Bài hát"),
                Tab(text: "Playlist"),
              ],
            ),
          ),
          //tab bar content
          Container(
            height: MediaQuery.of(context).size.height - 130,
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
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return MusicItem(
                        name: "Playlist ${index}",
                        imgFilePath:
                            "https://avatar-ex-swe.nixcdn.com/playlist/share/2020/11/06/9/d/6/c/1604632166306.jpg",
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
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return MusicItem(
                        name: "Album ${index}",
                        imgFilePath:
                            "https://avatar-ex-swe.nixcdn.com/playlist/share/2020/11/06/9/d/6/c/1604632166306.jpg",
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
      ),
    );
  }
}
