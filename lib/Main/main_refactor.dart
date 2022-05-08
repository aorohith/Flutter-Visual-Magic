import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/Main/showcase_inheritted.dart';
import 'package:visual_magic/Playlist/playlist_refactor.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/functions.dart';

//#################...Flosting Video play Button..#############

Widget PlayButton(context) {
  return FloatingActionButton(
    onPressed: () {},
    child: IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VideoPlay()));
      },
      icon: const Icon(Icons.play_arrow, size: 30, color: Colors.white),
    ),
  );
}

//##################...Search Refactoring...####################

class Search extends StatefulWidget {
  String callFrom;
  Search({
    Key? key,
    required this.callFrom,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animController;
  bool isForward = false;
  List searchList = [];

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final curvedAnimation = CurvedAnimation(
      parent: animController!,
      curve: Curves.easeOutExpo,
    );
  }

  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return Showcase(
      shapeBorder: const CircleBorder(),
      showcaseBackgroundColor: Colors.indigo,
      descTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 16,
      ),
      key: KeysToBeInherited.of(context).key1,
      description: "You can Search here",
      child: AnimSearchBar(
        //search dependency
        width: 150,
        textController: _textController,
        onSuffixTap: () {},
        onChanged: () {
          setState(() {
            switch (widget.callFrom) {
              case "VideosScreen":
                fetchedVideosWithInfo.value = fetchedVideosWithInfo.value
                    .where((string) => string.title
                        .toLowerCase()
                        .contains(_textController.text.toLowerCase()))
                    .toList();
                    fetchedVideosWithInfo.notifyListeners();
                break;
              case "Favourites":
                searchList = favVideos.value;
                break;
              default:
            }
            print("setstate");
          });
        },
        suffixIcon: const Icon(Icons.search),
        color: const Color(0xff2C2C6D),
      ),
    );
  }
}

//###################...Favourites button Refactoring...########################

class Favourites extends StatefulWidget {
  bool isHighlighted = true;
  bool isPressed = true;
  bool isPressed2 = true;
  String videoPath;
  Favourites({Key? key, required this.isPressed2, required this.videoPath})
      : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          widget.isHighlighted = !widget.isHighlighted;
          print(" highlight ${widget.isHighlighted}");
        });
      },
      onTap: () {
        setState(() {
          widget.isPressed2 = !widget.isPressed2;
          if(!widget.isPressed2){
            addToFavList(widget.videoPath);
          }else{
            removeFromFav(widget.videoPath);
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

Widget optionPopup({required context, required recentVideoPath}) {
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
              playlistVideoPopup(context: context, playlistVideoPath: recentVideoPath);
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
            onPressed: () {},
            child: const Text(
              "Add to Watch Later",
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
}

