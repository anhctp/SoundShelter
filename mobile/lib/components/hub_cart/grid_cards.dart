import 'package:flutter/material.dart';
import 'package:mobile/module/hub-screen/detail_genre_screen.dart';
import 'package:mobile/components/hub_cart/hub_card.dart';
import 'package:mobile/provider/album_provider.dart';
import 'package:provider/provider.dart';

class GridCards extends StatefulWidget {
  final int genreId;
  final String label;
  const GridCards({super.key, required this.genreId, required this.label});

  @override
  State<GridCards> createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  @override
  void initState() {
    super.initState();
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    albumProvider.getAlbumsByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(builder: (context, albumProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child:
            //Horizontal Grid
            Container(
          height: 200,
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 0,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: albumProvider.albums.length < 5
                  ? albumProvider.albums.length
                  : 5, // 1 for the last index button
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                //last index button
                return index == 4
                    ? TextButton(
                        onPressed: () {
                          print('Xem tat ca');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailGenreScreen(
                                      genreId: widget.genreId,
                                      label: widget.label,
                                    )),
                          );
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xFFB2572B),
                              ),
                              Text(
                                'Xem tất cả',
                                style: TextStyle(
                                  color: Color(0xFFB2572B),
                                ),
                              ),
                            ]),
                      )
                    : HubCard(
                        imageFilePath:
                            albumProvider.albums[index].imageFilePath,
                        albumTitle: albumProvider.albums[index].title,
                      );
              }),
        ),
      );
    });
  }
}
