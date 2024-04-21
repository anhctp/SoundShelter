import 'package:flutter/material.dart';

class HubCard extends StatelessWidget {
  final String imageFilePath;
  final String albumTitle;
  const HubCard(
      {super.key, required this.imageFilePath, required this.albumTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 150,
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
                      imageFilePath,
                    ),
                  ),
                ),
              ),
            ),
            //insert name
            Container(
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Text(albumTitle),
            ),
          ],
        ),
      ),
    );
  }
}
