import 'package:flutter/material.dart';
import 'package:mobile/components/button/see_all_button.dart';
import 'package:mobile/components/card/circle_card.dart';
import 'package:mobile/components/card/small_square_card.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/recent_screen.dart';

class RecentTab extends StatefulWidget {
  const RecentTab({super.key});

  @override
  State<RecentTab> createState() => _RecentTabState();
}

class _RecentTabState extends State<RecentTab> {
  @override
  Widget build(BuildContext context) {
    return //recent
        Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabName(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecentScreen()));
              },
              name: "Nghe gần đây"),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10,
                );
              },
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    if (index % 2 != 0 && index < 6)
                      SmallSquareCard(
                        title: "title",
                        imgFilePath:
                            "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
                        onTap: () {},
                      ),
                    if (index % 2 == 0 && index < 6)
                      CircleCard(
                        title: "title",
                        imgFilePath:
                            "https://avatar-ex-swe.nixcdn.com/topic/share/2020/11/05/c/8/6/1/1604568785929.jpg",
                        onTap: () {},
                      ),
                    if (index == 6)
                      SeeAllButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecentScreen(),
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
              itemCount: 7,
            ),
          ),
        ],
      ),
    );
  }
}
