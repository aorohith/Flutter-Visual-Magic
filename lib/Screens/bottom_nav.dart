import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visual_magic/Main/showcase_inheritted.dart';
import 'package:visual_magic/Screens/FavouriteScreen/favourites_screen.dart';
import 'package:visual_magic/Screens/FolderScreen/folders_screen.dart';
import 'package:visual_magic/Screens/RecentScreen/recent_screen.dart';
import 'package:visual_magic/Screens/Videos/video_screen.dart';
import 'package:visual_magic/db/functions.dart';

var globalData;

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();
  final _key4 = GlobalKey();



  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final _pages = [
    HomeScreen(),
    const RecentScreen(),
    VideosScreen(),
    const FavouritesScreen(),
  ];

@override
  void initState() {
    getVideoWithInfo();

    // TODO: implement initState
    super.initState();
  }

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if(isExitWarning){
          const message = 'Press back again to Exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        }else{
          Fluttertoast.cancel();
          return true;
        }
      },
      child: KeysToBeInherited(
        key1: _key1,
        key2: _key2,
        key3: _key3,
        key4: _key4,
        child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 60.0,
              items: const [
                Icon(Icons.folder, size: 30),
                Icon(Icons.history, size: 30),
                Icon(Icons.play_circle, size: 30),
                Icon(Icons.favorite, size: 30),
              ],
              color:const Color.fromARGB(255, 81, 73, 150),
              buttonBackgroundColor: Colors.white,
              backgroundColor: const Color(0xff060625),
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  _page = index;
                });
              },
              letIndexChange: (index) => true,
            ),
            body: _pages[_page]),
      ),
    );
  }
}
