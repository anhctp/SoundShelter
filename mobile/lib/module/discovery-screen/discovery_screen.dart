import 'package:flutter/material.dart';
import 'package:mobile/components/detail-card/detail_card.dart';
import 'package:mobile/components/expanding-card/expanding_card.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return DiscoveryScreenState();
  }
}

class DiscoveryScreenState extends State<DiscoveryScreen> {
  final List<Map<String, dynamic>> attractives = [
    {
      "code": "ZOEIUO67",
      "name": "Những Bài Hát Hay Nhất Của Quang Hùng MasterD",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/3/d/a/3/3da353f1fd239f48e5ae0e0944cbd64b.jpg",
      "id": 1,
      "user_id": "null"
    },
    {
      "code": "ZWZAEBZF",
      "name": "Những Bài Hát Hay Nhất Của Phan Mạnh Quỳnh",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/2/6/c/1/26c183e222c00c5d7e9c9465ad7c058c.jpg",
      "id": 2,
      "user_id": "null"
    },
    {
      "code": "ZWZADD7O",
      "name": "Những Bài Hát Hay Nhất Của Bích Phương",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/7/0/3/7/703744e065218ee5a009bd7ee4d460e9.jpg",
      "id": 3,
      "user_id": "null"
    },
    {
      "code": "6UW9B0CW",
      "name": "Những Bài Hát Hay Nhất Của Quang Đăng Trần",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/4/6/0/8/46088d1e73d648d26ec20a0203b0092c.jpg",
      "id": 4,
      "user_id": "null"
    },
    {
      "code": "6UW9CWC9",
      "name": "Những Bài Hát Hay Nhất Của ACV",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/images/4/4/5/9/445914982fb82b5b7eb4976b5989ba2f.jpg",
      "id": 5,
      "user_id": "null"
    },
    {
      "code": "ZOU8DC8Z",
      "name": "Những Bài Hát Hay Nhất Của Vũ Cát Tường",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w320_r1x1_jpeg/cover/9/2/c/c/92ccc5177f2bafd85ab2a50884410af5.jpg",
      "id": 6,
      "user_id": "null"
    },
  ];
  final List<Map<String, dynamic>> newestSongs = [
    {
      "id": 29,
      "title": "Tình Yêu Không Chung Lối",
      "artist": "Đan Trường, Lương Bích Hữu",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/803e795374f0749bccd8655659641c6a?authen=exp=1712396487~acl=/803e795374f0749bccd8655659641c6a/*~hmac=2576722e1b95096cbcd5350c9b214730",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/3/2/0/d/320d87ed5fc4e25f3dc8556ea376e041.jpg",
      "album_id": 30,
      "playlist_id": 37,
      "release_date": "02/04/2024",
      "views": 2
    },
    {
      "id": 31,
      "title": "Thời Gian Sẽ Chữa Lành Tất Cả",
      "artist": "Lâm Phúc",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/57965af63f6dc1f677abc3ef5ae64ad1?authen=exp=1712396462~acl=/57965af63f6dc1f677abc3ef5ae64ad1/*~hmac=55bbd9565b3dab708550005123c07016",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/2/8/8/f/288f67fd6d35033abcec0d783ab477ab.jpg",
      "album_id": 32,
      "playlist_id": 44,
      "release_date": "01/04/2024",
      "views": 0
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6D6),
        title: Text(
          "Khám phá",
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Flex(direction: Axis.horizontal, children: [
                      const Text(
                        "Đáng chú ý",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color(0xFFB2572B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Color(0xFFB2572B),
                        ),
                        onPressed: () {
                          print("Dang chu y");
                        },
                      )
                    ])),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: ExpandingCards(
                    height: 400,
                    items: attractives,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Flex(direction: Axis.horizontal, children: [
                      const Text(
                        "Mới phát hành",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color(0xFFB2572B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Color(0xFFB2572B),
                        ),
                        onPressed: () {
                          print("Mới phát hành");
                        },
                      )
                    ])),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DetailCard(items: newestSongs)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
