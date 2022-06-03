import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/Main/showcase_inheritted.dart';
import 'package:visual_magic/MenuDrawer/menu_drawer.dart';
import 'package:visual_magic/Search/search_deligate.dart';
import 'package:visual_magic/presentation/widgets/empty_display_text.dart';
import 'package:visual_magic/presentation/FolderScreen/widgets/folder_popupmenubutton.dart';
import 'package:visual_magic/presentation/FolderScreen/folder_videos.dart';
import 'package:visual_magic/presentation/widgets/popup_button.dart';

import '../../infrastructure/load_folder_list.dart';
import '../../infrastructure/load_folder_videos.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadFolderList();
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
        title: const Text("Folders"),
        actions: [
          // ElevatedButton(
          //   onPressed: () {
          //     print("Button Clicked");//a test button for all purpouse
          //   },
          //   child: Text("Click"),
          // ),
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchVideos());
              },
              icon: const Icon(Icons.search)), //Search Refactor
          // IconButton(
          //   onPressed: () {
          //     ShowCaseWidget.of(context)!.startShowCase([
          //       KeysToBeInherited.of(context).key1,
          //       KeysToBeInherited.of(context).key2,
          //       KeysToBeInherited.of(context).key3,
          //     ]);
          //   },
          //   icon: Icon(Icons.help_outline_outlined),
          // ),
        ],
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: fetchedFolders,
            builder:
                (BuildContext ctx, List<String> updatedFolders, Widget? child) {
              return updatedFolders.isEmpty
                  ? emptyDisplay("Folders")
                  : ListView.builder(
                      padding: EdgeInsets.all(_w / 30),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: updatedFolders.length,
                      itemBuilder: (BuildContext context, int index) {
                        getFolderVideos(
                            updatedFolders[index]); //for video count

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
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => FolderVideos(
                                            path: updatedFolders[index]),
                                      ),
                                    ),
                                    leading: const Icon(
                                      Icons.folder_outlined,
                                      size: 60,
                                      color: Colors.white,
                                    ),

                                    title: index ==
                                            0 //turnery operator for showcase to select first element of folder
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
                                                .key2,
                                            child: Text(
                                              updatedFolders[index]
                                                  .split('/')
                                                  .last,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            description: "Folder name is here")
                                        : Text(
                                            updatedFolders[index]
                                                .split('/')
                                                .last,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ), //Turnery end here

                                    subtitle: Text(
                                      "${filteredFolderVideos.value.length} Videos",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),

                                    // more option for future usage
                                    trailing: index == 0
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
                                            child: FolderPopupMenuButton(
                                                folderPath:
                                                    updatedFolders[index]),
                                            description: "More info ")
                                        : FolderPopupMenuButton(
                                            folderPath: updatedFolders[index]),

                                    //Turnery operator ends here
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
