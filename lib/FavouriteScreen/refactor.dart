import 'package:flutter/material.dart';
import 'package:visual_magic/db/functions.dart';

Widget favouritePopup(String value, BuildContext context) {
  return Container(
    height: 200,
    width: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff060625),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff1F1F55),
            ),
            onPressed: () {
              removeFromFav(value);
              Navigator.pop(context);
            },
            child: Text(
              "Remove from Favourite",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff1F1F55),
            ),
            onPressed: () {},
            child: Text(
              "Add to Watch Later",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff1F1F55),
            ),
            onPressed: () {},
            child: Text(
              "Rename",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff1F1F55),
            ),
            onPressed: () {},
            child: Text(
              "Delete",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    ),
  );
}