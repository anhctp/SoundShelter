import 'package:flutter/material.dart';
import 'package:mobile/components/card/big_square_card.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/song-screen/song_screen.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class NewFeatureScreen extends StatefulWidget {
  final List<Song> songs;
  const NewFeatureScreen({super.key, required this.songs});

  @override
  State<NewFeatureScreen> createState() => _NewFeatureScreenState();
}

class _NewFeatureScreenState extends State<NewFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Mới phát hành",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          return Container(
            padding: EdgeInsets.all(10),
            child: GridView.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              children: List.generate(
                widget.songs.length,
                (index) {
                  final song = widget.songs[index];
                  return BigSquareCard(
                    onTap: () {
                      songProvider.setPlayingSongs();
                      songProvider.currentSongIndex = index;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongScreen(),
                        ),
                      );
                    },
                    title: song.title,
                    subtitle: song.artist,
                    subtext: false,
                    imgFilePath: song.imageFilePath,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
