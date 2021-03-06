import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/core/colors/colors.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';
import '../../infrastructure/functions/fetch_video_data.dart';
import '../menu_drawer/menu_drawer.dart';
import '../video_player/video_player.dart';
import '../widgets/empty_display_text.dart';
import '../widgets/favourite.dart';
import '../widgets/option_popup.dart';
import '../widgets/popup_button.dart';

List<String>? fetchedVideos;

class WatchLater extends StatefulWidget {
  const WatchLater({Key? key}) : super(key: key);

  @override
  State<WatchLater> createState() => _WatchLaterState();
}

class _WatchLaterState extends State<WatchLater> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("WatchLater",style: TextStyle(color: appBarTitleColor),),
        actions: [
          watchlaterDB.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Watchlater Videos"),
                          content: const Text("Do you wants to clear Watchlater Videos?"),
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
                                watchlaterDB.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete)),
        ],
      ),
      body: Container(
        decoration: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: AnimationLimiter(
            child: ValueListenableBuilder(
                valueListenable: watchlaterDB.listenable(),
                builder: (BuildContext ctx, Box<WatchlaterModel> watchlaters,
                    Widget? child) {
                  return watchlaters.isEmpty
                      ? emptyDisplay("Watchlater Videos")
                      : ListView.builder(
                          padding: EdgeInsets.all(_w / 30),
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: watchlaters.length,
                          itemBuilder: (BuildContext context, int index) {
                            WatchlaterModel? watchlater = watchlaters.getAt(index);
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
                                        builder: (context) => VideoPlay(
                                          videoLink: watchlater!.laterPath,
                                        ),
                                      ),
                                    );
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            backgroundColor: const Color(0xff060625),
                                            content: optionPopup(
                                                context: context,
                                                recentVideoPath:
                                                    watchlater!.laterPath,
                                                index: index),
                                          );
                                        });
                                  },
                                  leading: Image.asset(
                                      "assets/images/download.jpeg"),
                                  title: Text(
                                    watchlater!.laterPath.split('/').last,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Favourite(
                                      favIndex: index,
                                      videoPath: watchlater.laterPath,
                                      isPressed2: favVideos.value
                                              .contains(watchlater.laterPath)
                                          ? false
                                          : true),
                                ),
                              ),
                            );
                          },
                        );
                }),
          ),
        ),
      ),
    );
  }
}
