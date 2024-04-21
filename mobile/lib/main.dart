import 'package:flutter/material.dart';
import 'package:mobile/Provider/playlist_provider.dart';
import 'package:mobile/provider/album_provider.dart';
import 'package:mobile/provider/genre_provider.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';
import 'module/home-screen/home_screen.dart';

void main() {
  runApp(
      /*
        //Create an Array consisting of all your ChangeNotifiers
        List<ChangeNotifier>_providersArray = [PlaylistProvider, SongProvider];

        // This will be your array of Providers, which you will add to Mutliprovider(providers: HERE)
        List<Provider> providers = []; // make sure you have the right type of the List<>, which the `providers` in `Multiproviders` accepts

        for(var provider in _providersArray){
          //adding the provider name to the ChangeNotifier
          providers.add(ChangeNotifierProvider<provider>( create: (_) => provider()));
        }
        MultiProvider(
          providers: providers,
          child: Container()
        )
    */
      MultiProvider(
          providers: [
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
      ],
          child: MaterialApp(
            title: 'SoundShelter',
            home: const HomeScreen(),
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
          )));
}
