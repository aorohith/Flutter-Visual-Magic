import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/PopupMenuButton/popup_menu_button.dart';
import 'package:visual_magic/Screens/Emptydisplay/empty_text.dart';
import 'package:visual_magic/Search/search_deligate.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/Models/Favourites/favourites_model.dart';
import 'package:visual_magic/main.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MenuDrawer(),
      floatingActionButton: PlayButton(context),
      backgroundColor: Color(0xff060625),
      appBar: AppBar(
        title: Text("Favourites"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: searchVideos());
              },
              icon: Icon(Icons.search)),
          favDB.isEmpty
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Favourite Videos"),
                          content: Text("Do you wants to clear Favourites?"),
                          actions: [
                            ElevatedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: Text("Clear"),
                              onPressed: () {
                                favDB.clear();
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
        backgroundColor: Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: favDB.listenable(),
            builder: (BuildContext ctx, Box<Favourites> newFav, Widget? child) {
              return newFav.isEmpty
                  ? emptyDisplay("Favourite Videos")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: newFav.length,
                      itemBuilder: (BuildContext context, int index) {
                        Favourites favourite = favDB.getAt(index)!;
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
                                                    videoLink:
                                                        favourite.favVideo,
                                                  )));
                                    },
                                    leading: Image.asset(
                                        "assets/images/download.jpeg"),
                                    title: Text(
                                      favourite.favVideo.split('/').last,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: PopupOption(
                                      videoPath: favourite.favVideo,
                                      favIndex: index,
                                    ),

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
