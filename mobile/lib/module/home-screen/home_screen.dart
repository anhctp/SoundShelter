import 'package:flutter/material.dart';
import 'package:mobile/module/discovery-screen/discovery_screen.dart';
import 'package:mobile/module/chart-screen/chart_screen.dart';
import 'package:mobile/module/hub-screen/hub_screen.dart';
import 'package:mobile/module/library-screen/library_screen.dart';
import 'package:mobile/module/account-screen/account_screen.dart';
import 'package:mobile/module/song-screen/mini_playing_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  static const List<Widget> widgetOptions = <Widget>[
    DiscoveryScreen(),
    ChartScreen(),
    HubScreen(),
    LibraryScreen(),
    AccountScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Body Tabbar
          Expanded(
            child: widgetOptions.elementAt(selectedIndex),
          ),
          const MiniPlayingView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cyclone_rounded),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_sharp),
            label: 'Xếp hạng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Chủ đề',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Cá nhân',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF4F1E7),
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFFB2572B),
        unselectedItemColor: const Color(0xFFD6ACAE),
        onTap: onItemTapped,
      ),
    );
  }
}
