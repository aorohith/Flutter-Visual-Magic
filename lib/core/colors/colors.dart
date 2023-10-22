import 'package:flutter/material.dart';

//########...bottom nav bar...##########
Color bottomNavBgColor = const Color(0xff29215D);
const bottomIconColor = Colors.blue;
const bottomSelectedIconColor = Colors.blue;

//#########...screens...##########

//appbar
const appBarColor = Colors.transparent;
const appBarTitleColor = Color(0xff6D46BF);

//ListTile
const folderIconColor = Color.fromARGB(255, 201, 192, 192);
const listTitleColor = Colors.white;
const listSubTitleColor = Colors.white;
const listVerticalBtnColor = Color.fromARGB(255, 182, 181, 181);
const listColor = Color(0xff302D5D);


//body background color
BoxDecoration bgColor = const BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xff191B27),
      Color(0xff2C2166),
      Color(0xff29215D),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
