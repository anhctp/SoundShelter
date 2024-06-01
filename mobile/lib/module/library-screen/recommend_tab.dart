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
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabName(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecommendScreen()));
                  },
                  name: "Gợi ý cho bạn"),
              Container(
                height: MediaQuery.of(context).size.width / 2 + 20,
                width: MediaQuery.of(context).size.width,
                child: _buildListCard(_listTop100, true, 5),
              ),
            ],
          ),
        );
      },
    );
  }

  List _listTop100 = [
    {
      "id": "01",
      "title": "Top 100",
      "subtitle": "V-Pop Hay Nhất",
      "img":
          "https://avatar-ex-swe.nixcdn.com/playlist/share/2020/11/06/9/d/6/c/1604632166306.jpg"
    },
    {
      "id": "02",
      "title": "Top 100",
      "subtitle": "Dance Viet Nam",
      "img":
          "https://avatar-ex-swe.nixcdn.com/topic/share/2020/11/05/c/8/6/1/1604568785929.jpg"
    },
    {
      "id": "03",
      "title": "Top 100 Nhạc EDM",
      "subtitle": "Việt Hay Nhất",
      "img":
          "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg"
    },
    {
      "id": "04",
      "title": "Top 100 Nhạc Rap",
      "subtitle": "Việt Nam Hay Nhất",
      "img": "https://i.ytimg.com/vi/4VXB6KRvy44/maxresdefault.jpg"
    },
    {
      "id": "05",
      "title": "Top 100 Nhạc Phim",
      "subtitle": "Nhạt Trẻ Hay Nhất",
      "img":
          "https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/cover/3/5/f/5/35f56d89ab2e765b975c4145b91704c1.jpg"
    },
    {
      "id": "06",
      "title": "Top 100 Bài Hát",
      "subtitle": "Nhạt Trẻ Hay Nhất",
      "img":
          "https://suckhoedoisong.qltns.mediacdn.vn/Images/nguyenkhanh/2018/02/08/vpop.jpg"
    },
    {
      "id": "07",
      "title": "Top 100",
      "subtitle": "V-Pop Hay Nhất",
      "img":
          "https://suckhoedoisong.qltns.mediacdn.vn/Images/nguyenkhanh/2018/02/08/vpop.jpg"
    },
    {
      "id": "08",
      "title": "Top 100",
      "subtitle": "V-Pop Hay Nhất",
      "img":
          "https://suckhoedoisong.qltns.mediacdn.vn/Images/nguyenkhanh/2018/02/08/vpop.jpg"
    }
  ];

  Widget _buildListCard(List json, bool seeAll, int count,
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
                  imgFilePath: json[index]['img'],
                  title: json[index]['title'],
                  subtitle: json[index]['subtitle'],
                  subtext: subtext,
                  onTap: () {},
                ),
              if (seeAll == true && index == count)
                SeeAllButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendScreen(),
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
