import 'package:flutter/material.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: FullPlayingView(),
        ),
      ],
    );
  }
}
