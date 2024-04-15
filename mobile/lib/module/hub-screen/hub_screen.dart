import 'package:flutter/material.dart';

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HubScreenState();
  }
}

class HubScreenState extends State<HubScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('Hub Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }
}
