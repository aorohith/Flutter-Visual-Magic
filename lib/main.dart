import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/Main/splash_screen.dart';
import 'package:visual_magic/db/Models/video_model.dart';

Future<void> main() async{
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(VideoModelAdapter().typeId)){
    Hive.registerAdapter(VideoModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
  }
  await Hive.openBox('shopping_box');
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
