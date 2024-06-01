import 'package:flutter/material.dart';
import 'package:mobile/module/song-screen/song_screen.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(
      builder: (context, songProvider, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: 'Nhập tên bài hát',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _textEditingController,
                    onChanged: (value) {
                      songProvider.findSong(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: ListView.separated(
            key: UniqueKey(),
            padding: EdgeInsets.symmetric(vertical: 10),
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 15,
              );
            },
            shrinkWrap: true,
            itemCount: songProvider.songs.length,
            itemBuilder: (BuildContext context, int index) {
              final song = songProvider.songs[index];
              return Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        songProvider.currentSongIndex = index;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongScreen(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0),
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(45)),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(song.imageFilePath),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 70,
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        song.artist,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
