import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'dart:math';
import 'dart:core';
import '../../../infrastructure/functions/load_folder_videos.dart';
import '../../../infrastructure/functions/videos_with_info.dart';

// ignore: must_be_immutable
class FolderPopupMenuButton extends StatefulWidget {
  String folderPath;
  FolderPopupMenuButton({Key? key, required this.folderPath}) : super(key: key);

  @override
  State<FolderPopupMenuButton> createState() => _FolderPopupMenuButtonState();
}

class _FolderPopupMenuButtonState extends State<FolderPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  onTap: () {},
                  value: 'info',
                  child: const Text('Folder info')),

              // PopupMenuItem<String>(
              //     onTap: () {

              //     },
              //     child: Text('sample'),
              //     value: 'Lion'),
            ],
        onSelected: (selected) {
          if (selected == "info") {
            folderInfoPopup(context: context, folderPath: widget.folderPath);
          }
        });
  }
}
//##########....popup for folder info...############

folderInfoPopup({context, folderPath}) {
  showDialog(
      context: context,
      builder: (context) {
        String folderName = folderPath.split('/').last;
        var sizeInGB = getFolderSize(folderPath);
        return Form(
          child: AlertDialog(
            title: const Text(
              "More info",
              style: TextStyle(fontSize: 25),
            ),
            content: Text(
              'Folder Name : $folderName \n\nFolder size : $sizeInGB GB \n',
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                ),
              ),
            ],
          ),
        );
      });
}

//#############...popup functions...##################

getFolderSize(String path) {
  GetVideos.filteredFolderVideos.value.clear();
  List<VideoData> matchedVideoPath = [];

  List<String> spitedMatchedVideoPath = [];

  dynamic folderSize = 0.0;

  var splitter = path.split('/');

  for (VideoData singlePath in GetVideoInfo.fetchedVideosWithInfo.value) {
    if (singlePath.path!.startsWith(path)) {
      matchedVideoPath.add(singlePath);
    }
  }

  for (VideoData newPathObj in matchedVideoPath) {
    spitedMatchedVideoPath = newPathObj.path!.split('/');
    if (spitedMatchedVideoPath[splitter.length].endsWith('.mp4') ||
        spitedMatchedVideoPath[splitter.length].endsWith('.mkv')) {
      folderSize = folderSize + newPathObj.filesize!;
    }
  }
  folderSize = folderSize * 9.31 * pow(10, -10);
  folderSize = folderSize.toStringAsFixed(2);
  return folderSize;
  // notify listeners if needed\
}
