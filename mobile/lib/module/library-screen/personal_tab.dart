import 'package:flutter/material.dart';
import 'package:mobile/components/card/rectangle_card.dart';

class PersonalTab extends StatefulWidget {
  const PersonalTab({super.key});

  @override
  State<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
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
                icon: Icons.download,
                title: "title",
                subtitle: "subtitle",
                onTap: () {},
              ),
            );
          }),
    );
  }
}
