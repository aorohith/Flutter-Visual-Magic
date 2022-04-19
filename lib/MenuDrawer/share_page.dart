import 'package:flutter/material.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Column(children: [
        Center(child: Text("Share App")),
      ],)),
    );
  }
}