import 'package:flutter/material.dart';
import 'package:mobile/components/hub_cart/genre_name.dart';
import 'package:mobile/components/hub_cart/grid_cards.dart';
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
      body: Consumer<GenreProvider>(
        builder: (context, genreProvider, child) {
          return Container(
              child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: genreProvider.albums.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final item = genreProvider.albums[index];
              return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                GenreName(
                  label: item['genre'].name,
                  genreId: item['genre'].id,
                ),
                GridCards(
                    items: item['album'],
                    detailChild: DetailGenreScreen(
                      label: item['genre'].name,
                      genreId: item['genre'].id,
                    ))
              ]);
            },
          ));
        },
      ),
    );
  }
}
