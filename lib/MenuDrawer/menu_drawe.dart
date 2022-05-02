//################...Menu Drawer section...################

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual_magic/MenuDrawer/about_screen.dart';
import 'package:visual_magic/MenuDrawer/contact_screen.dart';
import 'package:visual_magic/MenuDrawer/feedback_screen.dart';
import 'package:visual_magic/MenuDrawer/share_page.dart';
import 'package:visual_magic/MenuDrawer/user.dart';
import 'package:visual_magic/main.dart';

class MenuDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final name = "User";
  final email = "sample@gmail.com";

  MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (box.get('user')[3] == null) {
      box.put('user', [
        'User',
        'sample@sample.com',
        'descriptiom',
        'assets/images/user.jpg'
      ]);
    }
    List userData = box.get('user');
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 41, 62, 170),
        child: ListView(
          padding: padding,
          children: [
            buildHeader(
                assetImages: userData[3],
                name: userData[0],
                email: userData[1],
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserScreen(),
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
    required String assetImages,
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
                backgroundImage: FileImage(File(
                    assetImages)), //assetImages!='assets/images/user.jpg' ?  : AssetImage(assetImages)
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
