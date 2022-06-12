import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';
import 'package:visual_magic/presentation/widgets/empty_display_text.dart';
import '../../core/colors/colors.dart';
import '../menu_drawer/menu_drawer.dart';
import 'playlist_videos.dart';
import 'widgets/new_playlsit_button.dart';
import 'widgets/playlist_popup.dart';

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
      extendBodyBehindAppBar: true,
      drawer: const MenuDrawer(),
      floatingActionButton: playlistAddButton(context),
      appBar: AppBar(
        title: const Text("PlayList",style: TextStyle(color: appBarTitleColor),),
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
                          content:
                              const Text("Do you wants to clear Playlist?"),
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
      body: Container(
        decoration: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: AnimationLimiter(
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

                          return Container(
                            margin: EdgeInsets.only(bottom: _w / 20),
                            height: _w / 5,
                            decoration: const BoxDecoration(
                              color: listColor,
                              borderRadius:  BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistVideos(
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
                                ),
                              ),
                            ),
                          );
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
