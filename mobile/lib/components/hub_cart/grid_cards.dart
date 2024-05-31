import 'package:flutter/material.dart';
import 'package:mobile/components/card/custom_card.dart';
import 'package:mobile/model/album_model.dart';

class GridCards extends StatefulWidget {
  final VoidCallback onPressed;
  final List<Album> items;
  const GridCards({super.key, required this.items, required this.onPressed});

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child:
          //Horizontal Grid
          Container(
        height: 200,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 0,
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
                ? TextButton(
                    onPressed: widget.onPressed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFFB2572B),
                        ),
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Color(0xFFB2572B),
                          ),
                        ),
                      ],
                    ),
                  )
                : CustomCard(
                    imgFilePath: item.imageFilePath, title: item.title);
          },
        ),
      ),
    );
  }
}
