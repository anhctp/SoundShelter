import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobile/model/upload_song_model.dart';
import 'package:mobile/provider/upload_provider.dart';
import 'package:mobile/provider/user_provider.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class FileUploadWidget extends StatefulWidget {
  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  File? _file;

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
      _uploadFile(context);
    }
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (_file == null) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final uploadProvider = Provider.of<UploadProvider>(context, listen: false);
    final uploadSong =
        UploadSong(mp3File: _file!, title: _file!.path.split("/").last);
    final response = await uploadProvider.uploadSong(
        uploadSong, userProvider.currentUser!.token);
    if (!context.mounted) return;
    if (!response) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Upload song failed, please try again.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _file != null
                ? Flexible(child: Text(_file!.path.split("/").last))
                : const Flexible(child: Text("")),
            ElevatedButton(
              onPressed: () => _pickFile(context),
              child: const Text('Chọn file'),
            ),
          ],
        ),
      ),
    );
  }
}
