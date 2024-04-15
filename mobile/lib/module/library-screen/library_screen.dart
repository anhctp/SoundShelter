import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LibraryScreenState();
  }
}

class LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('Library Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }
}
