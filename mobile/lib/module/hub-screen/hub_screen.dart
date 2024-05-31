import 'package:flutter/material.dart';
import 'package:mobile/components/hub_cart/grid_cards.dart';
import 'package:mobile/components/title/tab_name.dart';
import 'package:mobile/module/hub-screen/detail_genre_screen.dart';
import 'package:mobile/provider/genre_provider.dart';
import 'package:provider/provider.dart';

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HubScreenState();
  }
}

class HubScreenState extends State<HubScreen> {
  @override
  void initState() {
    super.initState();
    final genreProvider = Provider.of<GenreProvider>(context, listen: false);
    genreProvider.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6D6),
        title: Text(
          "Chủ đề",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://photo-zmp3.zmdcdn.me/cover/c/9/b/3/c9b3c456eeabd9d4e3241666397d71aa.jpg"),
                ),
              ),
            ),
            Consumer<GenreProvider>(
              builder: (context, genreProvider, child) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: genreProvider.albums.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final item = genreProvider.albums[index];
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TabName(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailGenreScreen(
                                      label: item['genre'].name,
                                      genreId: item['genre'].id,
                                    ),
                                  ),
                                );
                              },
                              name: item['genre'].name),
                          GridCards(
                              items: item['album'],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailGenreScreen(
                                      label: item['genre'].name,
                                      genreId: item['genre'].id,
                                    ),
                                  ),
                                );
                              })
                        ]);
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
