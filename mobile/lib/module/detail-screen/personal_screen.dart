import 'package:flutter/material.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});
  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  void initState() {
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.downloadedSongs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScreenHeader(title: "Bài hát đã tải"),
        body: Consumer<SongProvider>(
          builder: (context, songProvider, child) {
            return ListView.builder(
              itemCount: songProvider.downloadedSongs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: songProvider.downloadedSongs[index].imageFilePath,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(songProvider.downloadedSongs[index].title),
                  subtitle: Text(songProvider.downloadedSongs[index].artist),
                  onTap: () {
                    songProvider.setPlayingSongs(songProvider.downloadedSongs);
                    songProvider.currentSongIndex = index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullPlayingView(),
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
