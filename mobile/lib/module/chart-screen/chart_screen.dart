import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChartScreenState();
  }
}

class ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('Chart Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }
}
