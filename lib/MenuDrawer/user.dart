import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_magic/db/Models/video_model.dart';
import 'package:visual_magic/db/functions.dart';

class UserScreen extends StatefulWidget {
  final name;
  final assetImage;

  UserScreen({Key? key, required this.assetImage, required this.name})
      : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  File? image;
  var imagePath;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

@override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print(image);
              final value = UserModel(
                name: _nameController.text,
                email: _emailController.text,
                image: image.toString,
              );
              saveUserData(value);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: image != null
                  ? Image.file(
                      File(imagePath),
                      width: 160,
                      height: 160,
                    )
                  : FlutterLogo(
                      size: 160,
                    ),
            ),
            IconButton(
              iconSize: 30,
              focusColor: Colors.white,
              onPressed: () {
                imagePick();
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: _nameController,
            ),
            TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: _emailController,
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
  Future<void> imagePick() async {
    final temps = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() async{
      
      this.imagePath = temps!.path;
    });
  }

  getDataPressed(){
    var values = getData();
    print(values);
  }
}
