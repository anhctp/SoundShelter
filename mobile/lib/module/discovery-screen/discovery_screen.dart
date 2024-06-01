import 'package:flutter/material.dart';
//import 'package:mobile/components/detail-card/detail_card.dart';
import 'package:mobile/module/discovery-screen/noticeable_tab.dart';
import 'package:mobile/module/library-screen/new_feature_tab.dart';
import 'package:mobile/module/library-screen/recent_tab.dart';
import 'package:mobile/module/library-screen/recommend_tab.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return DiscoveryScreenState();
  }
}

class DiscoveryScreenState extends State<DiscoveryScreen> {
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
                NoticeableTab(),
                RecommendTab(),
                RecentTab(),
                NewFeatureTab()
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //         padding: const EdgeInsets.symmetric(
            //             vertical: 10.0, horizontal: 5.0),
            //         child: Flex(direction: Axis.horizontal, children: [
            //           const Text(
            //             "Mới phát hành",
            //             textAlign: TextAlign.right,
            //             style: TextStyle(
            //                 color: Color(0xFFB2572B),
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //           IconButton(
            //             icon: const Icon(
            //               Icons.arrow_forward_ios,
            //               size: 20,
            //               color: Color(0xFFB2572B),
            //             ),
            //             onPressed: () {
            //               print("Mới phát hành");
            //             },
            //           )
            //         ])),
            //     SizedBox(
            //         width: MediaQuery.of(context).size.width,
            //         child: DetailCard(items: newestSongs)),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
