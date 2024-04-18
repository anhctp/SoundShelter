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
      "views": 1
    },
    {
      "id": 26,
      "title": "SHEESH",
      "artist": "BABYMONSTER",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/d845aa6118afd9b3d30ac765c5dd3822?authen=exp=1712396439~acl=/d845aa6118afd9b3d30ac765c5dd3822/*~hmac=ff9aa5440edd86f8cfdc60e626f1e158",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/7/5/7/0/757066fd14564def41090e79f9bfa3e9.jpg",
      "album_id": 27,
      "playlist_id": 32,
      "release_date": "31/03/2024",
      "views": 0
    },
    {
      "id": 54,
      "title": "LIKE THAT",
      "artist": "BABYMONSTER",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/1d6cba84effb35f25bee86d6f388ecf4?authen=exp=1712396897~acl=/1d6cba84effb35f25bee86d6f388ecf4/*~hmac=d1cbce9d386299e7fd668775ab88d5b4",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/7/5/7/0/757066fd14564def41090e79f9bfa3e9.jpg",
      "album_id": 27,
      "playlist_id": 32,
      "release_date": "31/03/2024",
      "views": 0
    },
    {
      "id": 63,
      "title": "MAY MẮN",
      "artist": "Nhiều nghệ sĩ",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/5c29aa94d452eafdab55a26b6fc3d176?authen=exp=1712396592~acl=/5c29aa94d452eafdab55a26b6fc3d176/*~hmac=24c136cad551a00202bb12bcf0145d1b",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/f/8/f/c/f8fc5bd06a4459e12ade5b1e531baf1b.jpg",
      "album_id": 65,
      "playlist_id": 83,
      "release_date": "30/03/2024",
      "views": 1
    },
    {
      "id": 49,
      "title": "Kết Duyên Trọn Đời",
      "artist": "Tiến Tới",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/c38cb68977c384631ca478a1b371a879?authen=exp=1712396827~acl=/c38cb68977c384631ca478a1b371a879/*~hmac=4a5614dbc7ac1a6d0b3f30c64ff49e69",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/6/4/2/c/642c896c78e5539790ff6517b61910d0.jpg",
      "album_id": 52,
      "playlist_id": 66,
      "release_date": "30/03/2024",
      "views": 0
    },
    {
      "id": 30,
      "title": "Đánh Cắp Mặt Trời",
      "artist": "Nhiều nghệ sĩ",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/38adf350310cbda8b48f49e2425585e2?authen=exp=1712396338~acl=/38adf350310cbda8b48f49e2425585e2/*~hmac=4539b5255cea0dc45385f7fdc5e71307",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/3/4/1/3/34137b256acfb7772782698c5011f814.jpg",
      "album_id": 31,
      "playlist_id": 39,
      "release_date": "29/03/2024",
      "views": 0
    },
    {
      "id": 38,
      "title": "Mỉm Cười Mà Khóc Trong Lòng",
      "artist": "Lynk Lee",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/c74fdb8c8ebfd2e0a8e90e3ce867bbcf?authen=exp=1712396433~acl=/c74fdb8c8ebfd2e0a8e90e3ce867bbcf/*~hmac=10a343c250b4d4d1db867dc8b883305a",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/a/f/a/b/afabcd2a55ac9dd42241ad0774e2c9b5.jpg",
      "album_id": 40,
      "playlist_id": 54,
      "release_date": "28/03/2024",
      "views": 0
    },
    {
      "id": 20,
      "title": "Hóa Ra Lại Hay",
      "artist": "Aki Khoa, Đông Thiên Đức",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/3be819b9d8f816f64246e3e2382761c5?authen=exp=1712396772~acl=/3be819b9d8f816f64246e3e2382761c5/*~hmac=3d27757b08f44dcef8db188afe1cb5b5",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/8/8/5/8/88587923c04ae5d51ba47cdf132e1d76.jpg",
      "album_id": 21,
      "playlist_id": 26,
      "release_date": "28/03/2024",
      "views": 0
    },
    {
      "id": 60,
      "title": "Tâm Trí Em",
      "artist": "Linh Ka, RZ Mas",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/2f80d95683d2b694dd359b6cb6cced71?authen=exp=1712396845~acl=/2f80d95683d2b694dd359b6cb6cced71/*~hmac=d66559607c5fc43de2f41a73d1fed823",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/5/e/1/1/5e114de6a304825cfb2d3ae9f9f1de8c.jpg",
      "album_id": 62,
      "playlist_id": 77,
      "release_date": "27/03/2024",
      "views": 0
    },
    {
      "id": 68,
      "title": "Anh Lại Làm Em Khóc Nữa Rồi",
      "artist": "Khiem",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/49b76f690dc13c06e7f25df11ead8102?authen=exp=1712396499~acl=/49b76f690dc13c06e7f25df11ead8102/*~hmac=e595315375fd04240525d979e0b575f4",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/0/f/f/8/0ff89c459daee46e3845351239e2b9f7.jpg",
      "album_id": 70,
      "playlist_id": 92,
      "release_date": "27/03/2024",
      "views": 0
    },
    {
      "id": 95,
      "title": "Biết Đâu (Chưa Chắc)",
      "artist": "Bảo Hân, Kim Kim Gà",
      "audio_file_path":
          "https://a128-z3.zmdcdn.me/9a274944bb6dbd42950ec4dfd1549c55?authen=exp=1712396547~acl=/9a274944bb6dbd42950ec4dfd1549c55/*~hmac=c222860c341a6e35e0ff6ad533a56e8c",
      "image_file_path":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/4/5/b/4/45b4f0d9f540916c13e38cae5e4d5ebd.jpg",
      "album_id": 97,
      "playlist_id": 123,
      "release_date": "26/03/2024",
      "views": 0
    }
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
