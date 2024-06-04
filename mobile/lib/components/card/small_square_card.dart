import 'package:flutter/material.dart';

class SmallSquareCard extends StatefulWidget {
  final String title;
  final String imgFilePath;
  final GestureTapCallback? onTap;
  const SmallSquareCard(
      {super.key,
      required this.title,
      required this.imgFilePath,
      required this.onTap});

  @override
  State<SmallSquareCard> createState() => _SmallSquareCardState();
}

class _SmallSquareCardState extends State<SmallSquareCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 95,
              width: 95,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.imgFilePath),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
