import 'package:flutter/material.dart';
import 'package:mobile/module/hub-screen/detail_genre_screen.dart';

class GenreName extends StatelessWidget {
  final String label;
  final int genreId;
  const GenreName({super.key, required this.label, required this.genreId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flex(direction: Axis.horizontal, children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Color(0xFFB2572B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFFB2572B),
            ),
            onPressed: () {
              print("Title");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailGenreScreen(
                          genreId: genreId,
                          label: label,
                        )),
              );
            },
          )
        ]),
      ],
    );
  }
}
