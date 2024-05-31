import 'package:flutter/material.dart';
import 'package:mobile/components/card/custom_card.dart';
import 'package:mobile/components/title/screen_header.dart';

class NewFeatureScreen extends StatefulWidget {
  const NewFeatureScreen({super.key});

  @override
  State<NewFeatureScreen> createState() => _NewFeatureScreenState();
}

class _NewFeatureScreenState extends State<NewFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Mới phát hành",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            10,
            (index) {
              return CustomCard(
                title: "title",
                imgFilePath:
                    "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
              );
            },
          ),
        ),
      ),
    );
  }
}
