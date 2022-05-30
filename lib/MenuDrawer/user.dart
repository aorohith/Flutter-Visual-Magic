import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visual_magic/MenuDrawer/edit_user.dart';
import 'package:visual_magic/main.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ));
    var userData = userDB.get('user');
    return Scaffold(
        // backgroundColor: Colors.black,
        body: SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            color: Colors.blue,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.red,
              child: userData.imgPath == "assets/images/user.jpg"
                  ? Image.asset(
                      userData.imgPath,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(userData.imgPath),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 150,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                width: 320,
                height: 220,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData.email,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userData.description,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 350,
            child: CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => EditUserScreen(
                        name: "ff",
                        assetImage: userData.imgPath,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
