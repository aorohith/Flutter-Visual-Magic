//List tile for video listview builder

import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../infrastructure/functions/fetch_video_data.dart';
import '../../Main/showcase_inheritted.dart';
import '../../VideoPlayer/video_player.dart';
import '../../widgets/favourite.dart';
import '../../widgets/option_popup.dart';

Widget getListView(
    {required index, required context, required videosWithIndex}) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlay(
            videoLink: videosWithIndex[index].path,
          ),
        ),
      );
    },
    onLongPress: () {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(15, 255, 255, 255),
              content: optionPopup(
                  context: context,
                  recentVideoPath: videosWithIndex[index].path,
                  index: index),
            );
          });
    },
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 50,
        width: 80,
        child: Image.asset("assets/images/download.jpeg"),
      ),
    ),
    title: Text(
      videosWithIndex[index].title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      formatTime(videosWithIndex[index].duration),
      style: const TextStyle(color: Colors.white),
    ),
    trailing: index == 0
        ? Showcase(
            shapeBorder: const CircleBorder(),
            showcaseBackgroundColor: Colors.indigo,
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
            key: KeysToBeInherited.of(context).key4,
            child: Favourite(
              favIndex: index,
              videoPath: videosWithIndex[index].path,
              isPressed2: favVideos.value.contains(videosWithIndex[index].path)
                  ? false
                  : true,
            ),
            description: "Add to Favourites Here")
        : Favourite(
            favIndex: index,
            isPressed2: favVideos.value.contains(videosWithIndex[index].path)
                ? false
                : true,
            videoPath: videosWithIndex[index].path,
          ),
  );
}

String formatTime(double time) {
  Duration duration = Duration(milliseconds: time.round());
  return [duration.inHours, duration.inMinutes, duration.inSeconds]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join(':');
}