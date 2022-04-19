import 'package:flutter/material.dart';
import 'package:visual_magic/utils/chewie_player.dart';
import 'package:video_player/video_player.dart';


class VideoPlay extends StatefulWidget {
  const VideoPlay({Key? key }) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example player"),
      ),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: ChewieListItem(
          
            videoPlayerController:
                VideoPlayerController.asset('assets/videos/ForBiggerFun.mp4'),
            looping: true,
          ),
      ),
    );
  }
} 