import 'package:flutter/material.dart';
import 'package:mobile/components/expanding-card/expanding_card.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return DiscoveryScreenState();
  }
}

class DiscoveryScreenState extends State<DiscoveryScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Những Bài Hát Hay Nhất Của Quang Hùng MasterD',
      'subtitle': '',
      'image':
          'https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/3/d/a/3/3da353f1fd239f48e5ae0e0944cbd64b.jpg',
    },
    {
      'title': 'Những Bài Hát Hay Nhất Của Phan Mạnh Quỳnh',
      'subtitle': '',
      'image':
          'https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/2/6/c/1/26c183e222c00c5d7e9c9465ad7c058c.jpg',
    },
    {
      'title': 'Những Bài Hát Hay Nhất Của Bích Phương',
      'subtitle': '',
      'image':
          'https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/7/0/3/7/703744e065218ee5a009bd7ee4d460e9.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6D6),
        title: Text(
          "Khám phá",
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Đáng chú ý",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color(0xFFB2572B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: ExpandingCards(
                  height: 400,
                  items: items,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
