import 'package:flutter/material.dart';

class TabName extends StatefulWidget {
  final String name;
  final VoidCallback? onPressed;
  const TabName({super.key, required this.onPressed, required this.name});

  @override
  State<TabName> createState() => _TabNameState();
}

class _TabNameState extends State<TabName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Text(
            widget.name,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Color(0xFFB2572B),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFFB2572B),
            ),
            onPressed: widget.onPressed,
          )
        ],
      ),
    );
  }
}
