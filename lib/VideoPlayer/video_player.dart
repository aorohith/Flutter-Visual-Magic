import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:visual_magic/db/Models/Recent/recent_model.dart';
import 'package:visual_magic/db/functions.dart';

class VideoPlay extends StatefulWidget {
  final videoLink;
  final videoWithInfo;
  const VideoPlay({
    Key? key,
    this.videoLink = "/storage/emulated/0/flutter/file.mp4",
    this.videoWithInfo,
  }) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  @override
  void initState() {
    // TODO: implement initState
    var recent =
        RecentModel(recentPath: widget.videoLink, recentDate: DateTime.now());
    addToRecent(recent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example player"),
      ),
      body: AspectRatio(
        aspectRatio: widget.videoWithInfo.width / widget.videoWithInfo.height,
        child: BetterPlayer.file(
          widget.videoLink,
          betterPlayerConfiguration: BetterPlayerConfiguration(
            aspectRatio: 16/9,
            fullScreenByDefault:true,
            autoPlay: true,
            allowedScreenSleep:false,
          ),
        ),
      ),
    );
  }
}
