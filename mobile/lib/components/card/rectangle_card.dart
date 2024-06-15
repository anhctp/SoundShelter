import 'package:flutter/material.dart';

class RectangleCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final dynamic subtitle;
  final GestureTapCallback? onTap;
  const RectangleCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  State<RectangleCard> createState() => _RectangleCardState();
}

class _RectangleCardState extends State<RectangleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 90,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.subtitle),
          ],
        ),
      ),
    );
  }
}
