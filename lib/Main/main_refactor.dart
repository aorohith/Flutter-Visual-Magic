import 'package:flutter/material.dart';
import 'package:visual_magic/Screens/Playlist/playlist_refactor.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/Models/Favourites/favourites_model.dart';
import 'package:visual_magic/db/Models/Watchlater/watch_later_model.dart';
import 'package:visual_magic/db/functions.dart';
import 'package:visual_magic/main.dart';

//#################...Floating Video play Button..#############

Widget PlayButton(context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlay(
              videoLink: recentDB.isNotEmpty
                  ? recentDB.values.toList().last.recentPath
                  : fetchedVideosWithInfo.value.first.path),
        ),
      );
    },
    child: Icon(Icons.play_arrow),
  );
}


//###################...Favourites button Refactoring...########################

class Favourite extends StatefulWidget {
  String videoPath;
  int favIndex;
  Favourite({
    Key? key,
    required this.isPressed2,
    required this.videoPath,
    required this.favIndex,
  }) : super(key: key);

  bool isHighlighted = true;
  bool isPressed = true;
  bool isPressed2 = true;

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    if (favDB.values.isNotEmpty) {
        List<Favourites> favList = favDB.values.toList();
      var existingItem = favList.where(
          (itemToCheck) => itemToCheck.favVideo == widget.videoPath);
      if (existingItem.isEmpty) {
        widget.isPressed2 = true;
      } else {
        widget.isPressed2 = false;
      }
    }
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          widget.isHighlighted = !widget.isHighlighted;
        });
      },
      onTap: () {
        setState(() {
          widget.isPressed2 = !widget.isPressed2;
          if (!widget.isPressed2) {
            Favourites favObj = Favourites(favVideo: widget.videoPath);
            favDB.add(favObj);
          } else {
            favDB.deleteAt(widget.favIndex);
          }
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(widget.isHighlighted ? 0 : 2.5),
        height: widget.isHighlighted ? 50 : 45,
        width: widget.isHighlighted ? 50 : 45,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: widget.isPressed2
            ? Icon(
                Icons.favorite_border,
                color: Colors.black.withOpacity(0.6),
              )
            : Icon(
                Icons.favorite,
                color: Color(0xffED3030),
              ),
      ),
    );
  }
}

//###########...Popup for videos is Fav, watch later and all videos sec...#############

Widget optionPopup(
    {required context, required recentVideoPath, required index}) {
  bool isExists =
      checkWatchlater(recentVideoPath); //true if video not indb Else inDB
  final watchlaterModel = WatchlaterModel(laterPath: recentVideoPath);

  return Builder(builder: (context) {
    return Container(
      height: 200,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff060625),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff1F1F55),
              ),
              onPressed: () {
                playlistVideoPopup(
                    context: context, playlistVideoPath: recentVideoPath);
              },
              child: const Text(
                "Add to Playlist",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff1F1F55),
              ),
              onPressed: () {
                print("clicked");
                if (isExists) {
                  watchlaterDB.add(watchlaterModel);
                  Navigator.pop(context);
                } else {
                  // watchlaterDB.deleteAt(index);

                  deleteWatchlater(watchlaterModel);
                  Navigator.pop(context);
                }
              },
              child: isExists
                  ? Text(
                      "Add to Watch Later",
                      style: TextStyle(fontSize: 18),
                    )
                  : Text(
                      "Remove from Watchlater",
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff1F1F55),
              ),
              onPressed: () {},
              child: const Text(
                "Rename",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff1F1F55),
              ),
              onPressed: () {},
              child: const Text(
                "Delete",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

addWatchLater(WatchlaterModel value) {
  watchlaterDB.add(value);
}

checkWatchlater(String watchlaterVideoPath) {
  print(watchlaterVideoPath);
  if (watchlaterDB.isNotEmpty) {
    List<WatchlaterModel> watchlaterPaths = watchlaterDB.values.toList();
    final isExists = watchlaterPaths
        .where((itemToCheck) => itemToCheck.laterPath == watchlaterVideoPath);
    if (isExists.isEmpty) {
      return true; //no matching element found
    } else {
      return false; //matching element found in db
    }
  }
  return true;
}
