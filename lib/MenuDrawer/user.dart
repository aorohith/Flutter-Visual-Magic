import 'package:flutter/material.dart';
import 'package:visual_magic/MenuDrawer/edit_user.dart';

class UserScreen extends StatelessWidget {
  final name;
  final assetImage;
  UserScreen({Key? key, required this.assetImage, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(assetImage),
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
                      "ROHITH A O",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "aorohith@gmail.com",
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
                      "Lorem Ipsum is simply dummy text of the printing typesetting industry. Look a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap",
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
                        assetImage: "assets/images/user.jpg",
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
