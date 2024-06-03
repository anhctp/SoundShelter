import 'package:flutter/material.dart';
import 'package:mobile/Provider/playlist_provider.dart';
import 'package:mobile/components/expanding-card/expanding_card.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/noticeable_screen.dart';
import 'package:provider/provider.dart';

class NoticeableTab extends StatefulWidget {
  const NoticeableTab({super.key});

  @override
  State<NoticeableTab> createState() => _NoticeableTabState();
}

class _NoticeableTabState extends State<NoticeableTab> {
  @override
  void initState() {
    super.initState();
    final playlistProvider =
        Provider.of<PlaylistProvider>(context, listen: false);
    playlistProvider.getAllPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, playlistProvider, child) {
        return Column(
          children: [
            TabName(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticeableScreen(
                        playlists: playlistProvider.playlists,
                      ),
                    ),
                  );
                },
                name: "Đáng chú ý"),
            Consumer<PlaylistProvider>(
              builder: (context, playlistProvider, child) {
                return FittedBox(
                  fit: BoxFit.fitWidth,
                  child: ExpandingCards(
                    height: 400,
                    items: playlistProvider.playlists.length > 6
                        ? playlistProvider.playlists.sublist(0, 6)
                        : playlistProvider.playlists,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
