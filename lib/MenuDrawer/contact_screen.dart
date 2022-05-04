import 'package:flutter/material.dart';
import 'package:visual_magic/Videos/refactor.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [sortDropdown(),],),
      body: SafeArea(
        child: Column(children: [
        Center(child: Text("Contact Screen")),
      ],)),
    );
  }
}