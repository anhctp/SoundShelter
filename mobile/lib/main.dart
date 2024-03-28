import 'package:flutter/material.dart';

void main() {
  runApp(
   MaterialApp(
      title: 'SoundShelter',
      home: SoundShelterHome(),
      theme: ThemeData(
        primaryColor: Color(0xFFB2572B),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFB2572B),
        ),
      ),
    ),
  );
}

class SoundShelterHome extends StatelessWidget {
  const SoundShelterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('SoundShelter'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add',
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}