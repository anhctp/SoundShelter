import 'package:flutter/material.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';

class BigSquareCard extends StatefulWidget {
  final Song song;
  final dynamic songProvider;
  final int index;
  final List<Song> playlist;
  const BigSquareCard(
      {super.key,
      required this.song,
      required this.songProvider,
      required this.index,
      required this.playlist});

  @override
  State<BigSquareCard> createState() => _BigSquareCardState();
}

class _BigSquareCardState extends State<BigSquareCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 10,
      child: GestureDetector(
        onTap: () {
          widget.songProvider.setPlayingSongs(widget.playlist);
          widget.songProvider.currentSongIndex = widget.index;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullPlayingView(),
            ),
          );
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  //add favorite
                  InkWell(
                    onTap: () {
                      widget.songProvider.createFavorite(widget.song.id!);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300),
                      width: double.infinity,
                      child: Text(
                        'Thêm vào danh sách yêu thích',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //add your playlist
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300),
                      width: double.infinity,
                      child: Text(
                        'Thêm vào playlist',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 2 - 30,
              width: MediaQuery.of(context).size.width / 2 - 10,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.song.imageFilePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.song.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              widget.song.artist,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
