import 'package:flutter/material.dart';
import 'package:mobile/components/card/big_square_card.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class RecommendScreen extends StatefulWidget {
  final List<Song> songs;
  const RecommendScreen({super.key, required this.songs});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Gợi ý cho bạn",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          return Container(
            padding: EdgeInsets.all(10),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
              children: List.generate(
                widget.songs.length,
                (index) {
                  final song = widget.songs[index];
                  return BigSquareCard(
                    song: song,
                    songProvider: songProvider,
                    index: index,
                    playlist: widget.songs,
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
