import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:wakelock/wakelock.dart';

import '../../infrastructure/functions/recent_videos.dart';

class VideoPlay extends StatefulWidget {
  final String videoLink;
  const VideoPlay({
    super.key,
    required this.videoLink,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late BetterPlayerController _betterPlayerController;
  final GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    var recent =
        RecentModel(recentPath: widget.videoLink, recentDate: DateTime.now());
    RecentVideos.addToRecent(recent);
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
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
                style: const TextStyle(
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
