import 'package:flutter/material.dart';

class DetailCard extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const DetailCard({super.key, required this.items});

  @override
  State<StatefulWidget> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        itemCount: (widget.items.length + 2) ~/ 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, pageIndex) {
          int startIndex = pageIndex * 3;
          List<Widget> columnItems = [];
          for (int i = startIndex;
              i < startIndex + 3 && i < widget.items.length;
              i++) {
            final item = widget.items[i];
            columnItems.add(
              Expanded(
                child: AnimatedDetailCard(
                  key: ValueKey(i),
                  title: item['title'],
                  artist: item['artist'],
                  releaseDate: item['release_date'],
                  image: item['image_file_path'],
                ),
              ),
            );
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width / 3 * 2,
            child: Column(
              children: columnItems,
            ),
          );
        },
      ),
    );
  }
}

class AnimatedDetailCard extends StatefulWidget {
  final String title;
  final String artist;
  final String releaseDate;
  final String image;

  const AnimatedDetailCard(
      {super.key,
      required this.title,
      required this.artist,
      required this.image,
      required this.releaseDate});

  @override
  State<StatefulWidget> createState() => _AnimatedDetailCardState();
}

class _AnimatedDetailCardState extends State<AnimatedDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  widget.image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                Container(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 4),
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFFB2572B),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(height: 3),
                      Text(
                        widget.artist,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFFB2572B), fontSize: 12),
                      ),
                      Container(height: 3),
                      Text(
                        widget.releaseDate,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFFB2572B), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
