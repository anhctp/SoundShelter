import 'package:flutter/material.dart';
import 'package:mobile/components/box/neu_box.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/playlist-screen/create_playlist_modal.dart';

class SongDetail extends StatefulWidget {
  final Song currentSong;
  final dynamic songProvider;
  const SongDetail(
      {super.key, required this.currentSong, required this.songProvider});

  @override
  State<SongDetail> createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  @override
  Widget build(BuildContext context) {
    return Neubox(
      child: Column(
        children: [
          //img
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(widget.currentSong.imageFilePath),
          ),

          //song and artist name and icon
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //song and artist name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 240,
                      child: Text(
                        widget.currentSong.title,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 240,
                      child: Text(
                        widget.currentSong.artist,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                //more icon
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: this.context,
                      builder: (context) => CreatePlaylistModal(
                        currentSong: widget.currentSong,
                        songProvider: widget.songProvider,
                        add: true,
                      ),
                    );
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
