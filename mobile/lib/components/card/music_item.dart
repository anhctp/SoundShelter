import 'package:flutter/material.dart';

class MusicItem extends StatefulWidget {
  final String name;
  final String imgFilePath;
  final String artist;
  final GestureTapCallback? onTap;
  const MusicItem(
      {super.key,
      required this.name,
      required this.imgFilePath,
      required this.artist,
      required this.onTap});

  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 70,
              width: 70,
              //insert img
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    //darker shadow on bottom right
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 15,
                      offset: const Offset(4, 4),
                    ),

                    //lighter shadow on top left
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 15,
                      offset: const Offset(-4, -4),
                    ),
                  ],
                ),
                child: Image.network(
                  widget.imgFilePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    widget.artist,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                print('more');
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
