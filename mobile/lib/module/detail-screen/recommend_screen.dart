import 'package:flutter/material.dart';
import 'package:mobile/components/card/big_square_card.dart';
import 'package:mobile/components/title/screen_header.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Gợi ý cho bạn",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: GridView.count(
        padding: EdgeInsets.only(left: 20, top: 10),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.83,
        children: List.generate(10, (index) {
          return BigSquareCard(
              imgFilePath:
                  "https://photo-zmp3.zmdcdn.me/cover/c/9/b/3/c9b3c456eeabd9d4e3241666397d71aa.jpg",
              title: "title",
              subtitle: "subtitle",
              subtext: false,
              onTap: () {});
        }),
      ),
    );
  }
}
