import 'package:flutter/material.dart';
import 'package:mobile/components/box/neu_box.dart';
import 'package:mobile/model/song_model.dart';

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
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            //add favorite
                            InkWell(
                              onTap: () {
                                if (widget.songProvider.user != null) {
                                  widget.songProvider
                                      .createFavorite(widget.currentSong.id!);
                                }
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
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
