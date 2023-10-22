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
import 'widgets/fav_popup_menu_button.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("Favorites",style: TextStyle(color: appBarTitleColor),),
        actions: [
          favDB.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete Favorite Videos"),
                          content:
                              const Text("Do you wants to clear Favorites?"),
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
      ),
     extendBodyBehindAppBar: true,
      body: Container(
        decoration: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: AnimationLimiter(
            child: ValueListenableBuilder(
                valueListenable: favDB.listenable(),
                builder: (BuildContext ctx, Box<Favorites> newFav, Widget? child) {
                  return newFav.isEmpty
                      ? emptyDisplay("Favorite Videos")
                      : ListView.builder(
                          padding: EdgeInsets.all(w / 30),
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: newFav.length,
                          itemBuilder: (BuildContext context, int index) {
                            Favorites favorite = favDB.getAt(index)!;
                            return Container(
                              margin: EdgeInsets.only(bottom: w / 20),
                              height: w / 5,
                              decoration: const BoxDecoration(
                                color:  listColor,
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
                                          videoLink: favorite.favVideo,
                                        ),
                                      ),
                                    );
                                  },
                                  leading:
                                      Image.asset("assets/images/download.jpeg"),
                                  title: Text(
                                    favorite.favVideo.split('/').last,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: FavoritesPopupOption(
                                    videoPath: favorite.favVideo,
                                    favIndex: index,
                                  ),
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
