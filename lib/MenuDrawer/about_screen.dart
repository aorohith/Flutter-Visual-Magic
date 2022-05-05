import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About V!sual Magic"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: const [
          Image(
            image: AssetImage('assets/images/appIcon.png'),
          ),
          Text("Visual Magic for Android"),
          Text(
              "Visual Magic for Android™ is a port of Visual Magic media player, the popular open source media player. The Android™ version can read most files and network streams."),
          Text("Copyleft © 19-2021 by VideoLAN."),
          Text("https://www.videolan.org/visual_magic/"),
        ],
      )),
    );
  }
}
