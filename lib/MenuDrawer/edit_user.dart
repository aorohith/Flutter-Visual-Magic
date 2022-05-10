import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_magic/db/Models/user_model.dart';
import 'package:visual_magic/main.dart';

UserModel _userData = userDB.values.toList()[0];

class EditUserScreen extends StatefulWidget {
  final name;
  String assetImage;
  EditUserScreen({Key? key, required this.assetImage, required this.name})
      : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _nameController = TextEditingController(text: _userData.name);

  final _emailController = TextEditingController(text: _userData.email);

  final _descriptionController =
      TextEditingController(text: _userData.description);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            child: widget.assetImage == 'assets/images/user.jpg'
                ? Image.asset(widget.assetImage)
                : Image.file(File(widget.assetImage)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: 320,
              height: 550,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "db email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "About",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: "db description",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: Text(
                        "SELECT IMAGE",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final XFile? photo =
                                              await _picker.pickImage(
                                                  source: ImageSource.camera);
                                          
                                          setState(() {
                                            widget.assetImage = photo!.path;
                                          });
                                        },
                                        child: Text(
                                          "Open Camera",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final XFile? photo =
                                              await _picker.pickImage(
                                                  source: ImageSource.gallery);

                                          setState(() {
                                            widget.assetImage = photo!.path;
                                          });
                                        },
                                        child: Text(
                                          "Open Gallery",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          updateUser();
                        },
                        child: Text("Update"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  updateUser() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final description = _descriptionController.text;
    final user = UserModel(
        name: name,
        email: email,
        imgPath: widget.assetImage,
        description: description);
    await userDB.put('user', user);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
