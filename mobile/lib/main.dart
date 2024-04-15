import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'SoundShelter',
    home: HomeScreen(),
    theme: ThemeData(
      primaryColor: const Color(0xFFB2572B),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFFB2572B),
        secondary: const Color(0xFFECE6D6),
        onSecondary: const Color(0xFFF4F1E7),
        background: const Color(0xFFDCD1B3),
        onBackground: const Color(0xFFD6ACAE),
      ),
    ),
  ));
}
