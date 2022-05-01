import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual_magic/MenuDrawer/edit_user.dart';
import 'package:visual_magic/main.dart';

class UserScreen extends StatelessWidget {

  UserScreen({Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List userData = box.get('user');
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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.red,
              child: Image.file(
                File(userData[3]),
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData[0],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData[1],
                      style: TextStyle(
                        fontSize: 15,
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
                    Text(
                      userData[2],
                      style: TextStyle(
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
                        assetImage: userData[3],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
