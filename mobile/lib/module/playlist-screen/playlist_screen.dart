import 'package:flutter/material.dart';
import 'package:mobile/components/card/music_item.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SafeArea(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "playlist!.title!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "playlist!.sortDescription!",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  ListView.builder(
                    itemBuilder: (_, index) {
                      return InkWell(
                          onTap: () {},
                          child: MusicItem(
                            name: "name",
                            imgFilePath:
                                "https://photo-cms-baophapluat.zadn.vn/w800/Uploaded/2022/ycgvptcc/2019_07_26/b_jpg_GIDP.jpg",
                            artist: "artist",
                            onTap: () {},
                          ));
                    },
                    itemCount: 5, //playlist!.songs!.length
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
