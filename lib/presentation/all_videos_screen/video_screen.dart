import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/core/colors/colors.dart';
import '../../infrastructure/functions/videos_with_info.dart';
import '../menu_drawer/menu_drawer.dart';
import '../search/search_delegate.dart';
import '../showcase_widget/showcase_inherited.dart';
import '../widgets/empty_display_text.dart';
import '../widgets/popup_button.dart';
import 'widgets/all_videos_listview.dart';
import 'widgets/all_videos_sort_dropdown.dart';

class VideosScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  VideosScreen({Key? key}) : super(key: key);
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      appBar: AppBar(
        title: const Text(
          "All Videos",
          style: TextStyle(color: appBarTitleColor),
        ),
        actions: [
          Showcase(
            // shapeBorder: const CircleBorder(),
            // showcaseBackgroundColor: Colors.indigo,
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
            key: KeysToBeInherited.of(context).key1,
            description: "You can Search here",
            child: IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchVideos());
                },
                icon: const Icon(Icons.search)),
          ),
          Showcase(
              // showcaseBackgroundColor: const Color.fromARGB(255, 63, 81, 181),
              descTextStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
              key: KeysToBeInherited.of(context).key2,
              description: "Sort your videos here",
              child: const SortDropdown()),
          IconButton(
            onPressed: () {
              ShowCaseWidget.of(context).startShowCase([
                KeysToBeInherited.of(context).key1,
                KeysToBeInherited.of(context).key2,
                KeysToBeInherited.of(context).key3,
                KeysToBeInherited.of(context).key4,
              ]);
            },
            icon: const Icon(Icons.help_outline_outlined),
          ),
        ],
      ),
      body: Container(
        decoration: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: SizedBox(
            width: double.infinity,
            child: AnimationLimiter(
              child: ValueListenableBuilder(
                valueListenable: GetVideoInfo.fetchedVideosWithInfo,
                builder: (BuildContext ctx, List<dynamic> videosWithIndex,
                    Widget? child) {
                  return videosWithIndex.isEmpty
                      ? emptyDisplay("Videos")
                      : ListView.builder(
                          padding: EdgeInsets.all(w / 30),
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: videosWithIndex.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: w / 20),
                              height: w / 5,
                              decoration: const BoxDecoration(
                                color: listColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: index == 0
                                    ? Showcase(
                                        // shapeBorder: const CircleBorder(),
                                        // showcaseBackgroundColor:
                                        //     Colors.indigo,
                                        descTextStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        key: KeysToBeInherited.of(context).key3,
                                        description:
                                            "Long Press to view the more info",
                                        child: getListView(
                                          index: index,
                                          context: context,
                                          videosWithIndex: videosWithIndex,
                                        ))
                                    : getListView(
                                        index: index,
                                        context: context,
                                        videosWithIndex: videosWithIndex,
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
      ),
    );
  }
}
