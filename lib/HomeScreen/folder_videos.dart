import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/functions.dart';

List<String>? fetchedVideos;

class FolderVideos extends StatefulWidget {
  final path;
  const FolderVideos({Key? key, required this.path}) : super(key: key);

  @override
  State<FolderVideos> createState() => _FolderVideosState();
}

class _FolderVideosState extends State<FolderVideos> {
  @override
  void initState() {
    getFolderVideos(widget.path);
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
        title: Text("Camera"),
        
        backgroundColor: Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: filteredFolderVideos,
            builder: (BuildContext ctx, List<dynamic> folderVideosList,
                Widget? child) {
              return ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: folderVideosList.length,
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
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlay(
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
                                        backgroundColor: Color(0xf060625),
                                        content: optionPopup(),
                                      );
                                    });
                              },
                              leading:
                                  Image.asset("assets/images/download.jpeg"),
                              title: Text(
                                folderVideosList[index].split('/').last,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "10 Videos",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Favourites(
                                videoPath: folderVideosList[index],
                                isPressed2: favVideos.value.contains(folderVideosList[index]) ? false : true
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
