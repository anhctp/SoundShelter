import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/detail-screen/new_feature_screen.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class NewFeatureTab extends StatefulWidget {
  const NewFeatureTab({super.key});

  @override
  State<NewFeatureTab> createState() => _NewFeatureTabState();
}

class _NewFeatureTabState extends State<NewFeatureTab> {
  @override
  void initState() {
    super.initState();
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    songProvider.getNewestSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabName(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewFeatureScreen(
                          songs: songProvider.newestSongs,
                        ),
                      ),
                    );
                  },
                  name: "Mới phát hành"),
              Container(
                height: 250,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  padding: const EdgeInsets.all(2),
                  childAspectRatio: 0.22,
                  children: List.generate(
                    songProvider.newestSongs.length,
                    (index) {
                      final song = songProvider.newestSongs[index];
                      return MusicItem(
                          songProvider: songProvider,
                          song: song,
                          add: true,
                          index: index,
                          playlist: songProvider.newestSongs);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
