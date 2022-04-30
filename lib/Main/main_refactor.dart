import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/Main/showcase_inheritted.dart';
import 'package:visual_magic/MenuDrawer/about_screen.dart';
import 'package:visual_magic/MenuDrawer/contact_screen.dart';
import 'package:visual_magic/MenuDrawer/feedback_screen.dart';
import 'package:visual_magic/MenuDrawer/share_page.dart';
import 'package:visual_magic/MenuDrawer/user.dart';
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
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animController;
  bool isForward = false;

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
    TextEditingController textController = TextEditingController();
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
        textController: textController,
        onSuffixTap: () {
          textController.clear();
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
  Favourites({
    Key? key,
    required this.isPressed2,
    required this.videoPath
  }) : super(key: key);

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
          addToFavList(widget.videoPath);
          print("this ${widget.isPressed2}");
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
                color: Colors.pink.withOpacity(1.0),
              ),
      ),
    );
  }
}

//###########...Popup for videos is Fav, watch later and all videos sec...#############

Widget optionPopup() {
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

//################...Menu Drawer section...################

class MenuDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final name = "Rohith";
  final email = "aorohith@gmail.com";

  MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 41, 62, 170),
        child: ListView(
          padding: padding,
          children: [
            buildHeader(
                assetImage: "assets/images/user.jpg",
                name: name,
                email: email,
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserScreen(
                        name: name,
                        assetImage: "assets/images/user.jpg",
                      ),
                    ),
                  );
                }),
            const Divider(
              color: Colors.white70,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                    text: "Share",
                    icon: Icons.share,
                    onClicked: () {
                      selectedItem(context, 0);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                      text: "Feedback",
                      icon: Icons.feedback_outlined,
                      onClicked: () {
                        selectedItem(context, 1);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                      text: "Contact",
                      icon: Icons.contact_support_outlined,
                      onClicked: () {
                        selectedItem(context, 2);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                      text: "About us",
                      icon: Icons.info,
                      onClicked: () {
                        selectedItem(context, 3);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text,
      required IconData icon,
      required VoidCallback onClicked}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 25,
      ),
      title: Text(
        text,
        style: TextStyle(color: color, fontSize: 18),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget buildHeader({
    required String assetImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(assetImage),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ShareScreen()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FeedbackScreen()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactScreen()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AboutScreen()));
        break;
    }
  }
}
