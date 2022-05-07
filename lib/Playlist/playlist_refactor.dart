import 'package:flutter/material.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';

Widget playlistAdd(context) {
  return FloatingActionButton(
    onPressed: () {},
    child: IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const VideoPlay()));
      },
      icon: const Icon(Icons.add, size: 30, color: Colors.white),
    ),
  );
}
