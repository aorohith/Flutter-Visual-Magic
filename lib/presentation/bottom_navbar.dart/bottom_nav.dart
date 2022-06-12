import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../application/videos/videos_bloc.dart';
import '../../infrastructure/functions/videos_with_info.dart';
import '../all_videos_screen/video_screen.dart';
import '../favourite_screen/favourites_screen.dart';
import '../folder_screen/folders_list_screen.dart';
import '../recent_screen/recent_screen.dart';
import '../showcase_widget/showcase_inheritted.dart';

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
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press back again to Exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
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
            color: Color(0xFF6D46BF),
            buttonBackgroundColor: Colors.white,
            backgroundColor: const Color(0xff060625),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              context.read<BottomNavBloc>().add(ChangePageEvent(pageNo: index));
            },
            letIndexChange: (index) => true,
          ),
          body: BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (context, state) {
              return _pages[state.index];
            },
          ),
        ),
      ),
    );
  }
}
