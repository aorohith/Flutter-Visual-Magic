import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:visual_magic/db/Models/Recent/recent_model.dart';
import 'package:visual_magic/db/functions.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlay extends StatefulWidget {
  final videoLink;
  final videoWithInfo;
  const VideoPlay({
    required this.videoLink,
    this.videoWithInfo,
  });

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late BetterPlayerController _betterPlayerController;
  final GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    var recent =
        RecentModel(recentPath: widget.videoLink, recentDate: DateTime.now());
    addToRecent(recent);
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      autoPlay: true,
      looping: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoDetectFullscreenDeviceOrientation: true,
      fullScreenByDefault: true,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file, widget.videoLink,
        notificationConfiguration: BetterPlayerNotificationConfiguration(
          showNotification: true,
          title: getVideoName(),
        ));
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    Wakelock.enable();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // _betterPlayerController.dispose();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getVideoName(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(
                  controller: _betterPlayerController,
                  key: _betterPlayerKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getVideoName() {
    return widget.videoLink.split('/').last;
  }
}

Widget fullScreen(BuildContext context, Animation<double> animation,
    Animation<double> animation2, BetterPlayerControllerProvider) {
  return Scaffold(
    backgroundColor: Colors.redAccent,
  );
}
