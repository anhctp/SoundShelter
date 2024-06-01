import 'package:flutter/material.dart';
import 'package:mobile/components/card/custom_card.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/module/playlist-screen/album_screen.dart';
import 'package:mobile/provider/album_provider.dart';
import 'package:provider/provider.dart';

class DetailGenreScreen extends StatefulWidget {
  final int genreId;
  final String label;
  const DetailGenreScreen(
      {super.key, required this.genreId, required this.label});

  @override
  State<DetailGenreScreen> createState() => _DetailGenreScreenState();
}

class _DetailGenreScreenState extends State<DetailGenreScreen> {
  @override
  void initState() {
    super.initState();
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    albumProvider.getAlbumsByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(title: widget.label),
      extendBodyBehindAppBar: true,
      body: Consumer<AlbumProvider>(builder: (context, albumProvider, child) {
        return Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
            children: List.generate(
              albumProvider.albums.length,
              (index) {
                final album = albumProvider.albums[index];
                return CustomCard(
                    onTap: () {
                      print("object");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumScreen(
                            name: album.title,
                            albumId: album.id,
                            imgFilePath: album.imageFilePath,
                          ),
                        ),
                      );
                    },
                    title: album.title,
                    imgFilePath: album.imageFilePath);
              },
            ),
          ),
        );
      }),
    );
  }
}
