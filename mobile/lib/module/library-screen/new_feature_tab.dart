import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/new_feature_screen.dart';

class NewFeatureTab extends StatefulWidget {
  const NewFeatureTab({super.key});

  @override
  State<NewFeatureTab> createState() => _NewFeatureTabState();
}

class _NewFeatureTabState extends State<NewFeatureTab> {
  @override
  Widget build(BuildContext context) {
    return //new feature
        Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabName(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewFeatureScreen()));
              },
              name: "Mới phát hành"),
          Container(
            height: 250,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _buildGridList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridList() {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      padding: const EdgeInsets.all(2),
      childAspectRatio: 0.22,
      children: List.generate(
        7,
        (index) {
          return MusicItem(
            name: "name",
            imgFilePath:
                "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
            artist: "artist",
            onTap: () {},
          );
        },
      ),
    );
  }
}
