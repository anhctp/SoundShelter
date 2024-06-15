import 'package:flutter/material.dart';
import 'package:mobile/Provider/playlist_provider.dart';
import 'package:mobile/provider/album_provider.dart';
import 'package:mobile/provider/genre_provider.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:mobile/provider/upload_provider.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'module/home-screen/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaylistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SongProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GenreProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AlbumProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'SoundShelter',
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
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
      ),
    ),
  );
}
