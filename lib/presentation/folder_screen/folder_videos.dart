import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visual_magic/presentation/widgets/favourite.dart';
import 'package:visual_magic/presentation/widgets/option_popup.dart';
import 'package:visual_magic/presentation/widgets/popup_button.dart';
import '../../core/colors/colors.dart';
import '../../infrastructure/functions/fetch_video_data.dart';
import '../../infrastructure/functions/load_folder_videos.dart';
import '../menu_drawer/menu_drawer.dart';
import '../thumbnail_screen/thumbnail_generator.dart';
import '../video_player/video_player.dart';

List<String>? fetchedVideos;

class FolderVideos extends StatefulWidget {
  final path; //folder path
  const FolderVideos({Key? key, required this.path}) : super(key: key);

  @override
  State<FolderVideos> createState() => _FolderVideosState();
}

class _FolderVideosState extends State<FolderVideos> {
  @override
  void initState() {
    getFolderVideos(widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      appBar: AppBar(
        title: Text(
          widget.path.toString().split('/').last,
          style: const TextStyle(color: appBarTitleColor),
        ),
      ),
      body: Container(
        decoration: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: AnimationLimiter(
            child: ValueListenableBuilder(
                valueListenable: filteredFolderVideos,
                builder: (BuildContext ctx, List<String> folderVideosList,
                    Widget? child) {
                  return ListView.builder(
                    padding: EdgeInsets.all(_w / 30),
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: folderVideosList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: _w / 20),
                        height: _w / 5,
                        decoration: const BoxDecoration(
                          color: listColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => VideoPlay(
                                    videoLink: folderVideosList[index],
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
                                              folderVideosList[index],
                                          index: index),
                                    );
                                  });
                            },
                            leading: ThumbGenerator(
                                videoPath: folderVideosList[index]),
                            title: Text(
                              folderVideosList[index].split('/').last,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Favourite(
                                favIndex: index,
                                videoPath: folderVideosList[index],
                                isPressed2: favVideos.value
                                        .contains(folderVideosList[index])
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
