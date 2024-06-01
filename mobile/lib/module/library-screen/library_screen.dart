import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6D6),
        title: Text(
          "Thư viện",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        actions: const [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color(0xFFB2572B),
            ),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
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
