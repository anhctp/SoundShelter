import 'package:flutter/material.dart';

class BigSquareCard extends StatefulWidget {
  final String imgFilePath;
  final String title;
  final String subtitle;
  final bool subtext;
  final GestureTapCallback? onTap;
  const BigSquareCard(
      {super.key,
      required this.imgFilePath,
      required this.title,
      required this.subtitle,
      required this.subtext,
      required this.onTap});

  @override
  State<BigSquareCard> createState() => _BigSquareCardState();
}

class _BigSquareCardState extends State<BigSquareCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 10,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 2 - 30,
              width: MediaQuery.of(context).size.width / 2 - 10,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.imgFilePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.subtitle,
              overflow: TextOverflow.ellipsis,
            ),
            widget.subtext == true
                ? const Text("data") //Text(json[index]["subtext"])
                : Container()
          ],
        ),
      ),
    );
  }
}
