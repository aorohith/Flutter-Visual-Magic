import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/presentation/widgets/empty_display_text.dart';
import 'package:visual_magic/presentation/widgets/popup_button.dart';
import '../../application/videos/videos_bloc.dart';
import '../../infrastructure/functions/fetch_video_data.dart';
import '../../infrastructure/functions/load_folder_videos.dart';
import '../menu_drawer/menu_drawer.dart';
import '../showcase_widget/showcase_inheritted.dart';
import 'folder_videos.dart';
import 'widgets/folder_popupmenubutton.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // loadFolderList();
    context.read<VideosBloc>().add(FetchFolders(fetched: fetchedVideosPath));
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
        actions: const [
          // ElevatedButton(
          //   onPressed: () {
          //     print("Button Clicked"); //a test button for all purpouse
          //   },
          //   child: const Text("Click"),
          // ),
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
      body: BlocBuilder<VideosBloc, VideosState>(
        builder: (context, state) {
          List<String> updatedFolders = state.folderVideos;
          return AnimationLimiter(
            child: updatedFolders.isEmpty
                ? emptyDisplay("Folders")
                : ListView.builder(
                    padding: EdgeInsets.all(_w / 30),
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: updatedFolders.length,
                    itemBuilder: (BuildContext context, int index) {
                      getFolderVideosCount(updatedFolders[index]); //for video count

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: Container(
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      FolderVideos(path: updatedFolders[index]),
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
                                      showcaseBackgroundColor: Colors.indigo,
                                      descTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      key: KeysToBeInherited.of(context).key2,
                                      child: Text(
                                        updatedFolders[index].split('/').last,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      description: "Folder name is here")
                                  : Text(
                                      updatedFolders[index].split('/').last,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ), //Turnery end here

                              subtitle: Text(
                                "${tempCount.value.length} Videos",
                                style: const TextStyle(color: Colors.white),
                              ),

                              // more option for future usage
                              trailing: index == 0
                                  ? Showcase(
                                      shapeBorder: const CircleBorder(),
                                      showcaseBackgroundColor: Colors.indigo,
                                      descTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      key: KeysToBeInherited.of(context).key3,
                                      child: FolderPopupMenuButton(
                                          folderPath: updatedFolders[index]),
                                      description: "More info ")
                                  : FolderPopupMenuButton(
                                      folderPath: updatedFolders[index]),

                              //Turnery operator ends here
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
