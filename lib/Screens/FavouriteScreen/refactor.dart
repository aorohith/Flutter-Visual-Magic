import 'package:flutter/material.dart';
import 'package:visual_magic/main.dart';

Widget favouritePopup({required String value, required BuildContext context, required int favIndex}) {
  return Container(
    height: 200,
    width: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xff060625),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff1F1F55),
            ),
            onPressed: () {
              favDB.deleteAt(favIndex);
              Navigator.pop(context);
            },
            child: const Text(
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
              primary: const Color(0xff1F1F55),
            ),
            onPressed: () {},
            child: const Text(
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
              primary: const Color(0xff1F1F55),
            ),
            onPressed: () {},
            child: const Text(
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
              primary: const Color(0xff1F1F55),
            ),
            onPressed: () {},
            child: const Text(
              "Delete",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    ),
  );
}