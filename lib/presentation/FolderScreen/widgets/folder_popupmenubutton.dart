import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:visual_magic/db/functions.dart';
import 'dart:math';
import 'dart:core';

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
                  onTap: () {}, child: const Text('Folder info'), value: 'info'),

              // PopupMenuItem<String>(
              //     onTap: () {

              //     },
              //     child: Text('sample'),
              //     value: 'Lion'),
            ],
        onSelected: (_selected) {
          if (_selected == "info") {
            folderInfoPoup(context: context, folderPath: widget.folderPath);
          }
        });
  }
}
//##########....popup for folder info...############

folderInfoPoup({context, folderPath}) {
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
  filteredFolderVideos.value.clear();
  List<VideoData> matchedVideoPath = [];

  List<String> splittedMatchedVideoPath = [];

  dynamic folderSize = 0.0;

  var splitted = path.split('/');

  for (VideoData singlePath in fetchedVideosWithInfo.value) {
    if (singlePath.path!.startsWith(path)) {
      matchedVideoPath.add(singlePath);
    }
  }

  for (VideoData newPathObj in matchedVideoPath) {
    splittedMatchedVideoPath = newPathObj.path!.split('/');
    if (splittedMatchedVideoPath[splitted.length].endsWith('.mp4') ||
        splittedMatchedVideoPath[splitted.length].endsWith('.mkv')) {
      folderSize = folderSize + newPathObj.filesize!;
    }
  }
  folderSize = folderSize * 9.31 * pow(10, -10);
  folderSize = folderSize.toStringAsFixed(2);
  return folderSize;
  // notify listeners if needed\
}
