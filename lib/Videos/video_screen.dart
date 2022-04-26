import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/Main/showcase_inheritted.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/Videos/refactor.dart';
import 'package:visual_magic/db/functions.dart';

class VideosScreen extends StatefulWidget {
  VideosScreen({Key? key}) : super(key: key);
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  void initState() {
    print(fetchedVideosWithInfo.value[1]);
    // TODO: implement initState
    super.initState();
  }

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
        title: Text("All Videos"),
        actions: [
          Search(),
          Showcase(
              showcaseBackgroundColor: Colors.indigo,
              descTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
              key: KeysToBeInherited.of(context).key2,
              child: sortDropdown(),
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
            icon: Icon(Icons.help_outline_outlined),
          ),
        ],
        backgroundColor: Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: fetchedVideosWithInfo,
            builder: (BuildContext ctx, List<dynamic> videosWithIndex,
                Widget? child) {
              print(videosWithIndex.length);
              return ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: videosWithIndex.length,
                itemBuilder: (BuildContext context, int index) {
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
                            child: index == 0
                                ? Showcase(
                                    shapeBorder: const CircleBorder(),
                                    showcaseBackgroundColor: Colors.indigo,
                                    descTextStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    key: KeysToBeInherited.of(context).key3,
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
            }),
      ),
    );
  }
}
