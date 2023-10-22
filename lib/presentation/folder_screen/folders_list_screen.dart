import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/presentation/widgets/empty_display_text.dart';
import 'package:visual_magic/presentation/widgets/popup_button.dart';
import '../../application/videos/videos_bloc.dart';
import '../../core/colors/colors.dart';
import '../../infrastructure/functions/fetch_video_data.dart';
import '../../infrastructure/functions/load_folder_videos.dart';
import '../menu_drawer/menu_drawer.dart';
import '../showcase_widget/showcase_inherited.dart';
import 'folder_videos.dart';
import 'widgets/folder_popup_menu_button.dart';

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
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      appBar: AppBar(
        title: const Text(
          "Folders",
          style: TextStyle(color: appBarTitleColor),
        ),
        actions: const [],
      ),
      body: Container(
        decoration: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: BlocBuilder<VideosBloc, VideosState>(
            builder: (context, state) {
              List<String> updatedFolders = state.folderVideos;
              return AnimationLimiter(
                child: updatedFolders.isEmpty
                    ? emptyDisplay("Folders")
                    : ListView.builder(
                        padding: EdgeInsets.all(w / 30),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: updatedFolders.length,
                        itemBuilder: (BuildContext context, int index) {
                          GetVideos.getFolderVideosCount(
                              updatedFolders[index]); //for video count

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            child: Container(
                              margin: EdgeInsets.only(bottom: w / 20),
                              height: w / 5,
                              decoration: const BoxDecoration(
                                color: listColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
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
                                    color: folderIconColor,
                                  ),

                                  title: index ==
                                          0 //turnery operator for showcase to select first element of folder
                                      ? Showcase(
                                          // shapeBorder: const CircleBorder(),
                                          // showcaseBackgroundColor:
                                          //     Colors.indigo,
                                          descTextStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          key: KeysToBeInherited.of(context)
                                              .key2,
                                          description: "Folder name is here",
                                          child: Text(
                                            updatedFolders[index]
                                                .split('/')
                                                .last,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))
                                      : Text(
                                          updatedFolders[index]
                                                      .split('/')
                                                      .last ==
                                                  '0'
                                              ? 'Internal Storage'
                                              : updatedFolders[index]
                                                  .split('/')
                                                  .last,
                                          style: const TextStyle(
                                              color: listTitleColor,
                                              fontWeight: FontWeight.bold),
                                        ), //Turnery end here

                                  subtitle: Text(
                                    "${GetVideos.tempCount.value.length} Videos",
                                    style: const TextStyle(
                                        color: listVerticalBtnColor,
                                        fontSize: 12),
                                  ),

                                  // more option for future usage
                                  trailing: index == 0
                                      ? Showcase(
                                          // shapeBorder: const CircleBorder(),
                                          // showcaseBackgroundColor:
                                          //     Colors.indigo,
                                          descTextStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          key: KeysToBeInherited.of(context)
                                              .key3,
                                          description: "More info ",
                                          child: FolderPopupMenuButton(
                                              folderPath:
                                                  updatedFolders[index]))
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
        ),
      ),
    );
  }
}
