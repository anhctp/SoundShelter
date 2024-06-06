import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String imgFilePath;
  final GestureTapCallback onTap;
  const CustomCard(
      {super.key,
      required this.title,
      required this.imgFilePath,
      required this.onTap});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 50,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 10,
              height: MediaQuery.of(context).size.width / 2 - 50,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.imgFilePath),
                ),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                widget.title,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff371b0d),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
