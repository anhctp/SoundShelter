import 'package:flutter/material.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/playlist-screen/create_playlist_modal.dart';
import 'package:mobile/module/song-screen/full_playing_view.dart';

class MusicItem extends StatefulWidget {
  final dynamic songProvider;
  final Song song;
  final int index;
  final List<Song> playlist;
  final bool add;
  const MusicItem(
      {super.key,
      required this.songProvider,
      required this.song,
      required this.add,
      required this.index,
      required this.playlist});

  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
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
            add: widget.add,
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 70,
            width: 70,
            //insert img
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  //darker shadow on bottom right
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 15,
                    offset: const Offset(4, 4),
                  ),

                  //lighter shadow on top left
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 15,
                    offset: const Offset(-4, -4),
                  ),
                ],
              ),
              child: Image.network(
                widget.song.imageFilePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => CreatePlaylistModal(
                  currentSong: widget.song,
                  songProvider: widget.songProvider,
                  add: widget.add,
                ),
              );
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
