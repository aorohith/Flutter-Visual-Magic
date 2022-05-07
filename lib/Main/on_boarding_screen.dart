import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_magic/Main/splash_screen.dart';
import 'package:visual_magic/db/functions.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);


  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    splashFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        finishCallback: () async {
          await splashFetch();
          fetchFav();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SplashScreen())) ;
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/images/image1.png',
        title: 'PLAY',
        body: '',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/images/image2.png',
        title: 'WATCH',
        body: '',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/images/image3.png',
        title: 'AND',
        body: '',
        doAnimateImage: true),
    PageModel(
       color: const Color(0xFF5886d6),
        imageAssetPath: 'assets/images/image4.png',
        title: '!!!!ENJOY!!!!',
        body: '',
        doAnimateImage: true),
  ];
}