import 'package:flutter/material.dart';
import 'package:mobile/components/card/custom_card.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/model/playlist_model.dart';
import 'package:mobile/module/playlist-screen/playlist_screen.dart';

class NoticeableScreen extends StatefulWidget {
  final List<Playlist> playlists;
  const NoticeableScreen({super.key, required this.playlists});

  @override
  State<NoticeableScreen> createState() => _NoticeableScreenState();
}

class _NoticeableScreenState extends State<NoticeableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(title: "Đáng chú ý"),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85,
          children: List.generate(
            widget.playlists.length,
            (index) {
              final playlist = widget.playlists[index];
              return CustomCard(
                  onTap: () {
                    print("object");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayListScreen(
                          name: playlist.name,
                          playlistId: playlist.id,
                          imgFilePath: playlist.imageFilePath,
                        ),
                      ),
                    );
                  },
                  title: playlist.name,
                  imgFilePath: playlist.imageFilePath);
            },
          ),
        ),
      ),
    );
  }
}
