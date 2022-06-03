import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/Search/search_deligate.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';
import 'package:visual_magic/presentation/FavouriteScreen/widgets/fav_popup_menu_button.dart';
import 'package:visual_magic/presentation/widgets/empty_display_text.dart';
import 'package:visual_magic/presentation/widgets/popup_button.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("Favourites"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchVideos());
              },
              icon: const Icon(Icons.search)),
          favDB.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Favourite Videos"),
                          content: const Text("Do you wants to clear Favourites?"),
                          actions: [
                            ElevatedButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: const Text("Clear"),
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
                  icon: const Icon(Icons.delete),
                ),
        ],
        backgroundColor: const Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: favDB.listenable(),
            builder: (BuildContext ctx, Box<Favourites> newFav, Widget? child) {
              return newFav.isEmpty
                  ? emptyDisplay("Favourite Videos")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: newFav.length,
                      itemBuilder: (BuildContext context, int index) {
                        Favourites favourite = favDB.getAt(index)!;
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
                                          builder: (context) => VideoPlay(
                                            videoLink: favourite.favVideo,
                                          ),
                                        ),
                                      );
                                    },
                                    leading: Image.asset(
                                        "assets/images/download.jpeg"),
                                    title: Text(
                                      favourite.favVideo.split('/').last,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: FavoritesPopupOption(
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
