import 'package:flutter/material.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/playlist-screen/create_playlist_modal.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';

class SmallSquareCard extends StatefulWidget {
  final Song song;
  final dynamic songProvider;
  final int index;
  final List<Song> playlist;
  const SmallSquareCard(
      {super.key,
      required this.song,
      required this.songProvider,
      required this.index,
      required this.playlist});

  @override
  State<SmallSquareCard> createState() => _SmallSquareCardState();
}

class _SmallSquareCardState extends State<SmallSquareCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          builder: (context) => CreatePlaylistModal(
            currentSong: widget.song,
            songProvider: widget.songProvider,
            add: true,
          ),
        );
      },
      child: Container(
        width: 95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 95,
              width: 95,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.song.imageFilePath),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.song.title,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            Text(
              widget.song.artist,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
