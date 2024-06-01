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

class _RecentScreenState extends State<RecentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Nghe gần đây",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView.separated(
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
              name: "Music ${index}",
              imgFilePath:
                  "https://avatar-ex-swe.nixcdn.com/playlist/share/2020/11/06/9/d/6/c/1604632166306.jpg",
              artist: "artist",
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
