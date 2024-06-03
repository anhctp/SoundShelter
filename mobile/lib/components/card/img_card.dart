import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  final String name;
  final String imgFilePath;
  const ImageCard({super.key, required this.name, required this.imgFilePath});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.imgFilePath),
        ),
      ),
      child: Center(
        child: Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
