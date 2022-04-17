import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final name;
  final assetImage;
  UserScreen({ Key? key, required this.assetImage, required this.name }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(name),
        centerTitle: true,
      ),
      body: Image.asset(assetImage,width: double.infinity,height:double.infinity),
    );
  }
}