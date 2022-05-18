import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/Screens/Emptydisplay/empty_text.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/Models/PlayList/playlist_model.dart';
import 'package:visual_magic/main.dart';

List<String>? fetchedVideos;

class PlaylistVideos extends StatefulWidget {
  final namePlay;
  PlaylistVideos({Key? key, required this.namePlay}) : super(key: key);

  @override
  State<PlaylistVideos> createState() => _PlaylistVideosState();
}

class _PlaylistVideosState extends State<PlaylistVideos> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    bool isPressed = true;
    bool isPressed2 = true;
    bool isHighlighted = true;

    return Scaffold(
      drawer: MenuDrawer(),
      floatingActionButton: PlayButton(context),
      backgroundColor: Color(0xff060625),
      appBar: AppBar(
        title: Text(widget.namePlay),
        actions: [
          playListVideosDB.isEmpty
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete RecentVideos"),
                          content: Text("Do you wants to clear Recent?"),
                          actions: [
                            ElevatedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: Text("Delete"),
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
                  icon: Icon(Icons.delete),
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
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: playListVideos.length,
                      itemBuilder: (BuildContext context, int index) {
                        PlayListVideos? playlistVideo =
                            playListVideos.getAt(index);

                        return playlistVideo!.playListName == widget.namePlay
                            ? AnimationConfiguration.staggeredList(
                                position: index,
                                delay: Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  verticalOffset: -250,
                                  child: ScaleAnimation(
                                    duration: Duration(milliseconds: 1500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: _w / 20),
                                      height: _w / 4,
                                      decoration: BoxDecoration(
                                        color: Color(0xff1f1f55),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
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
                                                  videoLink: playlistVideo
                                                      .playListVideo,
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
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox();
                      },
                    );
            }),
      ),
    );
  }
}
