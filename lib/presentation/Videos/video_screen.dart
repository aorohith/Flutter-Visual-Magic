import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/Main/showcase_inheritted.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/presentation/Videos/widgets/all_videos_sort_dropdown.dart';
import 'package:visual_magic/presentation/Videos/widgets/all_videos_listview.dart';
import '../../infrastructure/functions/videos_with_info.dart';
import '../Search/search_deligate.dart';
import '../widgets/empty_display_text.dart';
import '../widgets/popup_button.dart';

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
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff060625),
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      appBar: AppBar(
        title: const Text("All Videos"),
        actions: [
          Showcase(
            shapeBorder: const CircleBorder(),
            showcaseBackgroundColor: Colors.indigo,
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
              showcaseBackgroundColor: const Color.fromARGB(255, 63, 81, 181),
              descTextStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
              key: KeysToBeInherited.of(context).key2,
              child: const SortDropdown(),
              description: "Sort your videos here"),
          IconButton(
            onPressed: () {
              ShowCaseWidget.of(context)!.startShowCase([
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
      body: SizedBox(
        width: double.infinity,
        child: AnimationLimiter(
          child: ValueListenableBuilder(
            valueListenable: fetchedVideosWithInfo,
            builder: (BuildContext ctx, List<dynamic> videosWithIndex,
                Widget? child) {
              return videosWithIndex.isEmpty
                  ? emptyDisplay("Videos")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: videosWithIndex.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                  color:
                                      const Color.fromARGB(255, 114, 102, 224)
                                          .withOpacity(.5),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 50,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: index == 0
                                      ? Showcase(
                                          shapeBorder: const CircleBorder(),
                                          showcaseBackgroundColor:
                                              Colors.indigo,
                                          descTextStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          key: KeysToBeInherited.of(context)
                                              .key3,
                                          child: getListView(
                                            index: index,
                                            context: context,
                                            videosWithIndex: videosWithIndex,
                                          ),
                                          description:
                                              "Long Press to view the more info")
                                      : getListView(
                                          index: index,
                                          context: context,
                                          videosWithIndex: videosWithIndex,
                                        ),
                                ),
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
    );
  }
}
