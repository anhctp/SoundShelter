import 'package:flutter/material.dart';
import 'package:mobile/components/card/rectangle_card.dart';
import 'package:mobile/module/library-screen/personal_screen/upload_screen.dart';

class PersonalTab extends StatefulWidget {
  const PersonalTab({super.key});

  @override
  State<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  final List<dynamic> items = [
    {
      'icon': Icons.favorite,
      'title': 'Yêu thích',
      'subtitle': '',
      'onTap': () {},
    },
    {
      'icon': Icons.download,
      'title': 'Đã tải',
      'subtitle': '',
      'onTap': () {},
    },
    {
      'icon': Icons.cloud_upload_outlined,
      'title': 'Tải lên',
      'subtitle': '',
      'onTap': (context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UploadScreen(),
          ),
        );
      },
    },
  ];
  @override
  Widget build(BuildContext context) {
    return //personal
        Container(
      height: 110,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          itemCount: 3,
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 20),
              child: RectangleCard(
                icon: items[index]['icon'],
                title: items[index]['title'],
                subtitle: items[index]['subtitle'],
                onTap: () => items[index]['onTap'](context),
              ),
            );
          }),
    );
  }
}
