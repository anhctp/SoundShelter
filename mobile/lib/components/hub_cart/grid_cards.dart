import 'package:flutter/material.dart';
import 'package:mobile/components/button/see_all_button.dart';
import 'package:mobile/components/card/custom_card.dart';
import 'package:mobile/model/album_model.dart';

class GridCards extends StatefulWidget {
  final GestureTapCallback onTap;
  final List<Album> items;
  const GridCards({super.key, required this.items, required this.onTap});

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.width / 2,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 15,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length < 5
            ? widget.items.length
            : 5, // 1 for the last index button
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final item = widget.items[index];
          //last index button
          return index == 4
              ? SeeAllButton(onTap: widget.onTap)
              : CustomCard(imgFilePath: item.imageFilePath, title: item.title);
        },
      ),
    );
  }
}
