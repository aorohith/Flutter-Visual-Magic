import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/Screens/Emptydisplay/empty_text.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/db/functions.dart';
import 'package:visual_magic/main.dart';

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
    bool isPressed = true;
    bool isPressed2 = true;
    bool isHighlighted = true;
    return Scaffold(
      drawer: MenuDrawer(),
      floatingActionButton: PlayButton(context),
      backgroundColor: Color(0xff060625),
      appBar: AppBar(
        title: Text("WatchLater"),
        backgroundColor: Color(0xff2C2C6D),
        actions: [
          watchlaterDB.isEmpty
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Watchlater Videos"),
                          content: Text("Do you wants to clear Watchlater Videos?"),
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
                                watchlaterDB.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete)),
        ],
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: watchlaterDB.listenable(),
            builder: (BuildContext ctx, Box<WatchlaterModel> watchlaters,
                Widget? child) {
              return watchlaters.isEmpty
                  ? emptyDisplay("Watchlater Videos")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: watchlaters.length,
                      itemBuilder: (BuildContext context, int index) {
                        WatchlaterModel? watchlater = watchlaters.getAt(index);
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
                                              backgroundColor: Color(0xf060625),
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
                                      style: TextStyle(
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
