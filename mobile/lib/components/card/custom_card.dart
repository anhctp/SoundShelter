import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String imgFilePath;
  const CustomCard({super.key, required this.title, required this.imgFilePath});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
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
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.imgFilePath,
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
                child: Text(widget.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
