import 'package:flutter/material.dart';
import 'package:mobile/components/notification/my_alert.dart';
import 'package:mobile/model/song_model.dart';

class CreatePlaylistModal extends StatefulWidget {
  final bool add;
  final Song currentSong;
  final dynamic songProvider;
  const CreatePlaylistModal(
      {super.key,
      required this.currentSong,
      required this.songProvider,
      required this.add});

  @override
  State<CreatePlaylistModal> createState() => _CreatePlaylistModalState();
}

class _CreatePlaylistModalState extends State<CreatePlaylistModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          //add or delete favorite
          (widget.add)
              ? InkWell(
                  onTap: () {
                    widget.songProvider.createFavorite(widget.currentSong.id!);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return MyAlert(
                              content: 'Đã thêm vào danh sách yêu thích');
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    width: double.infinity,
                    child: Text(
                      'Thêm vào danh sách yêu thích',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    widget.songProvider.deleteFavorite(widget.currentSong.id!);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return MyAlert(
                              content: 'Đã xóa khỏi danh sách yêu thích');
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    width: double.infinity,
                    child: Text(
                      'Xóa khỏi danh sách yêu thích',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              widget.songProvider.downloadSong(widget.currentSong);
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.of(context).pop(true);
                    });
                    return MyAlert(content: 'Đã tải xuống');
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300),
              width: double.infinity,
              child: Text(
                'Tải xuống',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
