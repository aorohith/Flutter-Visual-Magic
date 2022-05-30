import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/Screens/Emptydisplay/empty_text.dart';
import 'package:visual_magic/Screens/Playlist/playlist_refactor.dart';
import 'package:visual_magic/Screens/Playlist/playlist_videos.dart';
import 'package:visual_magic/db/Models/models.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: playlistAdd(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("PlayList"),
        actions: [
          playListNameDB.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Playlist"),
                          content: const Text("Do you wants to clear Playlist?"),
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
                                playListNameDB.clear();
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
            valueListenable: playListNameDB.listenable(),
            builder: (BuildContext ctx, Box<PlayListName> playListName,
                Widget? child) {
              return playListName.isEmpty
                  ? emptyDisplay("Playlist")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: playListName.length,
                      itemBuilder: (BuildContext context, int index) {
                        PlayListName? playName = playListName.getAt(index);

                        return AnimationConfiguration.staggeredList(
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
                                            builder: (context) =>
                                                PlaylistVideos(
                                              namePlay: playName!.playListName,
                                            ),
                                          ),
                                        );
                                      },
                                      leading: const Icon(
                                        Icons.playlist_add_check,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      title: Text(
                                        playName!.playListName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
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
