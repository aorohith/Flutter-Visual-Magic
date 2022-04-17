import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:visual_magic/FavouriteScreen/favourites_screen.dart';
import 'package:visual_magic/HomeScreen/home_screen.dart';
import 'package:visual_magic/RecentScreen/recent_screen.dart';
import 'package:visual_magic/Videos/video_screen.dart';


class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final _pages=[
    HomeScreen(),
    RecentScreen(),
    VideosScreen(),
    FavouritesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: [
            Icon(Icons.folder, size: 30),
            Icon(Icons.history, size: 30),
            Icon(Icons.play_circle,size: 30),
            Icon(Icons.favorite, size: 30),
          ],
          color: Color(0xff2C2C6D),
          buttonBackgroundColor: Colors.white,
          backgroundColor: Color(0xff060625),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _pages[_page]
        );
  }
}