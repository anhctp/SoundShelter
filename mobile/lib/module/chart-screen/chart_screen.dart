import 'package:flutter/material.dart';
import 'package:mobile/model/song_model.dart';
import 'package:mobile/module/hub-screen/song_screen.dart';
import 'package:mobile/provider/song_provider.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChartScreenState();
  }
}

class ChartScreenState extends State<ChartScreen> with SingleTickerProviderStateMixin {

  late final dynamic songProvider;

  @override
  void initState() {
    super.initState();
    songProvider =
        Provider.of<SongProvider>(context, listen: false);
    songProvider.getSongsRank();
  }

  
  void goToSong(int songIndex) {
    //update current song index
    songProvider.currentSongIndex = songIndex;

    //navigate to song page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongScreen()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFECE6D6),
          title: Text(
            "Bảng xếp hạng",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          actions: const [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFFB2572B),
              ),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        backgroundColor: const Color(0xFFDCD1B3),
        body: Consumer<SongProvider>(
          builder: (context, songProvider, child) {
            return ListView.separated(
                padding: EdgeInsets.all(10.0),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                scrollDirection: Axis.vertical,
                itemCount: songProvider.songs.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final Song song = songProvider.songs[index];
                  /*
            return ListTile(
              title: Text(song.title,overflow: TextOverflow.ellipsis,),
              subtitle: Text(song.artist),
              leading: Image.network(song.imageFilePath),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  //personal
                },
              ),
              onTap: () {
                //play
              },
            );
            */
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        goToSong(index);
                        print('play');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("${index + 1}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              height: 70,
                              //insert img
                              child: Image.network(song.imageFilePath)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  song.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  song.artist,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                          /*
                    IconButton(
                      onPressed: () => null,
                      icon: Icon(Icons.favorite_border),
                    ),
                    */
                          IconButton(
                            onPressed: () {
                              print('more');
                            },
                            icon: Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}