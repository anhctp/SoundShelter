import 'package:flutter/material.dart';
import 'package:mobile/provider/album_provider.dart';
import 'package:provider/provider.dart';

class DetailGenreScreen extends StatefulWidget {
  final int genreId;
  final String label;
  const DetailGenreScreen({super.key, required this.genreId, required this.label});

  @override
  State<DetailGenreScreen> createState() => _DetailGenreScreenState();
}

class _DetailGenreScreenState extends State<DetailGenreScreen> {
  @override
  void initState() {
    super.initState();
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    albumProvider.getAlbumsByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        backgroundColor: const Color(0xFFECE6D6),
        title: Text(
          widget.label,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
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
      ),
      extendBodyBehindAppBar: true,
      body: Consumer<AlbumProvider>(builder: (context, albumProvider, child) {
        return GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(
            albumProvider.albums.length,
            (index) {
              return Center(
                  child: Card(
                shadowColor: Colors.grey,
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          //insert img
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                10,
                              ),
                              topRight: Radius.circular(
                                10,
                              ),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                albumProvider.albums[index].imageFilePath,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //insert name
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Text(albumProvider.albums[index].title),
                      ),
                    ],
                  ),
                ),
              ));
            },
          ),
        );
      }),
    );
  }
}
