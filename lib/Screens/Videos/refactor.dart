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
              backgroundColor: const Color.fromARGB(15, 255, 255, 255),
              content: optionPopup(
                  context: context,
                  recentVideoPath: videosWithIndex[index].path,
                  index: index),
            );
          });
    },
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 50,
        width: 80,
        child: Image.asset("assets/images/download.jpeg"),
      ),
    ),
    title: Text(
      videosWithIndex[index].title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      formatTime(videosWithIndex[index].duration),
      style: const TextStyle(color: Colors.white),
    ),
    trailing: index == 0
        ? Showcase(
            shapeBorder: const CircleBorder(),
            showcaseBackgroundColor: Colors.indigo,
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
            key: KeysToBeInherited.of(context).key4,
            child: Favourite(
              favIndex: index,
              videoPath: videosWithIndex[index].path,
              isPressed2: favVideos.value.contains(videosWithIndex[index].path)
                  ? false
                  : true,
            ),
            description: "Add to Favourites Here")
        : Favourite(
            favIndex: index,
            isPressed2: favVideos.value.contains(videosWithIndex[index].path)
                ? false
                : true,
            videoPath: videosWithIndex[index].path,
          ),
  );
}

//Listtile ends here

class SortDropdown extends StatefulWidget {
  const SortDropdown({Key? key}) : super(key: key);

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  String dropdownValue = 'Duration';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        // iconEnabledColor: Colors.white,
        // focusColor: Colors.red,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: Colors.black,
        value: dropdownValue,
        icon: const Icon(Icons.sort),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: (String? newValue) {
          switch (newValue) {
            case "A to Z":
              sortAlphabetical();
              break;
            case "Duration":
              sortByDuration();
              break;
            case "Date":
              sortByDate();
              break;
            case "FileSize":
              sortBySize();
          }
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: ['A to Z', 'Duration', 'Date', 'FileSize'].map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
