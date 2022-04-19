import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';


class VideoPlay extends StatefulWidget {
  final videoLink;
  const VideoPlay({Key? key, this.videoLink = "/storage/emulated/0/flutter/file.mp4" }) : super(key: key);

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
            child: BetterPlayer.file(
              "${widget.videoLink}",
              betterPlayerConfiguration: BetterPlayerConfiguration(
                aspectRatio: 16 / 9,
              ),
            ),
          ),
    );
  }
} 