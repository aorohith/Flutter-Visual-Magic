import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visual_magic/presentation/favorite_screen/favorites_screen.dart';
import '../../application/videos/videos_bloc.dart';
import '../../core/colors/colors.dart';
import '../../infrastructure/functions/videos_with_info.dart';
import '../all_videos_screen/video_screen.dart';
import '../folder_screen/folders_list_screen.dart';
import '../recent_screen/recent_screen.dart';
import '../showcase_widget/showcase_inherited.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();
  final _key4 = GlobalKey();

  int _page = 0;

  final _pages = [
    HomeScreen(),
    const RecentScreen(),
    VideosScreen(),
    const FavoritesScreen(),
  ];

  @override
  void initState() {
    GetVideoInfo.getVideoWithInfo();

    super.initState();
  }

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        child: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            return Scaffold(
              bottomNavigationBar: Container(
                color: bottomNavBgColor,
                height: size.width * .155,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: size.width * .024),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context
                          .read<BottomNavBloc>()
                          .add(ChangePageEvent(pageNo: index));
                      _page = index;
                      // print(index);
                    },
                    splashColor: Colors.transparent,
                    highlightColor: const Color(0xff29215D),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: size.width * .014),
                        Icon(listOfIcons[index],
                            size: size.width * .076, color: bottomIconColor),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          margin: EdgeInsets.only(
                            top: index == _page ? 0 : size.width * .029,
                            right: size.width * .0422,
                            left: size.width * .0422,
                          ),
                          width: size.width * .153,
                          height: index == _page ? size.width * .014 : 0,
                          decoration: const BoxDecoration(
                            color: bottomSelectedIconColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: _pages[state.index],
            );
          },
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.folder,
    Icons.history,
    Icons.play_circle,
    Icons.favorite,
  ];
}
