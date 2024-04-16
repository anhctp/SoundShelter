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
      height: 100,
      child: ListView.builder(
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = widget.items[index % widget.items.length];
          return SizedBox(
            width: MediaQuery.of(context).size.width / 3 * 2,
            child: AnimatedDetailCard(
              key: ValueKey(index),
              title: item['title'],
              artist: item['artist'],
              releaseDate: item['release_date'],
              image: item['image_file_path'],
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
                Image.asset(
                  "assets/guitar.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                Container(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 5),
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFFB2572B),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(height: 5),
                      Text(
                        widget.artist,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFFB2572B)),
                      ),
                      Container(height: 10),
                      Text(
                        widget.releaseDate,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFFB2572B)),
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
