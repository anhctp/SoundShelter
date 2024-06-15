import 'package:flutter/material.dart';

class MyAlert extends StatefulWidget {
  final String content;
  const MyAlert({super.key, required this.content});

  @override
  State<MyAlert> createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Icon(Icons.notifications_on_rounded),
      content: Text(
        widget.content,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
