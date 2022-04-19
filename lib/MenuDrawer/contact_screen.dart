import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Column(children: [
        Center(child: Text("Contact Screen")),
      ],)),
    );
  }
}