import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/Emptydisplay/empty_text.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/Playlist/playlist_refactor.dart';
import 'package:visual_magic/Playlist/playlist_videos.dart';
import 'package:visual_magic/db/Models/PlayList/playlist_model.dart';
import 'package:visual_magic/main.dart';

List<String>? fetchedVideos;

class Playlist extends StatefulWidget {
  final path;
  const Playlist({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    bool isPressed = true;
    bool isPressed2 = true;
    bool isHighlighted = true;
    return Scaffold(
      drawer: MenuDrawer(),
      floatingActionButton: playlistAdd(context),
      backgroundColor: Color(0xff060625),
      appBar: AppBar(
        title: Text("PlayList"),
        backgroundColor: Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: playListNameDB.listenable(),
            builder: (BuildContext ctx, Box<PlayListName> playListName,
                Widget? child) {
              return playListName.isEmpty
                  ? emptyDisplay("Playlist")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: playListName.length,
                      itemBuilder: (BuildContext context, int index) {
                        PlayListName? playName = playListName.getAt(index);

                        return AnimationConfiguration.staggeredList(
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
                                            builder: (context) =>
                                                PlaylistVideos(
                                              namePlay: playName!.playListName,
                                            ),
                                          ),
                                        );
                                      },
                                      leading: Icon(
                                        Icons.playlist_add_check,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      title: Text(
                                        playName!.playListName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "10 Videos",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: PlaylistPopup(
                                        playName: playName.playListName,
                                        playIndex: index,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            }),
      ),
    );
  }
}
