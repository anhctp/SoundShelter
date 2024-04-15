import 'package:flutter/material.dart';

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
    Text('Discovery Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Chart Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Hub Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Library Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Account Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cyclone_rounded),
            label: 'Discovery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_sharp),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Hub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
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
