//################...Menu Drawer section...################

import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:visual_magic/MenuDrawer/user.dart';
import 'package:visual_magic/Screens/Playlist/playlist_screen.dart';
import 'package:visual_magic/Screens/WatchLater/watch_later.dart';
import 'package:visual_magic/Variables/color_change.dart';
import 'package:visual_magic/db/Models/user_model.dart';
import 'package:visual_magic/main.dart';

class MenuDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final name = "User";
  final email = "sample@gmail.com";

  MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userDB.get('user') == null) {
      final user = UserModel(
          name: 'User',
          email: 'sample@sample.com',
          imgPath: 'assets/images/user.jpg',
          description: 'descriptiom');
      userDB.put('user', user);
    }
    var userData = userDB.get('user');
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 41, 62, 170),
        child: ListView(
          padding: padding,
          children: [
            buildHeader(
                assetImages: userData.imgPath,
                name: userData.name,
                email: userData.email,
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
                    text: "WatchLater",
                    icon: Icons.playlist_add_check,
                    onClicked: () {
                      selectedItem(context, 0);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                    text: "PlayLists",
                    icon: Icons.playlist_add_check,
                    onClicked: () {
                      selectedItem(context, 1);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                      text: "Share",
                      icon: Icons.share,
                      onClicked: () {
                        selectedItem(context, 2);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                      text: "Feedback",
                      icon: Icons.feedback_outlined,
                      onClicked: () {
                        selectedItem(context, 3);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                      text: "About Us",
                      icon: Icons.info,
                      onClicked: () {
                        selectedItem(context, 4);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                      text: "Version",
                      icon: Icons.adb,
                      subTitle: "1.0.0",
                      onClicked: () {
                        selectedItem(context, 5);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
    String subTitle = '',
  }) {
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
      subtitle: Text(
        subTitle,
        style: TextStyle(color: Colors.grey),
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
              assetImages == "assets/images/user.jpg"
                  ? CircleAvatar(backgroundImage: AssetImage(assetImages))
                  : CircleAvatar(
                      backgroundImage: FileImage(
                        File(
                          assetImages,
                        ),
                      ),
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
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => WatchLater(),
            
          ),
        );
        break;
      case 1:
      Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => Playlist(
              path: "path",
            ),
          ),
        );

        break;
      case 2:
      Navigator.pop(context);
        share();

        break;
      case 3:
      Navigator.pop(context);
        Navigator.pop(context);
        BetterFeedback.of(context).show((UserFeedback feedback) {});
        break;
      case 4:
      Navigator.pop(context);
        showAboutDialog(
            context: context,
            applicationIcon: Image(
              image: AssetImage('assets/images/appIcon.png'),
              height: 50,
              width: 50,
            ),
            applicationName: "V!sual Magic",
            applicationVersion: '1.0.1',
            children: [
              Text('V!sual Magic is a Video Player created by Rohith A O')
            ]);

        break;
      case 5:
      Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ColorChangeScren()) );
      break;
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'V!sual Magic',
        text:
            'I found a super useful music player app! You can try this out! Download it here:',
        linkUrl:
            'https://play.google.com/store/apps/details?id=mymusic.offlinemusicplayer.mp3player.playmusic&referrer=utm_source%3Duser_share',
        chooserTitle: 'Selecet Your App Here');
  }
}
