import 'package:flutter/material.dart';
import 'package:mobile/components/title/screen_header.dart';

class NoticeableScreen extends StatefulWidget {
  const NoticeableScreen({super.key});

  @override
  State<NoticeableScreen> createState() => _NoticeableScreenState();
}

class _NoticeableScreenState extends State<NoticeableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenHeader(
        title: "Đáng chú ý",
      ),
      backgroundColor: const Color(0xFFDCD1B3),
    );
  }
}
