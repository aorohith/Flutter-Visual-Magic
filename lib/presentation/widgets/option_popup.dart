//###########...Popup for videos is Fav, watch later and all videos sec...#############

import 'package:flutter/material.dart';
import '../../db/Models/models.dart';
import '../../infrastructure/functions/watchlater_functions.dart';
import '../../main.dart';
import '../playlist_screen/widgets/playlist_video_popup.dart';

Widget optionPopup(
    {required context, required recentVideoPath, required index}) {
  bool isExists =
      checkWatchlater(recentVideoPath); //true if video not INDB Else inDB
  final watchlaterModel = WatchlaterModel(laterPath: recentVideoPath);

  return Builder(builder: (context) {
    return Container(
      height: 200,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 108, 99, 226),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 80,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 77, 77, 194),
              ),
              onPressed: () {
                playlistVideoPopup(
                    context: context, playlistVideoPath: recentVideoPath);
              },
              child: const Text(
                "Add to Playlist",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 77, 77, 194),
              ),
              onPressed: () {
                if (isExists) {
                  watchlaterDB.add(watchlaterModel);
                  Navigator.pop(context);
                } else {
                  deleteWatchlater(watchlaterModel);
                  Navigator.pop(context);
                }
              },
              child: isExists
                  ? const Text(
                      "Add to Watch Later",
                      style: TextStyle(fontSize: 20),
                    )
                  : const Text(
                      "Remove from Watchlater",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ],
      ),
    );
  });
}
