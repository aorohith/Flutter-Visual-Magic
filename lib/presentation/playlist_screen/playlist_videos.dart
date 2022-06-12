import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/core/colors/colors.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';
import 'package:visual_magic/presentation/widgets/empty_display_text.dart';
import 'package:visual_magic/presentation/widgets/popup_button.dart';
import '../menu_drawer/menu_drawer.dart';
import '../video_player/video_player.dart';
import 'widgets/playlist_videos_popup.dart';

class PlaylistVideos extends StatefulWidget {
  final namePlay;
  const PlaylistVideos({Key? key, required this.namePlay}) : super(key: key);

  @override
  State<PlaylistVideos> createState() => _PlaylistVideosState();
}

class _PlaylistVideosState extends State<PlaylistVideos> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      appBar: AppBar(
        title: Text(
          widget.namePlay,
          style: const TextStyle(color: appBarTitleColor),
        ),
        actions: [
          playListVideosDB.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete RecentVideos"),
                          content: const Text("Do you wants to clear Recent?"),
                          actions: [
                            ElevatedButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: const Text("Delete"),
                              onPressed: () {
                                playListVideosDB.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
        ],
      ),
      body: Container(
        decoration: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: AnimationLimiter(
            child: ValueListenableBuilder(
              valueListenable: playListVideosDB.listenable(),
              builder: (BuildContext ctx, Box<PlayListVideos> playListVideos,
                  Widget? child) {
                return playListVideos.isEmpty
                    ? emptyDisplay("${widget.namePlay} Videos")
                    : ListView.builder(
                        padding: EdgeInsets.all(_w / 30),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: playListVideos.length,
                        itemBuilder: (BuildContext context, int index) {
                          PlayListVideos? playlistVideo =
                              playListVideos.getAt(index);

                          return playlistVideo!.playListName == widget.namePlay
                              ? Container(
                                  margin: EdgeInsets.only(bottom: _w / 20),
                                  height: _w / 5,
                                  decoration: const BoxDecoration(
                                    color: listColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VideoPlay(
                                              videoLink:
                                                  playlistVideo.playListVideo,
                                            ),
                                          ),
                                        );
                                      },
                                      leading: Image.asset(
                                          "assets/images/download.jpeg"),
                                      title: Text(
                                        playlistVideo.playListVideo
                                            .split("/")
                                            .last,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: PlayVideosPopup(
                                        videoPath: playlistVideo.playListVideo,
                                        playlistName:
                                            playlistVideo.playListName,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        },
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
