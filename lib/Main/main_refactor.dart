import 'package:flutter/material.dart';
import 'package:visual_magic/Screens/Playlist/playlist_refactor.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/db/functions.dart';
import 'package:visual_magic/main.dart';

//#################...Floating Video play Button..#############

Widget playButton(context) {
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
    child: const Icon(Icons.play_arrow),
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
      var existingItem = favList
          .where((itemToCheck) => itemToCheck.favVideo == widget.videoPath);
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
            //delete the fav from db
            final Map<dynamic, Favourites> favMap = favDB.toMap();
            dynamic desiredKey;
            favMap.forEach((key, value) {
              if (value.favVideo == widget.videoPath) {
                desiredKey = key;
              }
            });
            favDB.delete(desiredKey);
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
            : const Icon(
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
        color: Color.fromARGB(255, 108, 99, 226),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 80,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 77, 77, 194),
              ),
              onPressed: () {
                playlistVideoPopup(
                    context: context, playlistVideoPath: recentVideoPath);
              },
              child: const Text(
                "Add to Playlist",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 77, 77, 194),
              ),
              onPressed: () {
                if (isExists) {
                  watchlaterDB.add(watchlaterModel);
                  Navigator.pop(context);
                } else {
                  deleteWatchlater(watchlaterModel);
                  Navigator.pop(context);
                }
              },
              child: isExists
                  ? const Text(
                      "Add to Watch Later",
                      style: TextStyle(fontSize: 20),
                    )
                  : const Text(
                      "Remove from Watchlater",
                      style: TextStyle(fontSize: 20),textAlign: TextAlign.center,
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
