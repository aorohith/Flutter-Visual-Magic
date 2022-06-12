import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget emptyDisplay(String section) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No $section Found\nADD NOW",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Lottie.asset('assets/json/empty.json')
      ],
    ),
  );
}
