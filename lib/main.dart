import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/Main/splash_screen.dart';
import 'package:visual_magic/db/Models/Favourites/favourites_model.dart';
import 'package:visual_magic/db/Models/Recent/recent_model.dart';
import 'package:visual_magic/db/Models/user_model.dart';

// late var box;
late var userDB;
late var favDB;
late var recentDB;


void main() async {
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(FavouritesAdapter());
    Hive.registerAdapter(RecentModelAdapter());
  }
  userDB = await Hive.openBox('student_db');
  favDB = await Hive.openBox('fav_db');
  recentDB = await Hive.openBox('recent_db');

  // box = await Hive.openBox('fav_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(2246, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
          );
        });
  }
}
