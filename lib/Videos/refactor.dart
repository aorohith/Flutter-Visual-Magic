import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/Main/main_refactor.dart';
import 'package:visual_magic/Main/showcase_inheritted.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/functions.dart';

//List tile for video listview builder

Widget getListView(
    {required index, required context, required videosWithIndex}) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlay(
            videoLink: videosWithIndex[index].path,
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
    leading: Image.asset("assets/images/download.jpeg"),
    title: Text(
      videosWithIndex[index].title,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      "10 Videos",
      style: TextStyle(color: Colors.white),
    ),
    trailing: index == 0
        ? Showcase(
            shapeBorder: const CircleBorder(),
            showcaseBackgroundColor: Colors.indigo,
            descTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
            key: KeysToBeInherited.of(context).key4,
            child: Favourites(),
            description: "Add to Favourites Here")
        : Favourites(),
  );
}

//Listtile ends here

class sortDropdown extends StatefulWidget {
  const sortDropdown({Key? key}) : super(key: key);

  @override
  State<sortDropdown> createState() => _sortDropdownState();
}

class _sortDropdownState extends State<sortDropdown> {
  String dropdownValue = 'A to Z';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        switch (newValue) {
          case "A to Z":
            sortAlphabetical();
            break;
          case "Duration":
            sortByDuration();
            break;
          case "Date":
            sortBySize();
            break;
          case "FileSize":
          // sortByDate();
        }
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['A to Z', 'Duration', 'Date', 'FileSize']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
