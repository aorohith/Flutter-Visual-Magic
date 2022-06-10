import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';
import 'package:visual_magic/presentation/widgets/favourite.dart';
import 'package:visual_magic/presentation/widgets/option_popup.dart';
import '../../infrastructure/functions/fetch_video_data.dart';
import '../../infrastructure/functions/recent_videos.dart';
import '../menu_drawer/menu_drawer.dart';
import '../search/search_deligate.dart';
import '../video_player/video_player.dart';
import '../widgets/empty_display_text.dart';
import '../widgets/popup_button.dart';

List<String>? fetchedVideos;

class RecentScreen extends StatefulWidget {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  @override
  void initState() {
    getRecentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("Recently Played"),
        actions: [
          recentDB.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete RecentVideos"),
                          content: const Text(
                              "Do you wants to clear Recent Videos?"),
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
                                recentDB.clear();
                                recentVideos.value.clear();
                                recentVideos.notifyListeners();
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
            valueListenable: recentVideos,
            builder: (BuildContext ctx, List<RecentModel> recentList,
                Widget? child) {
              return recentList.isEmpty
                  ? emptyDisplay("Recent Videos")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: recentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: _w / 20),
                          height: _w / 5,
                          decoration: BoxDecoration(
                            color: const Color(0xff1f1f55),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
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
                                      videoLink: recentList[index].recentPath,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        backgroundColor:
                                            const Color(0xff060625),
                                        content: optionPopup(
                                            context: context,
                                            recentVideoPath:
                                                recentList[index].recentPath,
                                            index: index),
                                      );
                                    });
                              },
                              leading:
                                  Image.asset("assets/images/download.jpeg"),
                              title: Text(
                                recentList[index].recentPath.split('/').last,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Favourite(
                                  favIndex: index,
                                  videoPath: recentList[index].recentPath,
                                  isPressed2: favVideos.value
                                          .contains(recentList[index])
                                      ? false
                                      : true),
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
