import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/presentation/on_boarding_screen.dart';
import 'package:visual_magic/presentation/splash_screen.dart';

// late var box;
late var userDB;
late Box<Favourites> favDB;
late Box<RecentModel> recentDB;
late Box<PlayListName> playListNameDB;
late Box<PlayListVideos> playListVideosDB;
late Box<WatchlaterModel> watchlaterDB;

late SharedPreferences sharedPref;

int? initScreen;

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(FavouritesAdapter());
    Hive.registerAdapter(RecentModelAdapter());
    Hive.registerAdapter(PlayListNameAdapter());
    Hive.registerAdapter(PlayListVideosAdapter());
    Hive.registerAdapter(WatchlaterModelAdapter());

  }
  userDB = await Hive.openBox('student_db');
  favDB = await Hive.openBox('fav_db');
  recentDB = await Hive.openBox('recent_db');
  playListNameDB = await Hive.openBox('playlist_name_db');
  playListVideosDB = await Hive.openBox('playlist_videos_db');
  watchlaterDB = await Hive.openBox('watchlater_db');

  sharedPref = await SharedPreferences.getInstance();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(2246, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
              color: Color(0xff1f1f55),
            )),
            initialRoute: initScreen == 0 || initScreen == null
                ? 'onBoardingScreen'
                : 'splashScreen',
            routes: {
              'onBoardingScreen': (context) => const OnBoardingScreen(),
              "splashScreen": (context) => const SplashScreen(),
            },
          );
        });
  }
}
