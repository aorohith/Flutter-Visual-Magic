//#################...Floating Video play Button..#############

import 'package:flutter/material.dart';
import '../../infrastructure/functions/videos_with_info.dart';
import '../../main.dart';
import '../VideoPlayer/video_player.dart';

Widget playButton(context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlay(
              videoLink: recentDB.isNotEmpty
                  ? recentDB.values.toList().last.recentPath
                  : fetchedVideosWithInfo.value.first.path),
        ),
      );
    },
    child: const Icon(Icons.play_arrow),
  );
}