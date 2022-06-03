import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';
import 'package:visual_magic/presentation/widgets/empty_display_text.dart';
import 'package:visual_magic/presentation/Playlist/widgets/playlist_videos_popup.dart';
import 'package:visual_magic/presentation/widgets/popup_button.dart';

List<String>? fetchedVideos;

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
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: Text(widget.namePlay),
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
      body: AnimationLimiter(
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
                          ? AnimationConfiguration.staggeredList(
                              position: index,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                verticalOffset: -250,
                                child: ScaleAnimation(
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: _w / 20),
                                    height: _w / 4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff1f1f55),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 40,
                                          spreadRadius: 10,
                                        ),
                                      ],
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
                                          videoPath:
                                              playlistVideo.playListVideo,
                                          playlistName:
                                              playlistVideo.playListName,
                                        ),
                                      ),
                                    ),
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
    );
  }
}
