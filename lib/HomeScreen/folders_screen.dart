import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visual_magic/HomeScreen/folder_videos.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/db/functions.dart';

// List<String>? _fetchedFolders;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  void initState() {
    loadFolderList();
    
    // _fetchedFolders = getFolderList();
    // TODO: implement initState
    super.initState();
  }

  @override
  

  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MenuDrawer(),
      floatingActionButton: PlayButton(context),
      backgroundColor: Color(0xff060625),
      appBar: AppBar(
        title: Text("Folders"),
        actions: [
          // ElevatedButton(onPressed: (){
            
          // }, child: Text("Hai"),),
          Search(), //Search Refactor
        ],
        backgroundColor: Color(0xff1f1f55),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
          valueListenable: fetchedFolders,
          builder: (BuildContext ctx, List<String> updatedFolders, Widget? child) {
            return ListView.builder(
              padding: EdgeInsets.all(_w / 30),
              physics:
                  BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: updatedFolders.length,
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
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => FolderVideos(),),),
                            leading: Icon(
                              Icons.folder_outlined,
                              size: 60,
                              color: Colors.white,
                            ),
                            title: Text(
                              updatedFolders[index],
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "10 Videos",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
