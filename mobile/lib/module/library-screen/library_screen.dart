import 'package:flutter/material.dart';
import 'package:mobile/components/title/custom_appbar.dart';
import 'package:mobile/module/library-screen/favorite_tab.dart';
import 'package:mobile/module/library-screen/personal_tab.dart';
import 'package:mobile/module/library-screen/recent_tab.dart';
import 'package:mobile/module/library-screen/recommend_tab.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LibraryScreenState();
  }
}

class LibraryScreenState extends State<LibraryScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Thư viện"),
      backgroundColor: const Color(0xFFDCD1B3),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            PersonalTab(),
            SizedBox(
              height: 5,
            ),
            RecentTab(),
            SizedBox(
              height: 5,
            ),
            FavoriteTab(),
            RecommendTab(),
          ],
        ),
      ),
    );
  }
}
