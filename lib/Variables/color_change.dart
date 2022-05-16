import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visual_magic/Emptydisplay/empty_text.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/db/functions.dart';

// List<String>? _fetchedFolders;
Color bgColor = Color(0xff060625);

class ColorChangeScren extends StatefulWidget {
  @override
  State<ColorChangeScren> createState() => _ColorChangeScrenState();
}

class _ColorChangeScrenState extends State<ColorChangeScren> {
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
      floatingActionButton: PlayButton(context),
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Folders"),
        actions: [
          ElevatedButton(
            onPressed: () {
              print("Button Clicked"); //a test button for all purpose
              showDialog(
                  context: context, builder: (context) => ChangeColorPopup());
            },
            child: Text("Click"),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search)), //Search Refactor
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
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: updatedFolders.length,
                      itemBuilder: (BuildContext context, int index) {
                        getFolderVideos(
                            updatedFolders[index]); //for video count

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
                                    onTap: () {},
                                    leading: Icon(
                                      Icons.folder_outlined,
                                      size: 60,
                                      color: Colors.white,
                                    ),

                                    title: Text(
                                      updatedFolders[index].split('/').last,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ), //Turnery end here

                                    subtitle: Text(
                                      "${filteredFolderVideos.value.length} Videos",
                                      style: TextStyle(color: Colors.white),
                                    ),

                                    //Turnery operator
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        )),
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

  //pick

}

class ChangeColorPopup extends StatefulWidget {
  const ChangeColorPopup({Key? key}) : super(key: key);

  @override
  State<ChangeColorPopup> createState() => _ChangeColorPopupState();
}

class _ChangeColorPopupState extends State<ChangeColorPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change color"),
      content: Column(
        children: [
          ColorPicker(
              pickerColor: bgColor,
              onColorChanged: (newColor) => bgColor = newColor),
          TextButton(
            child: Text(
              "Select",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ColorChangeScren(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
